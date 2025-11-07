import requests
import json
import os
import re
import time
from bs4 import BeautifulSoup

# --- BƯỚC 1: ĐIỀN THÔNG TIN CỦA BẠN VÀO ĐÂY ---

# Đặt tên file JSON bạn đã xuất ra.
# (Script này giả định file đó nằm CÙNG THƯ MỤC với file .py này)
COOKIE_JSON_FILE = "cookies.json" 

# Tổng số bài tập (để an toàn, ta lấy 500)
TOTAL_PROBLEMS_TO_FETCH = 500

# URL API (đã xác nhận)
API_LIST_URL = "https://dbapi.ptit.edu.vn/api/app/question/search"

# URL cơ sở của trang chi tiết (đã xác nhận)
BASE_DETAIL_URL = "https://db.ptit.edu.vn/question-detail/"

# Thư mục để lưu file .txt
OUTPUT_DIR = "output"

# ⭐️ QUAN TRỌNG: Chỉ cần điền "Authorization"
# Dán toàn bộ giá trị "Bearer ..." của bạn vào đây
AUTH_TOKEN = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJmaXJzdE5hbWUiOiJUcuG6p24gWHXDom4iLCJsYXN0TmFtZSI6IlRow6BuaCIsInN1YiI6IjY4M2VlNTY4LWM3OGYtNGZjYi05ZWQ2LTMxN2VmYTllOTk3MSIsInJvbGUiOiJTVFVERU5UIiwidXNlclByZWZpeCI6ImVkVGF6eSIsInRva2VuVHlwZSI6ImFjY2Vzc1Rva2VuIiwiZXhwIjoxNzYyNTIxNDg4LCJpYXQiOjE3NjI1MTQyODgsInVzZXJDb2RlIjoiQjIzRENBVDI4MCIsInByb3ZpZGVyVHlwZSI6IkxPQ0FMIiwidXNlcm5hbWUiOiJCMjNEQ0FUMjgwIiwic2Vzc2lvblByZWZpeCI6IjM4ZWY5aTE1c2hoayJ9.FeExx8LdaVoUe823kwHxrNjRomDv3s1w_-GrFCA2bRk'


# --- KẾT THÚC PHẦN ĐIỀN THÔNG TIN ---


def load_cookies_from_json(json_file_path):
    """Đọc file JSON cookie và chuyển thành chuỗi (string) header."""
    print(f"Đang tải cookies từ file: {json_file_path}")
    try:
        with open(json_file_path, 'r', encoding='utf-8') as f:
            cookies_list = json.load(f)
        
        # Chuyển đổi list JSON thành định dạng string "name=value; name2=value2"
        cookie_strings = []
        for cookie in cookies_list:
            # Chỉ lấy cookie cho đúng domain (nếu có)
            # Bạn có thể bỏ qua check 'domain' nếu file JSON của bạn không có
            if 'domain' in cookie and 'ptit.edu.vn' not in cookie['domain']:
                continue
            cookie_strings.append(f"{cookie['name']}={cookie['value']}")
            
        cookie_header_string = "; ".join(cookie_strings)
        
        if not cookie_header_string:
            print("[CẢNH BÁO] Không tìm thấy cookie phù hợp trong file JSON.")
            return None
            
        print("Tải cookie thành công.")
        return cookie_header_string
        
    except FileNotFoundError:
        print(f"[LỖI NGHIÊM TRỌNG] Không tìm thấy file '{json_file_path}'.")
        print("Vui lòng đảm bảo file cookie nằm cùng thư mục với script.")
        return None
    except json.JSONDecodeError:
        print(f"[LỖI] File '{json_file_path}' không phải là file JSON hợp lệ.")
        return None
    except KeyError:
        print("[LỖI] Cấu trúc file JSON không đúng (thiếu 'name' hoặc 'value').")
        return None

def sanitize_filename(name):
    """Xóa các ký tự không hợp lệ khỏi tên file."""
    name = name.replace("/", "-")
    return re.sub(r'[\\*?:"<>|]', "", name).strip()


def _sanitize_http_header_value(value: str) -> str:
    """Ensure a header value is safe for http.client/urllib3 which expect latin-1.

    - If the value already encodes to latin-1, return it unchanged.
    - Replace common problematic characters (ellipsis) with safe alternatives.
    - As a last resort, encode with 'replace' to avoid raising UnicodeEncodeError.
    """
    if not isinstance(value, str):
        return value

    try:
        value.encode('latin-1')
        return value
    except UnicodeEncodeError:
        # Replace common Unicode characters that often appear in copy-pasted tokens
        # (e.g. ellipsis U+2026). Add more replacements here if needed.
        replaced = value.replace('\u2026', '...')

        # If still not latin-1, fall back to lossy replacement to guarantee safety.
        try:
            replaced.encode('latin-1')
            return replaced
        except UnicodeEncodeError:
            return replaced.encode('latin-1', 'replace').decode('latin-1')


