"""Replace specific base64-embedded PNG images in HTML files with a hosted URL.

This script searches files (by default under `problems/`) for tags like:
	src="data:image/png;base64,...Jggg=="
and replaces the whole src attribute value with the provided hosted image URL while
preserving surrounding quotes.

Features:
 - Dry-run mode to preview replacements without modifying files
 - Optional backup of modified files (adds .bak timestamped copy)
 - Works recursively under a directory and supports configurable extensions

Usage examples:
  # Preview changes (no write)
  python replace_images.py --dir problems --dry-run

  # Apply changes (creates .bak copies)
  python replace_images.py --dir problems --apply --backup

  # Apply changes without backups
  python replace_images.py --dir problems --apply

"""
from __future__ import annotations

import argparse
from pathlib import Path
import re
import shutil
import datetime
from typing import Iterable


DEFAULT_URL = "img/47 56 bo 54.png"


def iter_files(root: Path, exts: Iterable[str]) -> Iterable[Path]:
	for p in root.rglob("*"):
		if p.is_file() and p.suffix.lower() in exts:
			yield p


def replace_in_text(text: str, replacement_url: str) -> tuple[str, int]:
	"""Replace src="data:image/png;base64,...Jggg==" patterns with hosted URL.

	Returns (new_text, count_of_replacements)
	"""
	# Match: src = "data:image/png;base64, ... Jggg==" or single quotes; non-greedy match
	pattern = re.compile(r"(src\s*=\s*)([\"'])data:image/png;base64,.*?Jggg==\2", re.IGNORECASE | re.DOTALL)
	repl = r"\1\2" + replacement_url + r"\2"
	new_text, n = pattern.subn(repl, text)
	return new_text, n


def backup_file(path: Path) -> Path:
	stamp = datetime.datetime.now().strftime("%Y%m%dT%H%M%S")
	bak = path.with_suffix(path.suffix + f".bak.{stamp}")
	shutil.copy2(path, bak)
	return bak


def main(*, root: Path, replacement_url: str, dry_run: bool, do_apply: bool, exts: list[str], verbose: bool, backup: bool):
	files = list(iter_files(root, set(exts)))
	total_replacements = 0
	touched_files = 0
	for p in files:
		try:
			text = p.read_text(encoding="utf-8")
		except Exception:
			if verbose:
				print(f"Skipping unreadable file: {p}")
			continue
		new_text, n = replace_in_text(text, replacement_url)
		if n:
			total_replacements += n
			touched_files += 1
			print(f"{p}: {n} replacement(s)")
			if do_apply:
				if backup:
					bak = backup_file(p)
					if verbose:
						print(f"  -> wrote updated file and backup at {bak.name}")
				else:
					if verbose:
						print("  -> wrote updated file (no backup)")
				p.write_text(new_text, encoding="utf-8")
			else:
				if verbose:
					print("  -> dry-run: no file written")
		else:
			if verbose:
				print(f"{p}: no matches")

	print(f"Summary: touched files={touched_files}, total replacements={total_replacements}")


if __name__ == "__main__":
	parser = argparse.ArgumentParser(description="Replace embedded data:image/png;base64 images ending with Jggg== with a hosted URL")
	parser.add_argument("--dir", default="problems", help="Root directory to search (default: problems)")
	parser.add_argument("--url", default=DEFAULT_URL, help="Hosted image URL to replace with")
	parser.add_argument("--apply", action="store_true", help="Apply changes to files. Use --backup to create backups. If not set, runs as dry-run")
	parser.add_argument("--dry-run", action="store_true", help="Alias for running without --apply; default if --apply not set")
	parser.add_argument("--ext", action="append", default=[".html"], help="File extensions to include (can be repeated). Default: .html")
	parser.add_argument("--verbose", action="store_true", help="Print verbose output for every file")
	parser.add_argument("--backup", action="store_true", help="Create .bak timestamped copies of modified files (only with --apply)")
	args = parser.parse_args()

	root_path = Path(args.dir)
	if not root_path.exists():
		print(f"Error: directory does not exist: {root_path}")
		raise SystemExit(2)

	# default behavior: dry-run unless --apply passed
	do_apply = bool(args.apply)
	dry_run = not do_apply

	exts = [e if e.startswith(".") else "." + e for e in args.ext]

	main(root=root_path, replacement_url=args.url, dry_run=dry_run, do_apply=do_apply, exts=exts, verbose=args.verbose, backup=args.backup)

