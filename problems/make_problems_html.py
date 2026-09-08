#!/usr/bin/env python
r"""Generate the problem-sheet web pages from problems.yaml.

Two pages are written into <site_dir>:

  problems_page   questions only -- this is the one students get
  answers_page    questions *and* worked answers -- for demonstrators

The answers page has a random filename and is linked from nowhere. That makes
it unlisted, not secure: anyone with the URL can read it. Keep the filename
stable in problems.yaml or the demonstrators' link stops working.

Each sheet gets an <a id="..."> anchor so lectures/make_timetable.py can link
a tutorial slot straight at the right sheet.

    ./make_problems_html.py            write both pages
    ./make_problems_html.py --list     show what would be published
"""

import os
import shutil
import sys

import yaml

PDF_DIR = "problem_pdf"

CSS = """
body { font-family: system-ui, sans-serif; margin: 2em; max-width: 55em; }
h1 { margin-bottom: 0.2em; }
p.sub { color: #555; margin-top: 0; }
ol { line-height: 1.6; }
li { margin-bottom: 0.9em; }
.keywords { color: #555; font-style: italic; }
.missing { color: #999; }
.note { background: #fff4d6; border: 1px solid #e6cf8b;
        padding: 0.8em 1em; border-radius: 4px; }
"""


def config():
    with open("problems.yaml") as f:
        return yaml.safe_load(f)


def sheet_files(sheet):
    n = sheet["name"]
    return f"{n}.pdf", f"{n}_answers.pdf"


def publish_pdfs(cfg, with_answers):
    """Copy the built PDFs into <site_dir>/problem_pdf/. Returns what exists."""
    site = cfg.get("site_dir", "../site")
    dest = os.path.join(site, PDF_DIR)
    os.makedirs(dest, exist_ok=True)
    present = {}
    for sheet in cfg["sheets"]:
        q, a = sheet_files(sheet)
        got_q = os.path.exists(q)
        got_a = os.path.exists(a)
        if got_q:
            shutil.copy(q, dest)
        if got_a and with_answers:
            shutil.copy(a, dest)
        present[sheet["name"]] = (got_q, got_a)
    return present


def render(cfg, present, answers):
    course = cfg.get("course", {})
    title = "Problem Sheets" + (" (with answers)" if answers else "")
    out = ['<!DOCTYPE html>', '<html lang="en">', "<head>",
           '<meta charset="UTF-8">',
           '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
           '<link rel="stylesheet" href="style.css">',
           f"<title>{title}</title>", "</head>", "<body>",
           f"<header>{title}</header>", '<div class="container">',
           '<p><a href="index.html">&larr; Course home</a></p>',
           f"<p>{course.get('code','')}: {course.get('title','')}</p>"]

    if answers:
        out.append("<p class='note'><b>Demonstrators only.</b> This page "
                   "includes worked answers. It is unlisted, not protected "
                   "&mdash; please do not pass the link to students.</p>")

    out.append("<ol>")
    for sheet in cfg["sheets"]:
        name = sheet["name"]
        got_q, got_a = present.get(name, (False, False))
        label = sheet.get("title", name)
        out.append(f'<li><a id="{name}"></a>')
        if got_q:
            out.append(f'<b><a href="{PDF_DIR}/{name}.pdf">{label}</a></b>')
        else:
            out.append(f'<b class="missing">{label}</b> '
                       '<span class="missing">(not yet available)</span>')
        if sheet.get("keywords"):
            out.append(f'<br><span class="keywords">{sheet["keywords"]}</span>')
        if answers:
            if got_a:
                out.append(f'<br><a href="{PDF_DIR}/{name}_answers.pdf">'
                           'questions with answers</a>')
            else:
                out.append('<br><span class="missing">answers not built</span>')
        out.append("</li>")
    out += ["</ol>", "</div>",
            "<footer>ECS &mdash; "
            f"{course.get('code','')}: {course.get('title','')}</footer>",
            "</body>", "</html>"]
    return "\n".join(out)


def main():
    cfg = config()
    site = cfg.get("site_dir", "../site")

    if "--list" in sys.argv:
        for sheet in cfg["sheets"]:
            q, a = sheet_files(sheet)
            print(f"  week {sheet.get('week','?'):>2}  {sheet['name']:<16}"
                  f" questions={os.path.exists(q)}  answers={os.path.exists(a)}")
        return

    present = publish_pdfs(cfg, with_answers=True)

    pages = [(cfg.get("problems_page", "problems.html"), False),
             (cfg.get("answers_page"), True)]
    for filename, answers in pages:
        if not filename:
            continue
        path = os.path.join(site, filename)
        with open(path, "w") as f:
            f.write(render(cfg, present, answers))
        print(f"wrote {path}")

    built = sum(1 for q, _ in present.values() if q)
    print(f"{built}/{len(present)} sheets have a questions PDF")
    missing = [n for n, (q, _) in present.items() if not q]
    if missing:
        print("not yet built: " + ", ".join(missing) + "   (run ./build)")


if __name__ == "__main__":
    main()
