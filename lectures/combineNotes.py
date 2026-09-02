#!/usr/bin/env python3

import  re
from ask import Ask
import os

def extract(str):
    _, endpart = str.split("{")
    mid, _ = endpart.split("}")
    return mid

with open("lectures.tex", "r") as f:
    files = [extract(line) for line in f if re.search("^\\\lecture{", line)]

notesFiles = [f"./{file}-subsidiary.pdf" for file in files if os.path.exists(f"./{file}-subsidiary.pdf" )]


nfs = " ".join(notesFiles)
os.system(f"pdfjam  --fitpaper true --rotateoversize false -o notes.pdf {nfs}")
