% Document class for uni homework.

\ProvidesClass{uebung}[Class for uni homework]
\LoadClass{university}

% Handle options

\newif\ifcolorized
\DeclareOption{print}{
	\colorizedfalse
	\PassOptionsToPackage{print}{commonstyles}
	\PassOptionsToPackage{print}{mathematics}
}

\DeclareOption*{\ClassError{university}{One or more of the provided options does not exist.}{Maybe spell-checking helps?}}

\ProcessOptions*

\RequirePackage[a4paper,top=1in, bottom=1.1in, left=1.35in, right=1.35in]{geometry} % modification of the page margins
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
		{\large \cmauthor, \cmauthorsuffix \par}
		{\textit{Übungsgruppe: \cmgroup} \par}
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
\lhead{\ifthenelse{\value{page}=1}{}{\cmauthor, \cmauthorsuffix}}
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

\newenvironment{beweis}
{\textit{Beweis.}\br}
{\QEDA}

\setcounter{tocdepth}{1}
\addto\captionsngerman{
  \renewcommand{\contentsname}%
    {Übersicht}%
}






