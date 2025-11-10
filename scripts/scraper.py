import requests
import json
import os
import re
import time
from bs4 import BeautifulSoup

# --- BƯỚC 1: ĐIỀN THÔNG TIN CỦA BẠN VÀO ĐÂY ---

# Đảm bảo tên file này khớp với file cookie bạn đã xuất ra
COOKIE_JSON_FILE = "cookies.json" 

# Tổng số bài tập (để an toàn, ta lấy 500)
TOTAL_PROBLEMS_TO_FETCH = 500

# URL API tìm kiếm danh sách câu hỏi (trả về mảng có trường 'content')
API_LIST_URL = "https://dbapi.ptit.edu.vn/api/app/question"

# URL API chi tiết câu hỏi (JSON) dạng: https://dbapi.ptit.edu.vn/api/app/question/{uuid}
API_DETAIL_URL_BASE = "https://dbapi.ptit.edu.vn/api/app/question/"

# URL cơ sở của trang chi tiết (đã xác nhận)
BASE_DETAIL_URL = "https://db.ptit.edu.vn/question-detail/"

# Thư mục để lưu file .txt
OUTPUT_DIR = "problems"

debug_file_saved = False

# --- BẠN KHÔNG CẦN SỬA GÌ BÊN DƯỚI NỮA ---


def load_auth_and_cookies(json_file_path):
    """
    Đọc file JSON cookie.
    Tách riêng 'access_token' để làm Authorization header.
    Gộp phần còn lại vào Cookie header.
    """
    print(f"Đang tải cookies từ file: {json_file_path}")
    try:
        with open(json_file_path, 'r', encoding='utf-8') as f:
            cookies_list = json.load(f)
        
        auth_token_value = None
        other_cookie_strings = []
        
        for cookie in cookies_list:
            # 1. Tìm access_token
            if cookie['name'] == 'access_token':
                auth_token_value = cookie['value']
            
            # 2. Gộp tất cả (bao gồm cả access_token) vào chuỗi cookie
            #    Một số hệ thống cần cả hai, làm vậy sẽ an toàn hơn
            other_cookie_strings.append(f"{cookie['name']}={cookie['value']}")
            
        if not auth_token_value:
            print("[LỖI NGHIÊM TRỌNG] Không tìm thấy 'access_token' trong file cookie.")
            return None, None
            
        # Định dạng "Bearer <token>"
        auth_header = f"Bearer {auth_token_value}"
        
        # Định dạng "cookie1=value1; cookie2=value2"
        cookie_header = "; ".join(other_cookie_strings)
        
        print("Tải Authorization và Cookie thành công.")
        return auth_header, cookie_header
        
    except FileNotFoundError:
        print(f"[LỖI] Không tìm thấy file '{json_file_path}'.")
        return None, None
    except Exception as e:
        print(f"[LỖI] Xảy ra lỗi khi đọc file cookie: {e}")
        return None, None

def sanitize_filename(name):
    """Xóa các ký tự không hợp lệ khỏi tên file."""
    name = name.replace("/", "-")
    return re.sub(r'[\\*?:"<>|]', "", name).strip()

def scrape_problem_details(uuid, session):
    """Gọi API JSON để lấy chi tiết một bài tập, trả về text (HTML nguyên bản)."""
    api_detail_url = f"{API_DETAIL_URL_BASE}{uuid}"
    try:
        resp = session.get(api_detail_url)
        if resp.status_code == 401:
            print("  [LỖI] 401 Unauthorized khi lấy chi tiết. Token đã hết hạn.")
            return None
        if resp.status_code == 404:
            print("  [LỖI] 404 Không tìm thấy câu hỏi.")
            return None
        if resp.status_code != 200:
            print(f"  [LỖI] API chi tiết trả về {resp.status_code}")
            return None

        try:
            data = resp.json()
        except json.JSONDecodeError:
            print("  [LỖI] JSON chi tiết không hợp lệ.")
            return None

        # Dữ liệu thực tế có thể là dạng { ..., 'content': '<p>HTML</p>' }
        # hoặc lồng sâu hơn. Ta thử nhiều khả năng.
        html_content = None
        if isinstance(data, dict):
            # Trường hợp phổ biến
            if 'content' in data and isinstance(data['content'], str):
                html_content = data['content']
            # Nếu backend trả về dạng { 'data': { 'content': '...' } }
            elif 'data' in data and isinstance(data['data'], dict) and isinstance(data['data'].get('content'), str):
                html_content = data['data']['content']

        if not html_content:
            print("  [LỖI] Không tìm thấy trường 'content' trong JSON chi tiết.")
            return None

        # Trả về HTML nguyên bản để lưu
        return html_content.strip()
    except requests.RequestException as e:
        print(f"  [LỖI] Request chi tiết lỗi: {e}")
        return None

