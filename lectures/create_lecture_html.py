#!/usr/bin/env python3

import re
import yaml
import subprocess
import os
import shutil

dir = "/Users/apb1/Documents/teaching/courses/comp6208/github/site/"

def extract(str):
    _, endpart = str.split("{")
    mid, _ = endpart.split("}")
    return mid

with open("lectures.tex", "r") as f:
    lectures = [extract(line) for line in f if re.search("^\\\\lecture{", line)]


    
html = open(f"{dir}/lectures.html", "w")

html.write('''<HTML>
<HEAD>
<TITLE>Lecture Notes
</TITLE>
</HEAD>

<H1 align="center">Lecture Notes</H1>

<h2>Lectures on Advanced Machine Learning</h2>

<ol>
''')

def getKeywords(file) :
    with open(file, "r") as file:
        lesson = ""
        cnt = 0
        for line in file:
            cnt = cnt + 1
            m = re.search("\\\\lesson\\{(.+?)\\}", line)
            if m:
                lesson = m.group(1)
            m = re.search("\\\\keywords\\{(.+?)\\}", line)
            if m: 
                return lesson, m.group(1)
            if cnt>10:
                break
        return lesson, ""

def add_file(file, description, location):
    fullfile = f"../site/{location}/{file}"
    if os.path.isfile(fullfile):
        html.write(f"<ul> <li> <a href=\"{location}/{file}\">{description}</a></li></ul>\n")

def add_video(lecture):
    video = f"videos/{lecture}.mp4"
    if not os.path.isfile(f"../site/{video}"):
        html_video = f"../site/videos/{lecture}.html"
        if os.path.isfile(html_video):
            lesson, keywords = getKeywords(tex)
            with open(html_video, "w") as fp:
                fp.write(f"""<HTML>
<HEAD>
<TITLE>Videos
</TITLE>
</HEAD>

<!--#include virtual="header.htx" -->

<H1 align="center">Video for Advance Machine Learning</H1>

<h3><b>{lesson}</b>: {keywords}</h3>

<div>
 <video width="500" controls>
       <source src="{lecture}.mp4" type="video/mp4">
       Your browser does not support HTML5 video.
    </video>
</div>

<div id="{lecture}">
<ul>
     <li> <a href="../lecture_pdf/{lecture}.pdf">Lecture PDF</a>, </li>
     <li> <a href="../lecture_pdf/{lecture}_prn.pdf">Printable PDF</a>, </li>
     <li> <a href="../lecture_pdf/{lecture}_prn_4.pdf">(4 per page)</a></li>
     <li> <a href="../lecture_pdf/{lecture}_prn_8.pdf">(8 per page)</a></li>
   </ul>
   
   <p>
</div>
<!--#include virtual="footer.htx" -->

</HTML>""")
    html.write(f"<ul> <li> <a href=\"videos/{lecture}.html\">video</a></li></ul>\n")


for lecture in lectures:
    tex = f"{lecture}.tex"
    lesson, keywords = getKeywords(tex)
    html.write(f"<div id =\"{lecture}\">\n")
    html.write(f"<li><b>{lesson}</b>: {keywords}\n")
    html.write(f"<ul> <li> <a href=\"lecture_pdf/{lecture}.pdf\">Lecture PDF</a>,\n")
    html.write(f"  <a href=\"lecture_pdf/{lecture}_prn.pdf\">Printable PDF</a>,\n")
    html.write(f"  <a href=\"lecture_pdf/{lecture}_prn_4.pdf\">(4 per page)</a>,\n")
    html.write(f"  <a href=\"lecture_pdf/{lecture}_prn_8.pdf\">(8 per page)</a>,\n</li>\n</ul>\n")
    add_file(f"{lecture}-subsidiary.pdf", "Notes", "notes_pdf")
    add_file(f"{lecture}.ipynb", "Jupyter Notebook", "notebook")
    add_video(lecture)
    html.write("</li>\n")
    html.write("</div>\n")

html.write('''
</ol>

<ul>
<li> <a href="lecture_pdf/lectures_8.pdf">Complete set of Notes</a></li>
</ul>


</HTML>
''')

html.flush()
html.close()

subprocess.call(["git", "add", dir])
subprocess.call(["git", "commit", "-m", "\"update lectures\""])
subprocess.call(["git", "push"])

