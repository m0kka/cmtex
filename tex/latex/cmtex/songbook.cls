% Stuff for writing down songs in LaTeX

\ProvidesClass{songbook}[2018/02/21 Write down songs in LaTeX]
\LoadClass[11pt, twoside, a4paper]{book}
\RequirePackage[a4paper,top=0.8in, bottom=1.1in, left=1.35in, right=1.35in]{geometry} % modification of the page margins
\RequirePackage{fancyhdr}
\RequirePackage{fontspec}
\RequirePackage[dvipsnames,svgnames,usenames,table]{xcolor}
\RequirePackage{imakeidx}
\RequirePackage{ifthen}
\RequirePackage{mathtools, amsmath, amsfonts, amssymb, amsthm}
\RequirePackage{xparse}
\RequirePackage{scrextend}
\RequirePackage{wasysym}
\RequirePackage{hyperref}
\RequirePackage{setspace}
\hypersetup{%
    pdfencoding=auto
    }
	
% Font settings
\defaultfontfeatures{Ligatures=TeX}
\setsansfont{Corbel}
\setmainfont{Palatino Linotype}
\setmonofont{Consolas}
\setmonofont[Contextuals={Alternate}]{Fira Code}

% required to use the Fira Code ligatures
\def\verbatim@nolig@list{}

% Process package options
\newif\ifcolorized\colorizedtrue
\newif\ifenglish\englishfalse
\DeclareOption{print}{\colorizedfalse}
\DeclareOption{english}{\englishtrue}
\DeclareOption{sans}{\setmainfont{Calibri}}
\DeclareOption*{\PackageError{commonstyles}{One or more of the provided options does not exist.}{Maybe spell-checking helps?}}

\ProcessOptions*

\ifenglish
	\RequirePackage[english]{babel}
\else
	\RequirePackage[ngerman]{babel}
\fi

% Color setup
\ifcolorized
	\colorlet{maincolor}{MidnightBlue}
	\colorlet{secondcolor}{ForestGreen}
	\colorlet{thirdcolor}{orange}
	\colorlet{fourthcolor}{Red}
\else
	\colorlet{maincolor}{black}
	\colorlet{secondcolor}{black}
	\colorlet{thirdcolor}{black}
	\colorlet{fourthcolor}{black}
\fi

% Counter stuff
\newcounter{song}
\newcounter{cstrophe}[song]

% Enable indexing
\ifenglish
	\makeindex[columns=3, title=Index, intoc]
\else
	\makeindex[columns=3, title=Index, intoc]
\fi

% Common formatting
\renewcommand{\baselinestretch}{0.8} % Set line-spacing to 1.3 (which equals 1.5)
\setlength{\parindent}{0cm} % Set indent of paragraphs to zero
\setlength{\parskip}{.5em} % Set paragraph spacing



