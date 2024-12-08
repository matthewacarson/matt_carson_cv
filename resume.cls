%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Medium Length Professional CV
% LaTeX Class
% Version 3.0 (December 17, 2022)
%
% This template has been downloaded from:
% http://www.LaTeXTemplates.com
%
% Original header:
% Copyright (C) 2010 by Trey Hunner
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
% Created by Trey Hunner and modified by www.LaTeXTemplates.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\ProvidesClass{resume}[2022/12/17 v3.0 Resume class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES AND MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------
\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for bold tabular columns
\usepackage{ifthen} % Required for ifthenelse statements
\usepackage{graphicx} % Required for including images
%\pagestyle{empty} % Suppress headers and footers on all pages
\usepackage[hidelinks]{hyperref}
\usepackage{fontawesome5} % Package for icons
\usepackage{textcomp}
\usepackage{multicol}
%\usepackage{ebgaramond} % Use the EB Garamond font
\usepackage{changepage}
\usepackage{fancyhdr}
\usepackage{lastpage}
\usepackage{geometry} % Required for adjusting page dimensions and margins
\usepackage{booktabs}
% \usepackage{bibentry} % For inline bibliography entries
% \usepackage[style=numeric,sorting=ydnt]{biblatex} % Numeric style with square brackets
\usepackage[sorting=ydnt]{biblatex}
% \usepackage{filecontents} % To create an inline .bib file

\begin{filecontents}{publication.bib}
@article{carson2023globalwarming,
  title={Global Warming and the Takings Clause: Can Eminent Domain Be Used to Avert a Climate Crisis?},
  author={Carson, Matthew},
  journal={ThinkYou?!},
  year={2023},
  url={https://bit.ly/CarsonThinkYou},
  month={11}
}

@article{carson2021enginesout,
  title={Engines Out and Pickets Up to Stop Health Plan Downgrade by Cummins},
  author={Carson, Matt and Brower Brown, Keith and Teevan, Ella},
  journal={Labor Notes},
  year={2021},
  url={https://bit.ly/EnginesOut},
  month={6}
}
\end{filecontents}

\addbibresource{publication.bib} % Link to the .bib file

\nocite{*} % Include all entries from the .bib file

% Reverse numbering in publications list
\newcounter{entrycount}
\AtDataInput{\stepcounter{entrycount}}
\DeclareFieldFormat{labelnumber}{\mkrevbibnum{#1}}
\newcommand{\mkrevbibnum}[1]{\number\numexpr\value{entrycount}+1-#1}
%----------------------------------------------------------------------------------------
%	NAME AND ADDRESS COMMANDS
%----------------------------------------------------------------------------------------

\newcommand{\name}[1]{\renewcommand{\name}{#1}} % Defines the \name command to set the user's name

\newcommand{\addressSep}{$\diamond$} % Set default address separator to a diamond symbol

% One, two or three address lines can be specified
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

% The \address command is used to set the first, second and third address lines (the last 2 are optional)
\newcommand{\address}[1]{
	\@ifundefined{@addressone}{ % If the first address line has not been set yet, set it
		\def \@addressone {#1}
	}{
		\@ifundefined{@addresstwo}{ % If the second address line has not been set yet, set it
			\def \@addresstwo {#1}
		}{ % Otherwise, set the third address line
			\def \@addressthree {#1}
		}%
	}
}

% \printaddress is used to style an address line (provided in the single parameter to the command)
\newcommand{\printaddress}[1]{
	\begingroup
		\def \\ {\addressSep\ } % Redefine newlines (\\) to the address separator symbol so multiple lines of each address are output as a single line
		\centerline{#1} % Output the centered address line
	\endgroup
	\par % End the paragraph to ensure correct spacing between lines
	\smallskip % Vertical whitespace between address lines
}

% \printname is used to output the user's name in a large size
\newcommand{\printname}{
	\begingroup
		\hfil{\MakeUppercase{\huge\bfseries\name}}\hfil % Style and output the user's name
		\bigskip\break % Vertical whitespace below name
	\endgroup
}

%----------------------------------------------------------------------------------------
%	OUTPUT THE NAME & ADDRESS LINES AUTOMATICALLY
%----------------------------------------------------------------------------------------

\let\ori@document=\document % Store the original \document command
\renewcommand{\document}{
	\ori@document  % Output the original \document command but add to it below
%	\printname % Output the user's name
	\@ifundefined{@addressone}{}{\printaddress{\@addressone}} % Output the first address if specified
	\@ifundefined{@addresstwo}{}{\printaddress{\@addresstwo}} % Output the second address if specified
	\@ifundefined{@addressthree}{}{\printaddress{\@addressthree}} % Output the third address if specified
}

%----------------------------------------------------------------------------------------
%	SECTION FORMATTING
%----------------------------------------------------------------------------------------

% Defines the rSection environment for the major sections within the CV
% \newenvironment{rSection}[1]{ % The single parameter is for the section title
% 	\medskip % Vertical whitespace
% 	\MakeUppercase{\textbf{#1}} % Section title
% 	\medskip % Vertical whitespace
% 	\hrule % Horizontal rule
% 	\begin{list}{}{ % List to indent the entire content of the section
% 		\setlength{\leftmargin}{10pt} % Indent to the left of the list
% 	}
% 	\item[] % Empty list item to enable indentation
    
% }{
% 	\end{list}
% }

\usepackage{needspace}

\newenvironment{rSection}[1]{ % The single parameter is for the section title
    \Needspace{5\baselineskip} % Ensure at least 3 lines stay together
    \medskip % Vertical whitespace
    \MakeUppercase{\textbf{#1}} % Section title
    \medskip % Vertical whitespace
    \hrule % Horizontal rule
    \begin{list}{}{ % List to indent the entire content of the section
        \setlength{\leftmargin}{1pt} % Indent to the left of the list
    }
    \item[] % Empty list item to enable indentation
}{
    \end{list}
}


%----------------------------------------------------------------------------------------
%	SUBSECTION FORMATTING
%----------------------------------------------------------------------------------------

\newenvironment{rSubsection}[4]{ % 4 parameters: company name, year(s) employed, job title and location
	\textbf{#1} \hfill {#2} % Bold company name and date to the right
	\ifthenelse{\equal{#3}{}}{}{ % If the third parameter is empty, don't output the job title and location line
		\\ % Job title and location on a new line
		\textit{#3} \hfill \textit{#4} % Output job title and location
	}%
	\smallskip % Vertical whitespace
	\begin{list}{$\cdot$}{\leftmargin=0em} % \cdot used for bullets, no indentation
		\setlength{\itemsep}{-0.5em} \vspace{-0.5em} % Reduce vertical spacing between items in the list for a tighter look
}{
	\end{list}
	\vspace{0.5em} % Vertical whitespace after the end of the list
}
