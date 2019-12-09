% Document class for uni homework.

\ProvidesClass{uebung}[Class for uni homework]
\LoadClass{university}

% Handle options

\newif\ifcolorized
\newif\ifdisto\distofalse
\DeclareOption{print}{
	\colorizedfalse
	\PassOptionsToPackage{print}{commonstyles}
	\PassOptionsToPackage{print}{mathematics}
}

\DeclareOption{noreformat}{
 \PassOptionsToClass{noreformat}{university}
}

\DeclareOption{disto}{\distotrue}

\DeclareOption*{\ClassError{university}{One or more of the provided options does not exist.}{Maybe spell-checking helps?}}

\ProcessOptions*

\RequirePackage[a4paper,top=1in, bottom=1.1in, left=1.15in, right=1.15in]{geometry} % modification of the page margins
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% setting the number of exercises, by default it's 4
\newcounter{pointcounter}
\setcounter{pointcounter}{4}
\newcommand{\cmgroup}{}
\newcommand{\points}[1]{\setcounter{pointcounter}{#1}}
\newcommand{\group}[1]{\renewcommand{\cmgroup}{#1}}

\newcommand{\rightsidecontent}{
	\newcounter{myloop}
	\def\punkte{}
	\def\placeholder{}
	\loop\ifnum\themyloop<\thepointcounter
		\stepcounter{myloop}
		\edef\punkte{\punkte\themyloop & }
		\edef\placeholder{\placeholder & }
	\repeat
	\Large
	\stepcounter{pointcounter}
	\begin{tabular}{|*{\value{pointcounter}}{c|}}
		\hline
		\punkte $\Sigma$ \\ \hline
		\placeholder     \\ \hline
	\end{tabular}
	\normalsize
}

% override the maketitle{}
\renewcommand{\maketitle}{
	\newpage
	\null{
		{\LARGE \cmsubject\hskip 0.2em - \cmtitle }\hfill\cmdate\par
		\vskip .5em
		\ifdisto
			{\large \cmauthor \par}
			{\null}
			{\null}
		\else
			{\large \cmauthor, \cmauthorsuffix \par}
			{\textit{Übungsgruppe: \cmgroup} \par}
		\fi
	}
	\vskip -5em
	\begin{raggedright}\hfill\mbox{\rightsidecontent}\end{raggedright}
	\vskip 1em
	\noindent\hfil\rule{\textwidth}{.4pt}\hfil
	\vskip -2em
	
	\thispagestyle{empty}
}

\pagestyle{fancy}
\fancyhf{}
 
\rfoot{Seite \thepage \hspace{1pt} von \pageref{LastPage}}

\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{1pt}
\ifdisto
	\lhead{\ifthenelse{\value{page}=1}{}{\cmauthor}}
\else
	\lhead{\ifthenelse{\value{page}=1}{}{\cmauthor, \cmauthorsuffix}}
\fi
\rhead{\ifthenelse{\value{page}=1}{}{\cmtitle\hskip 0.2em - \cmdate}}


\newcommand{\task}
{
	\stepcounter{section}
	\section*{Aufgabe \thesection}
	\label{sec:task_\thesection}
	\addcontentsline{toc}{section}{Aufgabe \thesection}
}

\newcommand{\subtask}
{
	\renewcommand{\thesubsection}{}
	\subsection{\alph{subsection})}
}

\newcommand{\subtasknr}
{
	\renewcommand{\thesubsection}{}
	\subsection{\arabic{section}.\arabic{subsection}.}
}

\newenvironment{beweis}
{\textit{Beweis.}\br}
{\QEDA}

\setcounter{tocdepth}{1}
\addto\captionsngerman{
  \renewcommand{\contentsname}%
    {Übersicht}%
}

% equation numbering
\renewcommand{\theequation}{\arabic{section}\alph{subsection}.\roman{equation}}

\RequirePackage{mips}
\RequirePackage{color}

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
\newcommand\setmipscode {
\lstset{ %
  language=[mips]Assembler,       % the language of the code
  basicstyle=\ttfamily\small,       % the size of the fonts that are used for the code
  numbers=left,                   % where to put the line-numbers
  numberstyle=\tiny\color{gray},  % the style that is used for the line-numbers
  stepnumber=1,                   % the step between two line-numbers. If it's 1, each line 
                                  % will be numbered
  numbersep=5pt,                  % how far the line-numbers are from the code
  backgroundcolor=\color{white},  % choose the background color. You must add \usepackage{color}
  showspaces=false,               % show spaces adding particular underscores
  showstringspaces=false,         % underline spaces within strings
  showtabs=false,                 % show tabs within strings adding particular underscores
  frame=single,                   % adds a frame around the code
  rulecolor=\color{black},        % if not set, the frame-color may be changed on line-breaks within not-black text (e.g. commens (green here))
  tabsize=4,                      % sets default tabsize to 2 spaces
  captionpos=b,                   % sets the caption-position to bottom
  breaklines=true,                % sets automatic line breaking
  breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
  title=\lstname,                 % show the filename of files included with \lstinputlisting;
                                  % also try caption instead of title
  keywordstyle=\color{blue},          % keyword style
  commentstyle=\color{dkgreen},       % comment style
  stringstyle=\color{mauve},         % string literal style
  escapeinside={\%*}{*)},            % if you want to add a comment within your code
  morekeywords={*,...}               % if you want to add more keywords to the set
}
}



