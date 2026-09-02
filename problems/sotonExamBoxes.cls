%%
%%
%%    Klaus-Peter Zauner              School of Electronics & Computer Science
%%    Southampton, 07.03.2007         University of Southampton, SO17 1BJ U.K.
%%     _______________________        http://www.ecs.soton.ac.uk/~kpz/
%% __/  sotonExamBoxes.cls    \_______________________________________________
%%
%%
%%  LaTeX class to prepare exam forms with writing space for students printed
%%  on the question sheets.
%%
%%  The layout of the exams follows the COMP2009 exam from 2006/07
%%  developed by Denis Nicole and the implementation is an adaptation
%%  of Steve Gunn's uosexam.cls.
%%
%%  Updated style for 2012 format.
%%    ... this is a hack of a hack and should be redone. KPZ 25.02.2012
%%
%%  - Includes Pawel's changes based on Nic's advise for 2014 style. KPZ Mar 2015
%%  - Includes changes requested by Nic.    KPZ April 2018
%%  - Includes the new cover page added by Long on Nic's request.  2018/2019
%%  - Includes \addspc command to insert a page of additional space  KPZ Feb 2019
%%
%%  _________________________________________________________________________
%% 456789-123456789-123456789-123456789-123456789-123456789-123456789-12345678
\newcommand{\clsVersion}{2019/02/21 v0.4.0}
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{sotonExamBoxes}
              [\clsVersion\ LaTeX document class]
\newcommand{\baseclass}{extbook}
\RequirePackage{ifthen}
\newboolean{withAnswers}
\DeclareOption{answers}{\setboolean{withAnswers}{true}}
\newboolean{isSupplementary}
\DeclareOption{suppl}{\setboolean{isSupplementary}{true}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{\baseclass}
}
\ProcessOptions\relax
\RequirePackage{calc}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
% \RequirePackage{enumitem}
% \RequirePackage{collect}


\def\@checkoptions#1#2{
  \edef\@curroptions{\@ptionlist{\@currname.\@currext}}
  \@tempswafalse
  \@tfor\@this:=#2\do{
    \@expandtwoargs\in@{,\@this,}{,\@curroptions,}
    \ifin@ \@tempswatrue \@break@tfor \fi}
  \let\@this\@empty
  \if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
