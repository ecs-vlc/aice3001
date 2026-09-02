from timetable import timetable

def tag(name, content, attribute=None, space=False):
    if space:
        content = f"\n{content}\n"
    if attribute:
        return f"<{name} {attribute}> {content} </{name}>\n"
    else:
        return f"<{name}> {content} </{name}>\n"

def link(content, ref):
    return tag("a", content, f"href=\"{ref}\"")

def problem_sheet(name, location):
    l1 = link(f"{name} Problem Sheet", f"problems/{location}-questions.pdf")
    l2 = link(f"(Answer)", f"problems/{location}-answers.pdf")
    return tag("li", f"{l1} {l2}")
    
def homepage():
    header = "<meta charset=\"UTF-8\">\n"
    header += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    header += "<link rel='stylesheet' href='style.css'>\n"
    header += tag('title', 'Advanced Machine Learning')
    inhtml = tag("head", header, space=True)
    
    inbody = tag("header", "COMP6208 Advanced Machine Learning")
    
    inbody += tag("h1", "COMP6208 Advanced Machine Learning")
    mail_link = link("Adam Pr&uuml;gel-Bennett", "mailto:apb1@soton.ac.uk")
    inbody += tag("p", f"Welcome to Advaced Machine Learning taught by {mail_link}")

    
    year, timeTable = timetable("courses.yaml")
    intable = tag("h2", f"Timetable for {year}")
    intable += timeTable
    inbody += tag("div", intable, "id=\"includedTimetable\"", space=True)

    inbody += "\n"
    inbody += tag("h2", "Marked Worksheet")
    worksheet = link("here", "marked_worksheet.pdf")
    inbody += tag("p", f"The marked worksheet is given {worksheet}. It is due 12am Monday 27th April 2026.")
    
    inbody += "\n"
    inbody += tag("h2", "Problem Sheets")
    problem_sheets = tag("li", link("Linear Algebra Self Study Sheet", "problems/math-problems.pdf"))
    problem_sheets += problem_sheet("Bias Variance", "biasVariance")
    problem_sheets += problem_sheet("Ensemble Learning", "ensembleLearning")
    problem_sheets += problem_sheet("Vector Spaces", "vectorSpaces")
    problem_sheets += problem_sheet("Convexity", "convexity")
    inbody += tag("ol", problem_sheets, space=True)

    inbody += "\n"
    info = tag("h2", "Course Information")
    info_table = tag("li", link("Lecture Notes", "lectures.html"))
    info_table += tag("li", link("Past Papers", "exams.html"))
    info += tag("ul", info_table)
    inbody += tag("div", info)
    inbody += tag("footer", f"ECS {year}: COMP6208 Advanced Machine Learning")
    inhtml += tag("body", inbody)
    index_file = "<!DOCTYPE html>\n"
    index_file += tag("html", inhtml, "lang=\"en\"")
    return index_file

def main():
    html = homepage()
    with open("../site/index.html", "w") as f:
        f.write(html)

if __name__ == "__main__":
    main()