def sanitize_headers_for_http(headers: dict) -> dict:
    """Return a copy of headers where all string values are safe for latin-1.

    Also prints a small notice if any header values were changed.
    """
    out = {}
    changed_keys = []
    for k, v in headers.items():
        if isinstance(v, str):
            new_v = _sanitize_http_header_value(v)
            out[k] = new_v
            if new_v != v:
                changed_keys.append(k)
        else:
            out[k] = v

    if changed_keys:
        print(f"[NOTICE] Sanitized non-latin-1 characters in headers: {', '.join(changed_keys)}")

    return out

def scrape_problem_details(uuid, session):
    """Lấy nội dung chi tiết của một bài tập từ UUID của nó."""
    detail_url = f"{BASE_DETAIL_URL}{uuid}"
    try:
        response = session.get(detail_url) 
        if response.status_code != 200:
            print(f"  [LỖI] Không tải được trang {uuid}. Status: {response.status_code}")
            return None
        soup = BeautifulSoup(response.text, 'html.parser')
        content_div = soup.find('div', class_='dblabcode-content')
        if not content_div:
            print(f"  [LỖI] Không tìm thấy 'dblabcode-content' trong {uuid}")
            return None
        return content_div.get_text(separator='\n', strip=True)
    except requests.RequestException as e:
        print(f"  [LỖI] Request đến {uuid} thất bại: {e}")
        return None

def fetch_all_problems(headers):
    """Gọi API một lần duy nhất để lấy toàn bộ danh sách bài tập."""
    print(f"Đang gọi API để lấy danh sách {TOTAL_PROBLEMS_TO_FETCH} bài tập...")
    
    params = {
        "page": 0,
        "size": TOTAL_PROBLEMS_TO_FETCH,
        "sort": "createdAt,desc"
    }
    
    session = requests.Session()
    # Sanitize headers to ensure values are safe for latin-1 encoding
    safe_headers = sanitize_headers_for_http(headers)
    session.headers.update(safe_headers)
    
    try:
        response = session.get(API_LIST_URL, params=params)
        
        if response.status_code == 401:
            print("[LỖI NGHIÊM TRỌNG] Lỗi 401 Unauthorized.")
            print("Token 'Authorization' hoặc 'Cookie' của bạn đã sai hoặc hết hạn.")
            print("Vui lòng đăng nhập lại web, mở DevTools (F12) và copy lại giá trị mới.")
            return None, None
            
        if response.status_code != 200:
            print(f"Lỗi khi gọi API! Status: {response.status_code}")
            print(response.text)
            return None, None

        data = response.json()
        problems = data.get('content')
        
        if problems is None:
            print("Lỗi: Không tìm thấy key 'content' trong JSON trả về.")
            return None, None
            
        print(f"Thành công! Lấy được thông tin của {len(problems)} bài tập.")
        return problems, session

    except requests.RequestException as e:
        print(f"Request đến API thất bại: {e}")
        return None, None
    except json.JSONDecodeError:
        print("Lỗi: Không thể giải mã JSON từ API.")
        return None, None

def main():
    # 1. Tải cookie từ file JSON
    cookie_string = load_cookies_from_json(COOKIE_JSON_FILE)
    if cookie_string is None:
        print("Không thể tải cookie. Đang dừng chương trình.")
        return

    # 2. Xây dựng Headers
    headers = {
        "Authorization": AUTH_TOKEN,
        "Cookie": cookie_string,
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.0.0 Safari/537.36"
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
            
            if not all([uuid, code, title]):
                print(f"Bỏ qua bài {i}/{total}: Thiếu thông tin.")
                continue

            print(f"[{i}/{total}] Đang xử lý: {code} - {title}")
            
            filename = sanitize_filename(f"{code} - {title}.txt")
            filepath = os.path.join(OUTPUT_DIR, filename)
            
            if os.path.exists(filepath):
                print(f"  -> Đã tồn tại, bỏ qua.")
                continue

            content = scrape_problem_details(uuid, session)
            
            if content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(f"ID: {code}\n")
                    f.write(f"Tiêu đề: {title}\n")
                    f.write(f"URL: {BASE_DETAIL_URL}{uuid}\n")
                    f.write("-" * 30 + "\n\n")
                    f.write(content)
                print(f"  -> Đã lưu vào: {filepath}")
            
            time.sleep(0.5) 

        except Exception as e:
            print(f"  [LỖI] Xảy ra lỗi ngoài dự kiến khi xử lý bài {uuid}: {e}")
            
    print("\nHoàn tất! Tất cả bài tập đã được tải về.")

if __name__ == "__main__":
    main()