def _sanitize_http_header_value(value: str) -> str:
    """Đảm bảo header value encode được latin-1 (tránh UnicodeEncodeError)."""
    if not isinstance(value, str):
        return value
    try:
        value.encode('latin-1')
        return value
    except UnicodeEncodeError:
        replaced = value.replace('\u2026', '...')
        try:
            replaced.encode('latin-1')
            return replaced
        except UnicodeEncodeError:
            return replaced.encode('latin-1', 'replace').decode('latin-1')


def sanitize_headers_for_http(headers: dict) -> dict:
    out, changed = {}, []
    for k, v in headers.items():
        if isinstance(v, str):
            new_v = _sanitize_http_header_value(v)
            out[k] = new_v
            if new_v != v:
                changed.append(k)
        else:
            out[k] = v
    if changed:
        print(f"[NOTICE] Đã chuẩn hóa ký tự lạ trong header: {', '.join(changed)}")
    return out


def fetch_all_problems(headers):
    """Gọi API search để lấy danh sách bài tập (một trang lớn)."""
    print(f"Đang gọi API để lấy danh sách tối đa {TOTAL_PROBLEMS_TO_FETCH} bài tập...")

    params = {
        "page": 0,
        "size": TOTAL_PROBLEMS_TO_FETCH,
        "sort": "createdAt,desc"
    }

    session = requests.Session()
    session.headers.update(sanitize_headers_for_http(headers))

    try:
        response = session.get(API_LIST_URL, params=params)

        if response.status_code == 401:
            print("[LỖI] 401 Unauthorized. Token / cookie hết hạn.")
            return None, None
        if response.status_code == 400:
            print("[LỖI] 400 Bad Request. Tham số có thể sai.")
            print("Response:", response.text[:500])
            return None, None
        if response.status_code != 200:
            print(f"[LỖI] API search trả về {response.status_code}")
            print(response.text[:500])
            return None, None

        try:
            data = response.json()
        except json.JSONDecodeError:
            print("[LỖI] JSON trả về từ API search không hợp lệ.")
            return None, None

        problems = data.get('content')
        if problems is None:
            print("[LỖI] Không thấy key 'content' trong JSON search.")
            return None, None

        print(f"Thành công! Nhận {len(problems)} bài tập.")
        return problems, session
    except requests.RequestException as e:
        print(f"[LỖI] Request search thất bại: {e}")
        return None, None

def main():
    # 1. Tải cookie và auth token từ file JSON
    auth_header, cookie_header = load_auth_and_cookies(COOKIE_JSON_FILE)
    
    if auth_header is None or cookie_header is None:
        print("Không thể tải thông tin xác thực. Đang dừng chương trình.")
        return

    # 2. Xây dựng Headers
    headers = {
        "Authorization": auth_header,
        "Cookie": cookie_header,
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.0.0 Safari/537.36",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    
    # 3. Lấy danh sách bài tập
    problems, session = fetch_all_problems(headers)
    
    if not problems:
        print("Không thể lấy danh sách bài tập. Đang dừng chương trình.")
        return

    # 4. Tạo thư mục
    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        print(f"Đã tạo thư mục: {OUTPUT_DIR}")

    total = len(problems)
    print(f"\nBắt đầu tải chi tiết và lưu {total} bài tập...")

    # 5. Lặp và tải
    for i, problem in enumerate(problems, 1):
        try:
            uuid = problem.get('id')
            code = problem.get('questionCode')
            title = problem.get('title')
            database_type = problem.get('questionDetails')[0]['typeDatabase']['name']
            
            if not all([uuid, code, title]):
                print(f"Bỏ qua bài {i}/{total}: Thiếu thông tin.")
                continue

            print(f"[{i}/{total}] Đang xử lý: {code} - {title}")
            
            filename = sanitize_filename(f"{code} - {title}.html")
            filepath = os.path.join(OUTPUT_DIR, filename)
            
            if os.path.exists(filepath):
                print(f"  -> Đã tồn tại, bỏ qua.")
                continue

            content_html = scrape_problem_details(uuid, session)
            if not content_html:
                continue

            # Lưu trực tiếp HTML hoặc chuyển sang text thuần nếu muốn.
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(f"ID: {code}\n")
                f.write(f"Tiêu đề: {title}\n")
                f.write(f"URL WEB: {BASE_DETAIL_URL}{uuid}\n")
                f.write(f"URL API: {API_DETAIL_URL_BASE}{uuid}\n")
                f.write(f"Loại Database: {database_type}\n")
                f.write("-" * 30 + "\n\n")
                f.write(content_html)
            print(f"  -> Đã lưu vào: {filepath}")
            
            time.sleep(0.3) # Giảm tốc độ để tôn trọng server

        except Exception as e:
            print(f"  [LỖI] Xảy ra lỗi ngoài dự kiến khi xử lý bài {uuid}: {e}")
            
    print("\nHoàn tất! Tất cả bài tập đã được tải về.")

if __name__ == "__main__":
    main()