\@checkoptions{10pt}{{10pt}{11pt}{12pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}
% \usepackage[latin1]{inputenc}
\usepackage[T1]{fontenc}
% \usepackage{uarial}
\usepackage{helvet}

% \usepackage{fontspec} % requires xelatex
% \setmainfont{Arial}

\usepackage[rgb,usenames,svgnames,table]{xcolor}
\usepackage{tabularx,ragged2e}
\usepackage{tikz}
\usepackage{tikzpagenodes}
% \usepackage{showframe}

\renewcommand*\familydefault{\sfdefault}
\renewcommand{\normalsize}{\fontsize{11.5}{12pt}\selectfont}
\usepackage{version}
\usepackage{lastpage}
\usepackage{fancyhdr}
\usepackage{fancybox}
\usepackage{enumitem}
\usepackage{mleftright}
\mleftright % Redefines \left to \mleft and \right to \mright


\usepackage[paper=a4paper,top=25mm,bottom=25mm,right=25mm,left=25mm]{geometry}

\newcommand{\meta}[1]{\textit{(#1)}\newline}
\renewcommand{\headrulewidth}{0.0pt}


\newcommand{\CopySoton}{Copyright~\ifthenelse{\value{semnumber} >
       1}{\arabic{yearplus1}}{\arabic{year}}\copyright~\univname}


\newcommand{\Page}{Page~\textbf{\thepage}~of~\textbf{\pageref{LastPage}}}

\fancypagestyle{coverpage}{
    \fancyhf{}
    \fancyfoot[L]{\CopySoton}
    \fancyfoot[R]{\Page}
}
\fancypagestyle{frontmatter}{
    \fancyhf{}
 }
\fancypagestyle{body}{
    \fancyhf{}
    \fancyfoot[L]{\CopySoton}
    \fancyhead[R]{\Large \ucode W1}
    \fancyhead[C]{}
    \fancyfoot[RE]{\Page}
    \fancyfoot[RO]{\raisebox{2.3ex}[0pt][0pt]{\makebox[0pt][l]{\large TURN OVER}}\Page}
}

\fancypagestyle{last}{
    \fancyfoot{}
    \fancyfoot[L]{\CopySoton}
    % \fancyfoot[C]{\raisebox{2.3ex}[0pt][0pt]{\Large \textbf{END OF PAPER}}}
    \fancyfoot[R]{\Page}
}

\ifthenelse{\boolean{withAnswers}}{
      \fancypagestyle{last}{
          \fancyfoot{}
          \fancyfoot[L]{\footnotesize \clsVersion--\manuscriptVers}
          \fancyfoot[C]{\raisebox{2.3ex}[0pt][0pt]{\Large \textbf{END OF PAPER}}}
          \fancyfoot[R]{\Page}
      }
}{}


\usepackage{setspace}
\singlespacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage{xspace}
\usepackage{vmargin}

% \setmarginsrb           { 2.8cm}  % left margin
%                         { 2cm}  % top margin
%                         { 2.8cm}  % right margin
%                         { 2cm}  % bottom margin
%                         {  20pt}  % head height
%                         {  25pt}  % head sep
%                         {  17pt}  % foot height
%                         {  15mm}  % foot sep

\usepackage{graphicx}
\usepackage{color}
\usepackage{eso-pic}
\usepackage{type1cm}
\usepackage{colortbl}
\usepackage{refcount}

\newcounter{year}
\newcounter{yearplus1}
\newcounter{shortyearplus1}
\newcounter{semnumber}
\newcounter{sec}
\newcounter{question}
\newcounter{totalquestions}
\newcounter{subquestion}[question]
\newcounter{marks}[question]
\newcounter{submarks}[question]
\newsavebox{\markstable}

\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\roman{enumii})}

% Do not reset figure counter
%\def\cl@chapter{\@elt{section}\@elt{footnote}}



\newcommand{\dispmarks}[1]
{
      \hspace*{\fill}
    \nolinebreak[1]
    \hspace*{\fill}
    \ifthenelse{#1 > 1}{{[#1~marks]}\par}{{[#1~mark]}\par}
}


\renewcommand{\section}{
     \stepcounter{sec}%
     \begin{flushleft}\textbf{\LARGE Section \Alph{sec}}\end{flushleft}%
}

% \renewcommand{\part}[1][0]{
%     \ifthenelse{\value{submarks} > 0}{%
%          \dispmarks{\thesubmarks}\setcounter{submarks}{0}}{}
%     \addtocounter{submarks}{#1}
%     \addtocounter{marks}{#1}
%     \item %
% }

\newcommand{\qpart}[3][0]{
    \addtocounter{submarks}{#1}
    \addtocounter{marks}{#1}
    \item \parbox[t]{\linewidth}{#2%
    \ifthenelse{\value{submarks} > 0}{%
         \dispmarks{\thesubmarks}\setcounter{submarks}{0}}{}%
       #3%
         \ifthenelse{\boolean{withAnswers}}{}{% not answers:
       \hfill\makebox(0,0)[lt]{\raisebox{2cm}[1cm]{\hspace*{1cm}\huge\fbox{$\frac{\rule{0pt}{1ex}}{#1}$}}}}}%
           \sbox{\markstable}{\usebox{\markstable} \labelenumi~$\displaystyle\frac{\hspace{1em}}{#1}$}%
}


% emptyBox
\newcommand{\emptyBox}[1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setlength\unitlength{1cm}\hspace{-10.5mm}\framebox(15.7,#1){}
  }
}


% Usage:
%   \forloop[step]{counter}{initial_value}{conditional}{code_block}
%
% For example:
%   \newcounter{ct}
%   \forloop{ct}{1}{\value{ct} < 5}% {% \arabic{ct} }
\newcommand{\forloop}[5][1]%
{%
  \setcounter{#2}{#3}%
  \ifthenelse{#4}%
  {%
    #5%
    \addtocounter{#2}{#1}%
    \forloop[#1]{#2}{\value{#2}}{#4}{#5}%
  }{}%
}% by nsetzer


% Lines for answers
\newcounter{linecount}
\newcommand{\lines}[1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \begin{Sbox}
      \begin{minipage}{\textwidth}%
        \rule{0pt}{\boxedlinespc}%
        \forloop{linecount}{0}{\value{linecount} < #1}{%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{\textwidth}{\lineweight}}\\%gray lines
        }%
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }
}


% Numbered lines for answers
% Arguments:   - count of numbered blocks
%              - lines in each block
\newcounter{count}
\newcounter{nlinecount}
\newcommand{\numberedlines}[2][1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setcounter{count}{1}%
    \begin{Sbox}%
      \begin{minipage}{\textwidth}%
        \forloop{nlinecount}{0}{\value{nlinecount} < #2}{%
           \mbox{}\hfill{\Large \thecount $\;\;$}%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           \addtocounter{count}{1}%
           \forloop{linecount}{1}{\value{linecount} < #1}{%
             \mbox{}\hfill%
             \rule{0pt}{\boxedlinespc}%
             \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           }%
        }%
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }

}

% Roman Numbered lines for answers
% Arguments:   - count of numbered blocks
%              - lines in each block
\newcounter{icount}
\newcounter{inlinecount}
\newcommand{\inumberedlines}[2][1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setcounter{icount}{1}%
    \begin{Sbox}%
      \begin{minipage}{\textwidth}%
        \forloop{inlinecount}{0}{\value{inlinecount} < #2}{%
           \mbox{}\hfill{\Large \roman{icount} $\;\;$}%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{0.94\textwidth}{\lineweight}}\\
           \addtocounter{icount}{1}%
           \forloop{linecount}{1}{\value{linecount} < #1}{%
             \mbox{}\hfill%
             \rule{0pt}{\boxedlinespc}%
             \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           }%
        }%
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }
}


% a,b,c Numbered lines for answers
% Arguments:   - count of numbered blocks
%              - lines in each block
\newcounter{abccount}
\newcounter{abclinecount}
\newcommand{\abcnumberedlines}[2][1]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \setcounter{abccount}{1}%
    \begin{Sbox}%
      \begin{minipage}{\textwidth}%
        \forloop{abclinecount}{0}{\value{abclinecount} < #2}{%
           \mbox{}\hfill{\Large \alph{abccount} $\;\;$}%
           \rule{0pt}{\boxedlinespc}%
           \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           \addtocounter{abccount}{1}%
           \forloop{linecount}{1}{\value{linecount} < #1}{%
             \mbox{}\hfill%
             \rule{0pt}{\boxedlinespc}%
             \textcolor[gray]{\linegrey}{\rule{0.95\textwidth}{\lineweight}}\\
           }%
        }%
      \end{minipage}
    \end{Sbox}
    \vskip2mm
    \centerline{\fbox{\TheSbox}}
  }

}

% Blank page (marked as blank)
\newcommand{\blankpage}[1][0.4]{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
    \rule{0pt}{#1\textheight}
    \blankpagelabel
    \vfill
    \clearpage
  }% not answers
}



\newcommand\NoIndent[1]{%
  \par\vbox{\parbox[t]{\linewidth}{#1}}%
}

% Additional Space
\newcommand{\addspc}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
    \NoIndent{%
    \resizebox{\linewidth}{!}{\itshape
     Additional space. Do not use unless necessary. Clearly mark
     corresponding question.}\\[0.5ex]
    \begin{tikzpicture}[x=1cm, y=1cm,semitransparent]
      \draw[step=5mm, line width=0.2mm, black!30!white] (0,0) grid (15,23);
    \end{tikzpicture}
    }
    \clearpage
  }% not answers
}


% End of paper
\newcommand{\paperend}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
    \rule{0pt}{0.3\textheight}
    \begin{center}
    This page is intentionally blank\\
    \rule{0pt}{0.1\textheight}\\
    {\Large END OF PAPER}
    \vfill
    \end{center}
    \clearpage
  }% not answers
}




% Start new page
\newcommand{\freshpage}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \clearpage
  }% not answers
}

% Start new page
\newcommand{\freshpagel}{%
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
    \vfill
    \blankarealabel
    \vfill
    \clearpage
  }% not answers
}


\newenvironment{qparts}{
\begin{enumerate}}
{\sbox{\markstable}{\usebox{\markstable}\rule{0pt}{3ex} Total~$\displaystyle\frac{\hspace{1.2em}}{\themarks}$}%
  \ifthenelse{\value{submarks} > 0}{%
    \dispmarks{\thesubmarks}\setcounter{submarks}{0}}{}
  \begin{center}
    End of question~\Alph{sec}\thequestion
  \end{center}
  \ifthenelse{\boolean{withAnswers}}{}{% not answers:
  \begin{flushright}
    \fbox{\usebox{\markstable}}
  \end{flushright}}
\end{enumerate}}



\newenvironment{question}[1]{
    \stepcounter{question}
    \stepcounter{totalquestions}
    \newcommand{\totalmark}{#1}

    \textbf{\Alph{sec}~\thequestion}
}
{
    \ifthenelse{\value{marks} = 0}{\dispmarks{\totalmark}}{
        \ifthenelse{\value{marks} = \totalmark}{}{
            \ClassWarningNoLine{UoSExam}{Marks don't add up! (Question \thequestion)}
        }
    }
    \ifthenelse{\equal{\thepage}{\pageref{LastPage}}}
    {
        \thispagestyle{last}
    }{}
%     \clearpage
}

\ifthenelse{\boolean{withAnswers}}{
    \renewcommand{\arrayrulewidth}{1pt}
    \newenvironment{answer}%
    {
        \begin{flushleft}
        \color{BlueViolet}\fontfamily{ptm}\normalsize%\bfseries%
        {\vskip 5pt \hrule height 1pt \vskip 0pt \vskip 6pt \relax}%
    }
    {%
        {\vskip 3.4pt \hrule height 1pt \vskip 6pt\relax}%
        \end{flushleft}
    }
    \makeatletter
    \ifthenelse{\equal{\thepage}{1}}{
        \AddToShipoutPicture{%
            \put(0,0){%
            \hspace{12cm}\raisebox{15cm}{\makebox(0,0){\rotatebox{55}{\textcolor[gray]{0.95}{\normalfont\fontsize{5cm}{5cm}\fontseries{m}\selectfont{Answers}}}}}
            }
        }
    }{}
    \makeatother
}
{\excludeversion{answer}
}

\newcommand{\qfig}[2][155mm]{\vspace*{1ex}\ifthenelse{\boolean{withAnswers}}{}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#2}\end{center}\end{minipage}}}}}

\newcommand{\afig}[2][155mm]{\vspace*{1ex}\ifthenelse{\boolean{withAnswers}}{\centerline{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#2}\end{center}\end{minipage}}}{}}


\newcommand{\qa}[2]{\ifthenelse{\boolean{withAnswers}}{{\vskip 5pt \hrule height 1pt \vskip 0pt\relax}#2{\vskip 3.4pt \hrule height 1pt \vskip -5.4pt\relax}}{\centerline{\fbox{\begin{minipage}{\textwidth}#1\end{minipage}}}}}

\newcommand{\qaf}[3][155mm]{\vspace*{1ex}\ifthenelse{\boolean{withAnswers}}{\begin{answer}\centerline{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#3}\end{center}\end{minipage}}\end{answer}}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#2}\end{center}\end{minipage}}}}}

\newcommand{\qabf}[3][155mm]{\ifthenelse{\boolean{withAnswers}}{\centerline{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=#1]{#3}\end{center}\end{minipage}}}}{\centerline{\fbox{\begin{minipage}{155mm}\rule{155mm}{0pt}\vspace*{#2}\end{minipage}}}}}

\newcommand{\mylines}[1]{\centerline{\ifthenelse{\boolean{withAnswers}}{}{\fbox{\begin{minipage}{\textwidth}\begin{center}\includegraphics[width=155mm]{#1}\end{center}\end{minipage}}}}}


\usepackage[centerlast,Large,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\usepackage[scriptsize]{subfigure}
\usepackage{booktabs}
\usepackage{rotating}
\def\thebibliography#1{
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\reversemarginpar
\usepackage[pdfpagemode={None},bookmarks=true,bookmarksopen=false,
   bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
   colorlinks,linkcolor={white},citecolor={white},urlcolor={red},
   pdfstartview={FitV}, pdfpagelayout={TwoColumnLeft},
   % colorlinks=false,
   hidelinks,
]{hyperref}
\pdfstringdefDisableCommands{
   \let\\\space
   \let\spacefactor\space
   \let\@m\space
}
\newcommand*{\addresses}[1]{\def\addressnames{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\UNIVERSITY}[1]{\def\UNIVNAME{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\DEPARTMENT}[1]{\def\DEPTNAME{#1}}
\newcommand*{\group}[1]{\def\groupname{#1}}
\newcommand*{\GROUP}[1]{\def\GROUPNAME{#1}}
\newcommand*{\faculty}[1]{\def\facname{#1}}
\newcommand*{\FACULTY}[1]{\def\FACNAME{#1}}
\newcommand*{\subject}[1]{\def\subjectname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
\newcommand*{\semester}[1]{\setcounter{semnumber}{#1}}
% \newcommand*{\duration}[1]{\def\durationmins{#1}}
\newcommand*{\duration}[2]{\def\durationmins{#1}\def\durationhours{#2}}
\newcommand*{\unitcode}[1]{\def\ucode{#1}}
\newcommand*{\unitTitle}[1]{\def\utit{#1}}
\newcommand*{\calculator}[1]{\def\calcoption{#1}}
\newcommand*{\dictionary}[1]{\def\dictoption{#1}}
\newcommand*{\usage}[1]{\def\usage{#1}}
\newcommand*{\usercodeVers}[1]{\def\usercodeVers{#1}}
\newcommand*{\manuscriptVers}[1]{\def\manuscriptVers{#1}}
\newcommand*{\boxedlinespc}[1]{\def\boxedlinespc{#1}}
\newcommand*{\blankpagelabel}[1]{\def\blankpagelabel{#1}}
\newcommand*{\blankarealabel}[1]{\def\blankarealabel{#1}}
\newcommand*{\watermarkgrey}[1]{\def\watermarkgrey{#1}}
\newcommand*{\linegrey}[1]{\def\linegrey{#1}}
\newcommand*{\lineweight}[1]{\def\lineweight{#1}}


\renewcommand*{\year}[1]{\setcounter{year}{#1}
                         \setcounter{yearplus1}{#1}
                         \stepcounter{yearplus1}
                         \setcounter{shortyearplus1}{#1}
                         \addtocounter{shortyearplus1}{-1999}
}
% \newcommand*{\QtoBeAnswered}[1]{\def\qtba{#1}}
\newcommand*{\instructions}[1]{\def\instr{#1}}
\newcommand*{\authors}[1]{\def\auths{#1}}



\university  {{University of Southampton}}
\UNIVERSITY  {{UNIVERSITY OF SOUTHAMPTON}}


\department  {\texorpdfstring{\href{http://www.ecs.soton.ac.uk}
                {School of Electronics and Computer Science}}
                {School of Electronics and Computer Science}}
\DEPARTMENT  {\texorpdfstring{\href{http://www.ecs.soton.ac.uk}
                {SCHOOL OF ELECTRONICS AND COMPUTER SCIENCE}}
                {SCHOOL OF ELECTRONICS AND COMPUTER SCIENCE}}
\group       {\texorpdfstring{\href{http://www.isis.ecs.soton.ac.uk}
                {Image, Speech and Intelligent Systems Group}}
                {Image, Speech and Intelligent Systems Group}}
\GROUP       {\texorpdfstring{\href{http://www.isis.ecs.soton.ac.uk}
                {IMAGE, SPEECH AND INTELLIGENT SYSTEMS GROUP}}
                {IMAGE, SPEECH AND INTELLIGENT SYSTEMS GROUP}}
\faculty     {\texorpdfstring{\href{http://www.engineering.soton.ac.uk}
                {Faculty of Engineering, Science and Mathematics}}
                {Faculty of Engineering, Science and Mathematics}}
\FACULTY     {\texorpdfstring{\href{http://www.engineering.soton.ac.uk}
                {FACULTY OF ENGINEERING, SCIENCE AND MATHEMATICS}}
                {FACULTY OF ENGINEERING, SCIENCE AND MATHEMATICS}}
\boxedlinespc{8mm}
\watermarkgrey{0.8} % higher values are brighter
\linegrey{0.68}
\lineweight{1.4pt}
\blankpagelabel{\centerline{\ensuremath{\bullet\;\;}%
This page is intentionally left blank---do
not write in this space\ensuremath{\;\;\bullet}}}
\blankarealabel{\centerline{\ensuremath{\bullet\;\;}%
Do not write in this space\ensuremath{\;\;\bullet}}}



\newcommand{\fronthead}{
  \UNIVNAME \hfill \ucode W1
  \bigskip
  \rule{\textwidth}{1pt}
  \bigskip
  \ifthenelse{\boolean{isSupplementary}}{%
    {SUPPLEMENTARY~EXAMINATION~\arabic{year}/\arabic{shortyearplus1}\\}
  }{%
    {SEMESTER~\arabic{semnumber}~EXAMINATION~\arabic{year}/\arabic{shortyearplus1}\\}
  }
  {\MakeUppercase{\utit}\\[1.5ex]}
  {Duration~\durationmins~mins~(\durationhours~hours)\\}
  \medskip
  \rule{\textwidth}{1pt}
}

\renewcommand{\maketitle}{
    \thispagestyle{coverpage}
    \ifthenelse{\boolean{withAnswers}}{}{
    \fbox{\fbox{Name: \hspace{7.2cm} Student ID: \hspace{4cm}}}
    \vspace{1ex}}
    \hrule
    {\MakeUppercase{\utit} \\[0.01cm]}
    \hrule
    \pagestyle{body}
  }


\endinput
%%
%% End of file `sotonExamBoxes.cls'.
