% Common document class for my uni stuff. Based off of jlnostr's texfiles:
% https://github.com/jlnostr/texfiles

\ProvidesClass{university}[Class for all things university]
\LoadClass[a4paper,10pt,titlepage,twoside]{article}

% Handle options

\newif\ifenglish\englishfalse
\DeclareOption{english}{
	\englishtrue
	\PassOptionsToPackage{english}{commonstyles}
	\PassOptionsToPackage{english}{mathematics}
}

\DeclareOption{noreformat}{\PassOptionsToPackage{noreformat}{commonstyles}}

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
	numbers=left,
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

\newcommand{\introduction}{
\pagenumbering{roman}
\ifenglish
	\part*{Introduction}
	\addcontentsline{toc}{part}{Introduction}
\else
	\part*{Einführung}
	\addcontentsline{toc}{part}{Einführung}
\fi
}

\newcommand{\makepreface}{
\ifenglish
	\section*{Preface}
	\addcontentsline{toc}{section}{Preface}
\else
	\section*{Vorwort}
	\addcontentsline{toc}{section}{Vorwort}
\fi
}

\newcommand{\maketodo}{
\ifenglish
	\addcontentsline{toc}{section}{To-Do}
	\listoftodos[To-Do]
\else
	\addcontentsline{toc}{section}{Liste der noch zu erledigenden Punkte}
	\listoftodos
\fi
}

\newcommand{\maketoc}{
\ifenglish
	\addcontentsline{toc}{section}{Table of Contents}
\else
	\addcontentsline{toc}{section}{Inhaltsverzeichnis}
\fi
{\renewcommand{\baselinestretch}{0.8}\tableofcontents}
\newpage
}

\newcommand{\content}{
\pagenumbering{arabic}
\ifenglish
	\part{Main Section}
\else
	\part{Hauptteil}
\fi
}

\newcommand{\addendum}{
\setcounter{section}{0}
\renewcommand{\thesection}{\roman{section}}
\renewcommand{\theHsection}{\roman{section}}
\renewcommand{\thesubsubsection}{\roman{section}.\arabic{subsection}.\alph{subsubsection}}
\renewcommand{\theHsubsubsection}{\roman{section}.\arabic{subsection}.\alph{subsubsection}}

\part{Addenda}
}

\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}{
\oldlistoffigures
\ifenglish
	\addcontentsline{toc}{section}{List of Figures}
\else
	\addcontentsline{toc}{section}{Abbildungsverzeichnis}
\fi
}

\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{
\oldlistoftables
\ifenglish
	\addcontentsline{toc}{section}{List of Tables}
\else
	\addcontentsline{toc}{section}{Verzeichnis der Tabellen}
\fi
}
