import json
from urllib.parse import urlencode

import requests

OUT_FILE = "books_via_api.json"

def cover_url(cover_i: int | None, size="L") -> str | None:
    if not cover_i:
        return None
    return f"https://covers.openlibrary.org/b/id/{cover_i}-{size}.jpg"

def search_openlibrary(query: str, limit: int = 50):
    params = {
        "q": query,
        "limit": limit,
        "fields": "title,author_name,cover_i,key",
    }
    url = f"https://openlibrary.org/search.json?{urlencode(params)}"
    r = requests.get(url, timeout=30)
    r.raise_for_status()
    return r.json()["docs"]

def main():
    docs = search_openlibrary("science", limit=50)

    books = []
    for d in docs:
        title = d.get("title")
        authors = d.get("author_name") or []
        author = authors[0] if authors else None
        cover = cover_url(d.get("cover_i"))

        books.append(
            {
                "title": title,
                "author": author,
                "cover_image": cover,
                "openlibrary_key": d.get("key"),
            }
        )

    with open(OUT_FILE, "w", encoding="utf-8") as f:
        json.dump(books, f, ensure_ascii=False, indent=2)

    print(f"Wrote {len(books)} books to {OUT_FILE}")

if __name__ == "__main__":
    main()