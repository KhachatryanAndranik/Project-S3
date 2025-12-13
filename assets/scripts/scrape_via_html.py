import json
import re
from urllib.parse import quote_plus

import requests
from bs4 import BeautifulSoup

URL = "https://www.gutenberg.org/browse/scores/top"
OUT_FILE = "books_via_html.json"


def clean(s: str) -> str:
    return re.sub(r"\s+", " ", (s or "")).strip()


def parse_title_author(text: str):
    """
    Project Gutenberg top list items often look like:
      "Frankenstein; Or, The Modern Prometheus by Mary Wollstonecraft Shelley"
    We'll split on the last " by " occurrence.
    """
    text = clean(text)
    if " by " in text:
        title, author = text.rsplit(" by ", 1)
        return clean(title), clean(author)
    return text, None


def openlibrary_cover_from_title_author(title: str, author: str | None):
    """
    Best-effort cover lookup via Open Library Search API.
    (Still an HTML-scrape pipeline overall; this is just for cover enrichment.)
    """
    q = title if not author else f"{title} {author}"
    r = requests.get(
        "https://openlibrary.org/search.json",
        params={"q": q, "limit": 1, "fields": "cover_i"},
        timeout=30,
    )
    r.raise_for_status()
    docs = r.json().get("docs", [])
    if not docs:
        return None
    cover_i = docs[0].get("cover_i")
    if not cover_i:
        return None
    return f"https://covers.openlibrary.org/b/id/{cover_i}-L.jpg"


def scrape_gutenberg_top100():
    html = requests.get(
        URL,
        headers={"User-Agent": "Mozilla/5.0"},
        timeout=30,
    ).text
    soup = BeautifulSoup(html, "html.parser")

    h2 = soup.find(lambda t: t.name in ["h2", "h3"] and "Top 100 EBooks yesterday" in t.get_text())
    if not h2:
        raise RuntimeError("Could not find the 'Top 100 EBooks yesterday' section.")

    ol = h2.find_next("ol")
    if not ol:
        raise RuntimeError("Could not find the ordered list of books.")

    books = []
    for li in ol.find_all("li", recursive=False):
        a = li.find("a", href=True)
        if not a:
            continue

        title, author = parse_title_author(a.get_text(" ", strip=True))
        book_url = "https://www.gutenberg.org" + a["href"]

        cover_image = openlibrary_cover_from_title_author(title, author)

        books.append(
            {
                "title": title,
                "author": author,
                "cover_image": cover_image,
                "source_url": book_url,
            }
        )

    return books


def main():
    books = scrape_gutenberg_top100()
    with open(OUT_FILE, "w", encoding="utf-8") as f:
        json.dump(books, f, ensure_ascii=False, indent=2)
    print(f"Wrote {len(books)} books to {OUT_FILE}")


if __name__ == "__main__":
    main()