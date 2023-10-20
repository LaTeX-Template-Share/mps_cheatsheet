% MIT License

% Copyright (c) 2023 Marlin Strub, Micha Bosshart

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:

% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.

% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

% Authors
% Marlin Strub - mstrub@robots.ox.ac.uk
% Micha Bosshart - bmicha@ethz.ch

% https://github.com/LaTeX-Template-Share

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpscheatsheet}[2023/10/20 LaTeX class for cheatsheets]

%% Fonts
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}

%% Options
\RequirePackage{xcolor}
\RequirePackage{xkeyval}
\RequirePackage{xifthen}

% Columns
\newcommand{\@@colnum}{4}
\define@key{mpscheatsheet.cls}{columns}{
  \ifthenelse{#1 < 2 \OR \isempty{#1}}{
    \ClassError{mpscheatsheet}{Invalid column number}{Number of columns must be two or more.}
  }{
    \renewcommand{\@@colnum}{#1}
  }
}

% Section colors
\define@key{mpscheatsheet.cls}{sectioncolor}{%
  \definecolor{sectioncolor}{RGB}{#1}%
}

% We can't allow the user to pass the 'twocolumn' option to the underlying article class.
\DeclareOptionX{twocolumn}{
  \ClassError{mpscheatsheet}{Invalid option 'twocolumn'}{Use 'columns=2' instead.}
}

% Pass any unknown option to underlying article class.
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{extarticle}}

% Set default options and process any passed options.
\ExecuteOptionsX{sectioncolor={11, 93, 174}, columns=4}
\ProcessOptionsX\relax

\LoadClass{extarticle}

%% Geometry
\RequirePackage[
  a4paper,%
  landscape,%
  left    = 0.1cm,%
  right   = 0.1cm,%
  top     = 0.01cm,%
  bottom  = 0.01cm,%
  includeheadfoot%
]{geometry}%

%% Whitespace
% Reduce the amount of whitespace.
\setlength{\headsep}{0.5em}
\setlength{\footskip}{2.9pt}
\setlength{\textheight}{19.7cm}
\setlength{\parindent}{0.0em}
\setlength{\parskip}{0em}
\setlength{\topskip}{-2em}
\setlength{\topsep}{0.4em}
\setlength{\partopsep}{0.1em}
\setlength{\tabcolsep}{0.2em}
\setlength{\columnsep}{5pt}
\renewcommand{\arraystretch}{1}
\renewcommand{\arraycolsep}{0.5em}

% Also reduce the amount of whitespace around enumerations.
\RequirePackage{enumitem}%
\setlist[enumerate]{
  itemsep     = 0.0em,%
  topsep      = 0.4em,%
  parsep      = 0.4em,%
  itemindent  = 1em,%
  leftmargin  = 1.4em %
}
\setlist[itemize]{
  itemsep     = 0.0em,%
  topsep      = 0.4em,%
  parsep      = 0.4em,%
  itemindent  = 0.1em,%
  leftmargin  = 1.4em %
}

%% Header
\def\@doctitle{}
\long\def\title#1{\def\@doctitle{#1}}
\def\@docauthor{}
\long\def\author#1{\def\@docauthor{#1}}

\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\pagestyle{fancy}
\fancyhf{}
\lhead{\textbf{\@doctitle}}
\chead{Page \thepage{} of \pageref{LastPage}}
\rhead{\today}
\cfoot{}

%% Link to GitHub Repo
\RequirePackage[hidelinks,
  pdftex,
  pdfauthor={Micha Bosshart \& Marlin Strub},
  pdftitle={https://github.com/LaTeX-Template-Share}
]{hyperref}

%% Multicol
\RequirePackage{multicol}%
\AtBeginDocument{%
  % reduce whitespace above and below equations
  \setlength{\abovedisplayskip}{4.0pt plus 1.0pt minus 1.0pt}
  \setlength{\belowdisplayskip}{4.0pt plus 1.0pt minus 1.0pt}

  \begin{multicols*}{\@@colnum}%
  \begin{center}\href{https://github.com/LaTeX-Template-Share}{\texttt{\@docauthor}}\end{center}%
}%
\AtEndDocument{%
  \end{multicols*}%
}%

%% Section headings
\RequirePackage[framemethod=TikZ]{mdframed}

% Section
\newcommand*{\sect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor,%
    linecolor         = none,%
    leftmargin        = -2pt,%
    rightmargin       = -2pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 3pt,%
    innerbottommargin = 3pt,%
    innerleftmargin   = 6pt,%
    innerrightmargin  = 3pt,%
    roundcorner       = 1mm%
  ]%
    \color{white}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}%
}%
\renewcommand\section{\@startsection%
  {section}% name
  {1}% level
  {0pt}% indent
  {0.4em plus 0.3em minus 0.1em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\sect}% style
}

% Subsection
\newcommand*{\subsect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor!70,%
    linecolor         = none,%
    leftmargin        = -2pt,%
    rightmargin       = -2pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 3pt,%
    innerbottommargin = 3pt,%
    innerleftmargin   = 6pt,%
    innerrightmargin  = 2pt,%
    roundcorner       = 1mm%
  ]%
    \color{white}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}%
}%
\renewcommand\subsection{\@startsection%
  {subsection}% name
  {2}% level
  {0pt}% indent
  {0.4em plus 0.1em minus 0.0em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\subsect}% style
}

% Subsubsection
\newcommand*{\subsubsect}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor!40,%
    linecolor         = none,%
    leftmargin        = -2pt,%
    rightmargin       = -2pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 3pt,%
    innerbottommargin = 3pt,%
    innerleftmargin   = 6pt,%
    innerrightmargin  = 2pt,%
    roundcorner       = 1mm%
    ]%
    \color{white}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}
}%
\renewcommand\subsubsection{\@startsection%
  {subsubsection}% name
  {3}% level
  {0pt}% indent
  {0.4em plus 0.1em minus 0.0em}% beforeskip
  {0.2em plus 0.1em minus 0.0em}% afterskip
  {\subsubsect}% style
}

% Subsubsubsection
\newcommand*{\subsubsubsection}[1]{%
  \begin{mdframed}[%
    backgroundcolor   = sectioncolor!20,%
    linecolor         = none,%
    leftmargin        = -2pt,%
    rightmargin       = -2pt,%
    skipabove         = 0pt,%
    skipbelow         = 0pt,%
    innertopmargin    = 3pt,%
    innerbottommargin = 3pt,%
    innerleftmargin   = 6pt,%
    innerrightmargin  = 2pt,%
    roundcorner       = 1mm%
    ]%
    \color{black}%
    \textbf{#1}%
  \end{mdframed}%
  \vspace{-6pt}
}%
