% Common document class for my uni stuff. Based off of jlnostr's texfiles:
% https://github.com/jlnostr/texfiles

\ProvidesClass{university}[Class for all things university]
\LoadClass[a4paper,10pt,titlepage]{article}

% Handle options

\newif\ifcolorized
\DeclareOption{print}{
	\colorizedfalse
	\PassOptionsToPackage{print}{commonstyles}
	\PassOptionsToPackage{print}{mathematics}
}
\DeclareOption*{\ClassError{university}{One or more of the provided options does not exist.}{Maybe spell-checking helps?}}

\ProcessOptions*

\RequirePackage{commonuni}
\RequirePackage{mathematics}

% Display code
\RequirePackage{listingsutf8, lstautogobble}
\lstset{
	basicstyle=\ttfamily\small,
	columns=fullflexible,keepspaces,
	inputencoding=utf8,
	autogobble=true,
	language=Java,
	showstringspaces=false,
	breaklines=false,
	frameround=ffff,
	frame=single,
	rulecolor=\color{black},
	xleftmargin=\dimexpr\fboxsep-\fboxrule,
	xrightmargin=\dimexpr\fboxsep-\fboxrule,
	tabsize=4,
	commentstyle=\itshape\color{gray},
}

\ifcolorized
	\lstset{
		keywordstyle=\bfseries\color{maincolor},
		commentstyle=\itshape\color{secondcolor},
		stringstyle=\color{thirdcolor},
	}
\fi
\newcommand{\code}[1]{\lstinline{#1}}

\newcommand{\cmpreface}{
\pagenumbering{roman}
\part*{Einführung}
\addcontentsline{toc}{part}{Einführung}
\section*{Vorwort}
\addcontentsline{toc}{section}{Vorwort}
}

\newcommand{\cmtodo}{
\addcontentsline{toc}{section}{Liste der noch zu erledigenden Punkte}
\listoftodos
}

\newcommand{\cmtoc}{
\addcontentsline{toc}{section}{Inhaltsverzeichnis}
{\renewcommand{\baselinestretch}{0.8}\tableofcontents}
\newpage
}

\newcommand{\cmcontent}{
\pagenumbering{arabic}
\part{Hauptteil}
}

\newcommand{\cmaddendum}{
\setcounter{section}{0}
\renewcommand{\thesection}{\roman{section}}
\renewcommand{\theHsection}{\roman{section}}
\renewcommand{\thesubsubsection}{\roman{section}.\arabic{subsection}.\alph{subsubsection}}
\renewcommand{\theHsubsubsection}{\roman{section}.\arabic{subsection}.\alph{subsubsection}}

\part{Addenda}
}
