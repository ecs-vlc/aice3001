import re

def extract(string: str) -> str:
    _, endpart = string.split("{")
    mid, _ = endpart.split("}")
    return mid


def get_lesson_name(lecture_id: str) -> str:
    filename = f"{lecture_id}.tex"
    with open(filename, "r") as file:
        lesson = ""
        cnt = 0
        for line in file:
            cnt = cnt + 1
            m = re.search("\\\\lesson\\{(.+?)\\}", line)
            if m:
                return m.group(1)
            if cnt>10:
                break
        return lesson


def link(lecture_id: str) -> str:
    lecture_name = get_lesson_name(lecture_id)
    return f"<a href=\"lectures.html#{lecture_id}\">{lecture_name}</a>"

def main() -> None:
    with open("lectures.tex", "r") as f:
        courses = [extract(line) for line in f if re.search("^\\\\lecture{", line)]
    courses = [link(course) for course in courses]
    cnt = 0
    for course in courses:
        print(f"  - {course}")
        cnt += 1
        if cnt%4 == 3:
            print("  - Tutorial")
            cnt += 1

if __name__ == '__main__':
    main()
