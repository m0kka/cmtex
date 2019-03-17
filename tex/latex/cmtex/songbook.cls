% Stuff for writing down songs in LaTeX

\ProvidesClass{songbook}[2018/02/21 Write down songs in LaTeX]
\LoadClass[11pt, twoside, a4paper]{book}
\RequirePackage[a4paper,top=0.4in, bottom=.8in, left=0.7in, right=0.7in]{geometry} % modification of the page margins
\RequirePackage{fancyhdr}
\RequirePackage{fontspec}
\RequirePackage[dvipsnames,svgnames,usenames,table]{xcolor}
\RequirePackage{imakeidx}
\RequirePackage{ifthen}
\RequirePackage{mathtools, amsmath, amsfonts, amssymb, amsthm}
\RequirePackage{xparse}
\RequirePackage{scrextend}
\RequirePackage{wasysym}
\RequirePackage{pdfpages}
\RequirePackage{graphicx}
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

\makeatletter
\renewcommand\normalsize{%
\@setfontsize\normalsize{13pt}{13pt}% Will look incredibly crabbed if line height is too small
\abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@%
\abovedisplayshortskip \z@ \@plus2\p@%
\belowdisplayshortskip 5\p@ \@plus2\p@ \@minus3\p@%
\belowdisplayskip \abovedisplayskip%
\let\@listi\@listI%
}
\normalsize  
\makeatother

% required to use the Fira Code ligatures
\def\verbatim@nolig@list{}

% graphicspath
\graphicspath{{images/}{../images/}}

% Process package options
\newif\ifcolorized\colorizedtrue
\newif\ifenglish\englishfalse
\DeclareOption{print}{\colorizedfalse}
\DeclareOption{english}{\englishtrue}
\DeclareOption{sans}{\setmainfont{Calibri}}
\DeclareOption*{\PackageError{commonstyles}{One or more of the provided options does not exist.}{Maybe spell-checking helps?}}

\ProcessOptions*


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
	\makeindex[columns=2, title=Index, intoc]
\else
	\makeindex[columns=2, title=Index, intoc]
\fi

% Common formatting
\renewcommand{\baselinestretch}{0.8} % Set line-spacing to 1.3 (which equals 1.5)
\setlength{\parindent}{0cm} % Set indent of paragraphs to zero
\setlength{\parskip}{.5em} % Set paragraph spacing



% Chords in running text
% See: https://tex.stackexchange.com/a/147842
\newcommand\chord[2][l]{%
  \makebox[0pt][#1]{\renewcommand{\arraystretch}{1.2}\begin{tabular}[b]{@{}l@{}}\textbf{\textcolor{maincolor}{#2}}\\\mbox{}\end{tabular}}}

% Intro/Intermission and all the stuff
\newcommand\pause{\hskip 1em}
\newcommand\Pause{\hskip 2em}
\newcommand\PAUSE{\hskip 4em}

\newcommand\susfour{$_{\text{sus4}}$}
\newcommand\sustwo{$_{\text{sus2}}$}
\newcommand\seven{$^{\text{7}}$}
\newcommand\addnine{$^{\text{add9}}$}

\newcommand\vpause[1]{\hskip #1em}

\newcommand\rep[1]{\textmd{\hskip 0.5em \textcolor{black}{(x#1)}}}

\newcommand\cmcontainer[2]{
 {\vskip 0.5em\textbf{\textsc{#1}: \textcolor{maincolor}{#2}}\vskip 1em}
}
\ifenglish
	\newcommand\intro[1]{\cmcontainer{Intro}{#1}}
	\newcommand\interlude[1]{\cmcontainer{Interlude}{#1}}
	\newcommand\outro[1]{\cmcontainer{Outro}{#1}}
\else
	\newcommand\intro[1]{\cmcontainer{Vorspiel}{#1}}
	\newcommand\interlude[1]{\cmcontainer{Zwischenspiel}{#1}}
	\newcommand\outro[1]{\cmcontainer{Outro}{#1}}
\fi

\newcommand\musf{$\flat$}
\newcommand\muss{$\sharp$}
  
\newcommand\song[1]{\newpage\input{songs/#1}}
  
% Verses/Chords
\newenvironment{strophe}{
 \vskip 0.5em
 \stepcounter{cstrophe}
 \ifenglish
	\textbf{\textsc{Verse} \thecstrophe:}
 \else
	\textbf{\textsc{Strophe} \thecstrophe:}
 \fi
 \begin{addmargin}[1em]{2em}
 \vskip -0.5em
}{
 \end{addmargin}
 \par
 \vskip 0.5em
}
\newenvironment{strophe*}{
 \vskip 0.5em
 \begin{addmargin}[1em]{1em}
 \vskip -0.5em
}{
 \end{addmargin}
 \par
 \vskip 0.5em
}

\newenvironment{chorus}{
 \vskip 0.5em
 \textbf{\textsc{Chorus:}}
 \begin{addmargin}[4em]{1em}
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

\newcommand\cmtabskip{0.2cm}
\newcommand\tbnl{\\[\cmtabskip]}
\newcommand\settabskip[1]{\renewcommand\cmtabskip{#1}}

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

\newcommand\makesongtitle{
 \fancyfoot[LE,RO]{\thepage} % Left side on Even pages; Right side on Odd pages
 \null{
		{\LARGE\thesong. \cmtitle }\hfill{\LARGE\cmartist}\par
		\ifenglish
			{\large \ifthenelse{\cmcapo = 0}{}{Capo: \cmcapo} \hfill from: \cmalbum \par}
		\else
			{\large \ifthenelse{\cmcapo = 0}{}{Capo: \cmcapo} \hfill aus: \cmalbum \par}
		\fi
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
 \addcontentsline{toc}{subsection}{\protect\numberline{\thesong}#1, #2}
 \index{#2@\textbf{#2}!#1}
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
	
\newcommand\blankpagev{%
    \null
    \newpage}
	
\newcommand\br{~\\}

\RequirePackage[svgnames]{xcolor}
\ifpdf
\RequirePackage{pdfcolmk}
\fi
%% drawing package
\RequirePackage{tikz}
\newlength{\drop}% for my convenience
%% Generic publisher’s logo
\newcommand*{\plogo}{\fbox{$\mathcal{PL}$}}
%% Some shades
\definecolor{Dark}{gray}{0.2}
\definecolor{MedDark}{gray}{0.4}
\definecolor{Medium}{gray}{0.6}
\definecolor{Light}{gray}{0.8}


 % Sections
\DeclareDocumentCommand\booksec{m m} {\begingroup% Words in their Hands
  \drop = 3\baselineskip
  \centering
  \vspace*{4cm}\null
  \vspace*{\drop}
  {\fontsize{45}{55}\selectfont #1}\\[2cm]
  {\Large\itshape #2}\\[1cm]
  \vfill
 \endgroup
 \addcontentsline{toc}{chapter}{#1}
 \addcontentsline{toc}{section}{#2}
 \newpage
 }
 
 % Sections
\DeclareDocumentCommand\booksecentry{m m} {\begingroup% Words in their Hands
  \drop = 3\baselineskip
  \centering
  \vspace*{4cm}\null
  \vspace*{\drop}
  {\fontsize{45}{55}\selectfont #1}\\[2cm]
  {\Large\itshape #2}\\[1cm]
  \vfill
 \endgroup
 \addcontentsline{toc}{section}{#2}
 \newpage
 }
 