% Chords in running text
% See: https://tex.stackexchange.com/a/147842
\newcommand\chord[2][l]{%
  \makebox[0pt][#1]{\begin{tabular}[b]{@{}l@{}}\textbf{\textcolor{maincolor}{#2}}\\\mbox{}\end{tabular}}}

% Intro/Intermission and all the stuff
\newcommand\pause{\hskip 1em}
\newcommand\Pause{\hskip 2em}
\newcommand\PAUSE{\hskip 4em}

\newcommand\susfour{$_{\text{sus4}}$}
\newcommand\sustwo{$_{\text{sus2}}$}
\newcommand\seven{$^{\text{7}}$}

\newcommand\vpause[1]{\hskip #1em}

\newcommand\rep[1]{\textmd{\hskip 0.5em \textcolor{black}{(x#1)}}}

\newcommand\cmcontainer[2]{
 {\vskip 0.5em\textbf{\textsc{#1}: \textcolor{maincolor}{#2}}\vskip 1em}
}
\newcommand\intro[1]{\cmcontainer{Vorspiel}{#1}}
\newcommand\intermission[1]{\cmcontainer{Zwischenspiel}{#1}}
\newcommand\outro[1]{\cmcontainer{Outro}{#1}}

\newcommand\musf{$\flat$}
\newcommand\muss{$\sharp$}
  
  
% Verses/Chords
\newenvironment{strophe}{
\vskip 0.5em
 \stepcounter{cstrophe}
 \textbf{\textsc{Strophe} \thecstrophe:}
 \begin{addmargin}[1em]{2em}
  \vskip -0.5em
}{
\end{addmargin}
\par
\vskip 0.5em
}
\newenvironment{strophe*}{
\vskip 0.5em
 \begin{addmargin}[1em]{2em}
  \vskip -0.5em
}{
\end{addmargin}
\par
\vskip 0.5em
}

\newenvironment{chorus}{
 \vskip 0.5em
 \textbf{\textsc{Chorus:}}
 \begin{addmargin}[4em]{2em}
  \vskip -0.5em
}{
\end{addmargin}
\par
\vskip 0.5em
}

\newenvironment{chorus*}{
 \vskip 0.5em
 \begin{addmargin}[4em]{2em}
  \vskip -0.5em
}{
\end{addmargin}
\par
\vskip 0.5em
}

\newcommand\cmtabskip{0.5cm}
\newcommand\tbnl{\\[\cmtabskip]}

\newenvironment{repline}{\hskip -1em $\mid\mid:$}{$:\mid\mid$}

\newcommand\playchorus{\vskip 0.5em\textbf{\textsc{Chorus:\dots}}\vskip 0.5em}
% Title stuff
\newcommand\cmartist{}
\newcommand\artist[1]{\renewcommand\cmartist{#1}}

\newcommand\cmalbum{}
\newcommand\album[1]{\renewcommand\cmalbum{#1}}

\newcommand\cmtitle{}
\renewcommand\title[1]{\renewcommand\cmtitle{#1}}

\newcommand\cmcapo{0}
\newcommand\capo[1]{\renewcommand\cmcapo{#1}}


\newcommand\cmsubtitle{}
\newcommand\subtitle[1]{\renewcommand\cmsubtitle{#1}}

\newcommand\cmauthor{Michael Merse}
\renewcommand\author[1]{\renewcommand\cmauthor{#1}}

\newcommand\cmdate{\today}
\newcommand\datum[1]{\renewcommand\cmdate{#1}}

\newcommand\makebooktitle{
 \pagenumbering{gobble}
  \begin{titlepage}
	\centering
	{\huge\bfseries\cmtitle\par}
	\vspace{1cm}
	{\Large\cmsubtitle\par}
	\vspace{2cm}
	{\Large\itshape\cmauthor\par}
	\vfill
	{\large\cmdate\par}
   \end{titlepage}
   \newpage
   \pagenumbering{arabic}
}

\newcommand\makesongtitle{
 \fancyfoot[LE,RO]{\thepage} % Left side on Even pages; Right side on Odd pages
 \null{
		{\LARGE\thesong. \cmtitle }\hfill{\LARGE\cmartist}\par
		{\large \ifthenelse{\cmcapo = 0}{}{Capo: \cmcapo} \hfill aus: \cmalbum \par}
	}
	\vskip -1em
	\noindent\hfil\rule{\textwidth}{.4pt}\hfil
	%\vskip -0.5em
}

%TOC stuff

\RequirePackage{etoc}
\renewcommand{\etocaftertitlehook}{\pagestyle{fancy}}
\renewcommand{\etocaftertochook}{\thispagestyle{fancy}}

\newcommand{\maketoc}{
\fancyfoot[LE,RO]{\thepage} % Left side on Even pages; Right side on Odd pages
\thispagestyle{fancy}
\ifenglish
	\addcontentsline{toc}{section}{Table of Contents}
\else
	\addcontentsline{toc}{section}{Inhaltsverzeichnis}
\fi
{\renewcommand{\baselinestretch}{0.8}\tableofcontents}
\newpage
}

\pagestyle{fancy}
\fancyhf{}
 
\fancyfoot[LE,RO]{\thepage} % Left side on Even pages; Right side on Odd pages

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\lhead{}
\rhead{}


% Lots of setup for adding songs
\DeclareDocumentCommand\DeclareSong{m m m O{0}}{
 \refstepcounter{song}
 \title{#1}
 \artist{#2}
 \album{#3}
 \capo{#4}
 \makesongtitle
 \addcontentsline{toc}{section}{\protect\numberline{\thesong}#1, #2}
% \index{#1, #2}
 \title{}
 \artist{}
 \album{}
 \capo{0}
}

\newcommand\blankpage{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage}
	
\newcommand\br{~\\}