%% ==============================================================================
% This is the new ITA LateX class - classe de documento com padrões do ITA
% written by
%              Bruno Thiago Rego Valeriano Silva - brunothiagorvs@gmail.com
%                  For suggestions and questions -  https://github.com/brunotvs/itatex.git
%
% inspired by the work of:
%              Fábio Fagundes Silveira           -  ffs [at] ita [dot] br
%              Benedito C. O. Maciel             -  bcmaciel [at] ita [dot] br
%              Giovani Volnei Meinertz           -  giovani [at] ita [dot] br
%              Hudson Alberto Bode               -  bode [at] ita [dot]br
%              P. I. Braga de Queiroz            -  pi [at] ita [dot] br
%              Jorge A. B. Gripp                 -  gripp [at] ita [dot] br
%              Juliano Monte-Mor                 -  jamontemor [at] yahoo [dot] com [dot] br
%              Tarcisio A. B. Gripp              -  tarcisio.gripp [at] gmail [dot] com
%
% last updated: 
%        $Id: ita.cls 2019-10-07$
%        $HeadURL: http://www.apgita.org.br/apgita/teses-e-latex.php $
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ita}[2019/10/07 ITA class for scientific documents]

\newcommand{\DocumentType}{\relax}
\newcommand{\AuthorGender}{\relax}
\newcommand{\CoverType}{\relax}
\newcounter{whileloop} \setcounter{whileloop}{0}
\newcommand{\@i}{whileloop}

\DeclareOption{tg}{%
    \renewcommand{\DocumentType}{tg}%
    \renewcommand{\CoverType}{tg}%
}

\DeclareOption{msc}{%
    \renewcommand{\DocumentType}{msc}%
    \renewcommand{\CoverType}{thesis}%
}

\DeclareOption{dsc}{%
    \renewcommand{\DocumentType}{dsc}%
    \renewcommand{\CoverType}{thesis}%
}

\DeclareOption{msp}{%
    \renewcommand{\DocumentType}{msp}%
    \renewcommand{\CoverType}{thesis}%
}


\DeclareOption{quali}{%
    \renewcommand{\DocumentType}{quali}%
}

\DeclareOption{male}{%
    \renewcommand{\AuthorGender}{male}%
}

\DeclareOption{female}{%
    \renewcommand{\AuthorGender}{female}%
}

\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{book}
}

\ExecuteOptions{msc,female,twoside,openright}
\ProcessOptions\relax

\LoadClass{book}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{setspace}
\RequirePackage{lastpage}
\RequirePackage{bookmark}
\RequirePackage{graphicx}

\InputIfFileExists{texts/pt-br.tex}{}{}

\InputIfFileExists{coverpages/\CoverType.tex}{}{}
\InputIfFileExists{coverpages/cip.tex}{}{}

\InputIfFileExists{helpers/macros.tex}{}{}
\InputIfFileExists{helpers/envs.tex}{}{}
\InputIfFileExists{helpers/controls.tex}{}{}
\InputIfFileExists{helpers/sections.tex}{}{}

\def\pagenumbering#1{%
    \gdef\thepage{\csname @#1\endcsname
    \c@page}%
}

\setcounter{secnumdepth}{5}

% Set page lengths (margins, headers, footers etc.)

\onehalfspacing

\setlength\oddsidemargin{3cm-1in}%
\ifthenelse{\boolean{@twoside}}{%
    \setlength\evensidemargin{2cm-1in}%

}{%
    \setlength\evensidemargin{3cm-1in}%
}

\setlength\textwidth{16cm}
\setlength\textheight{247mm}
\setlength\headsep{15mm-\headheight}
\setlength\topmargin{3cm-1in-\headheight-\headsep}
\setlength{\parindent}{3.5em}
\setlength{\parskip}{\baselineskip}

\newcommand{\workarea}[1]{%
    \renewcommand{\@workarea}{#1}
}

\newcommand{\workcourse}[1]{%
    \renewcommand{\@workcourse}{#1}
}

\newcommand{\author@a}{\empty}
\newcommand{\defauthor@a}{%
    \ifthenelse{\equal{\AuthorGender}{male}}%
    {%
        \ifthenelse{\equal{\thec@author}{1}}
        {%
            \renewcommand{\author@a}{\author@m@s}%
        }{%
            \renewcommand{\author@a}{\author@m@p}%
        }
    }{%
        \ifthenelse{\equal{\thec@author}{1}}
        {%
            \renewcommand{\author@a}{\author@f@s}%
        }{%
            \renewcommand{\author@a}{\author@f@p}%
        }
    }
}

\renewcommand{\author}[2][\empty]{%
    \def\author@name{#2}
    \gdef\@author{%
        \ifthenelse{\equal{#1}{\empty}}{}{%
            #1~%
        }%
        #2
    }%
    \@addauthor{#1}{#2}%
}

\newcounter{c@author} \setcounter{c@author}{0}
\newcommand{\@addauthor}[2]{%
    \stepcounter{c@author}
    \expandafter\def\csname @author\Roman{c@author}\endcsname{%
        \ifthenelse{\equal{#1}{\empty}}{}{%
            #1~%
        }%
        #2
    }%
    \expandafter\def\csname author\Roman{c@author}@name\endcsname{%
        #2%
    }%
    \expandafter\def\csname author\Roman{c@author}@last\endcsname{\TheLastWord{%
        #2%
    }}%
    \expandafter\def\csname author\Roman{c@author}@first\endcsname{\RemoveTheLastWord{%
        #2%
    }}%
}

\newcommand{\@authors}{%
    \setcounter{\@i}{0}%
    \whiledo{\value{\@i}<\value{c@author}}{%
        \ifthenelse{\value{\@i}<\value{c@author}\and\value{\@i}>0}{, }{}%
        \stepcounter{\@i}%        
        \csname author\Roman{\@i}@name\endcsname%        
    }%
}

\newcommand{\@Authors}{%
    \setcounter{\@i}{0}%
    \whiledo{\value{\@i}<\value{c@author}}{%
        \stepcounter{\@i}%        
        \csname @author\Roman{\@i}\endcsname\par%        
    }%
}


\newcommand{\address}[1]{%
    \renewcommand{\@address}{#1}%
    \@addadres{#1}
}

\newcommand{\@address}{\@empty}

\newcounter{c@address} \setcounter{c@address}{0}
\newcommand{\@addadres}[1]{%
    \stepcounter{c@address}%
    \expandafter\def\csname @address\Roman{c@address}\endcsname{#1}%
}

\newcommand{\author@address}{%
    \setcounter{\@i}{0}%
    \newcounter{@temp} \setcounter{@temp}{\value{c@author}}
    \whiledo{\value{\@i}<\value{@temp}}{%
        \stepcounter{\@i}             
        \noindent\begin{minipage}{.5\textwidth}
            \rule{6cm}{.1pt}\par%
            \csname author\Roman{\@i}@name\endcsname\par%
            \csname @address\Roman{\@i}\endcsname\par%
        \end{minipage}%
        \ifthenelse{\isodd{\value{\@i}}}{\hfill}{\par\vfill\par}%
    }%  
}

\newcommand{\authors@ref@n}{0}
\newcommand{\authors@ref}{%
    \setcounter{\@i}{\authors@ref@n}%
    \whiledo{\value{\@i}<\value{c@author}}{%
        \ifthenelse{\value{\@i}<\value{c@author}\and\value{\@i}>0}{; }{}%
        \stepcounter{\@i}%
        \MakeUppercase{\csname author\Roman{\@i}@last\endcsname}, %        
        \csname author\Roman{\@i}@first\endcsname{}%        
    }%
}

\newcounter{c@cip} \setcounter{c@cip}{1}
\newcommand{\cip@authors}{%
    \setcounter{\@i}{1}%
    \whiledo{\value{\@i}<\value{c@author}}{%
        \stepcounter{\@i}%
        \Roman{c@cip}.~%
        \csname author\Roman{\@i}@name\endcsname. %        
        \stepcounter{c@cip}%
    }%
}

\newcommand{\author@last}{\TheLastWord{\author@name}}
\newcommand{\author@first}{\RemoveTheLastWord{\author@name}}

\newcommand{\@CDU}{\empty}
\newcommand{\CDU}[1]{\renewcommand{\@CDU}{CDU~#1}}

\newcommand{\@sep}{&}

\newcounter{c@adv}\setcounter{c@adv}{0}
\newcommand{\advisor}[5]{%
    \def\adv@prof{\csname #2@#1\endcsname}%
    \def\adv@title{\csname #3@#1\endcsname}%
    \def\adv@name{#4}%
    \def\adv@text{\csname adv@#1\endcsname}%
    \def\adv@inst{#5}%
    \@addadvisor{#1}{#2}{#3}{#4}{#5}%
    \@addsubscriber{#1}{#2}{#3}{#4}{adv}{#5}%
    \@addmember{#1}{#2}{#3}{#4}{adv}{#5}%
}

\newcommand{\@addadvisor}[5]{%
    \stepcounter{c@adv}%
    \expandafter\def\csname adv\Roman{c@adv}@prof\endcsname{\csname #2@#1\endcsname}%
    \expandafter\def\csname adv\Roman{c@adv}@title\endcsname{\csname #3@#1\endcsname}%
    \expandafter\def\csname adv\Roman{c@adv}@name\endcsname{#4}%
    \expandafter\def\csname adv\Roman{c@adv}@text\endcsname{\csname adv@#1\endcsname}%
    \expandafter\def\csname adv\Roman{c@adv}@inst\endcsname{#5}%
}

\newcommand{\adv@plain}{%
    \setcounter{\@i}{0}%
    \whiledo{\value{\@i}<\value{c@adv}}{%
        \ifthenelse{\value{\@i}<\value{c@adv}\and\value{\@i}>0}{, }{}%
        \stepcounter{\@i}%
        \csname adv\Roman{\@i}@prof\endcsname~%
        \csname adv\Roman{\@i}@title\endcsname~%
        \csname adv\Roman{\@i}@name\endcsname%    
    }%
}

\newcounter{c@coadv}\setcounter{c@coadv}{0}
    \newcommand{\coadvisor}[5]{%
        \def\coadv@prof{\csname #2@#1\endcsname}%
        \def\coadv@title{\csname #3@#1\endcsname}%
        \def\coadv@name{#4}%
        \def\coadv@text{\csname adv@#1\endcsname}%
        \def\coadv@inst{#5}%
        \@addcoadvisor{#1}{#2}{#3}{#4}{#5}%
        \@addsubscriber{#1}{#2}{#3}{#4}{adv}{#5}%
        \@addmember{#1}{#2}{#3}{#4}{adv}{#5}%
}

\newcommand{\@addcoadvisor}[5]{%
    \stepcounter{c@coadv}%
    \expandafter\def\csname coadv\Roman{c@coadv}@prof\endcsname{\csname #2@#1\endcsname}%
    \expandafter\def\csname coadv\Roman{c@coadv}@title\endcsname{\csname #3@#1\endcsname}%
    \expandafter\def\csname coadv\Roman{c@coadv}@name\endcsname{#4}%
    \expandafter\def\csname coadv\Roman{c@coadv}@text\endcsname{\csname coadv@#1\endcsname}%
    \expandafter\def\csname coadv\Roman{c@coadv}@inst\endcsname{#5}%
}

\newcommand{\coadv@plain}{%
    \setcounter{\@i}{0}%
    \whiledo{\value{\@i}<\value{c@coadv}}{%
        \ifthenelse{\value{\@i}<\value{c@coadv}\and\value{\@i}>0}{, }{}%
        \stepcounter{\@i}%
        \csname coadv\Roman{\@i}@prof\endcsname~%
        \csname coadv\Roman{\@i}@title\endcsname~%
        \csname coadv\Roman{\@i}@name\endcsname%     
    }%
}

% \subscriber{f or m [gender]}{prof or blank}{d or m [title]}
%           {name}{adv or coadv or rec}
\newcounter{c@subs}\setcounter{c@subs}{0}
\newcommand{\subscriber}[6]{%
    \def\subs@prof{\csname #2@#1\endcsname}%
    \def\subs@title{\csname #3@#1\endcsname}%
    \def\subs@name{#4}
    \def\subs@text{\csname #5@#1\endcsname}%
    \def\subs@inst{#6}%
    \@addsubscriber{#1}{#2}{#3}{#4}{#5}{#6}
}

\newcommand{\@addsubscriber}[6]{%
    \stepcounter{c@subs}
    \expandafter\def\csname subs\Roman{c@subs}@prof\endcsname{\csname #2@#1\endcsname}%
    \expandafter\def\csname subs\Roman{c@subs}@title\endcsname{\csname #3@#1\endcsname}%
    \expandafter\def\csname subs\Roman{c@subs}@name\endcsname{#4}
    \expandafter\def\csname subs\Roman{c@subs}@text\endcsname{\csname #5@#1\endcsname}%
    \expandafter\def\csname subs\Roman{c@subs}@inst\endcsname{#6}%
}

\newcounter{c@memb}\setcounter{c@memb}{0}
\newcommand{\member}[6]{%
    \def\subs@prof{\csname #2@#1\endcsname}%
    \def\subs@title{\csname #3@#1\endcsname}%
    \def\subs@name{#4}
    \def\subs@text{\csname #5@#1\endcsname}%
    \def\subs@inst{#6}%
    \@addmember{#1}{#2}{#3}{#4}{#5}{#6}
}

\newcommand{\@addmember}[6]{%
    \stepcounter{c@memb}
    \expandafter\def\csname memb\Roman{c@memb}@prof\endcsname{\csname #2@#1\endcsname}%
    \expandafter\def\csname memb\Roman{c@memb}@title\endcsname{\csname #3@#1\endcsname}%
    \expandafter\def\csname memb\Roman{c@memb}@name\endcsname{#4}
    \expandafter\def\csname memb\Roman{c@memb}@text\endcsname{\csname #5@#1\endcsname}%
    \expandafter\def\csname memb\Roman{c@memb}@inst\endcsname{#6}%
}

\newcommand{\memb@line}{%
    \setcounter{\@i}{0}%
    \whiledo{\value{\@i}<\value{c@memb}}{%
        \stepcounter{\@i}%
        \csname memb\Roman{\@i}@prof\endcsname{}~%
        \csname memb\Roman{\@i}@title\endcsname{}~%
        \csname memb\Roman{\@i}@name\endcsname\@sep\hfill\@sep%
        \csname memb\Roman{\@i}@text\endcsname\@sep-\@sep%
        \csname memb\Roman{\@i}@inst\endcsname\\
    }
}

\newcommand{\sub@line}{%
    \setcounter{\@i}{0}
    \whiledo{\value{\@i}<\value{c@subs}}{%
        \stepcounter{\@i}
        \csname subs\Roman{\@i}@prof\endcsname{}~%
        \csname subs\Roman{\@i}@title\endcsname{}~%
        \csname subs\Roman{\@i}@name\endcsname\par%
        \vspace{-\parskip}\csname subs\Roman{\@i}@text\endcsname%
        \vfill\par
    }
}


\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

\newcommand{\@keywords}{\@empty}

\AtBeginDocument{%
    \@ifpackageloaded{biblatex}{%
        \defbibenvironment{bibliography}
            {\singlespacing\list{}
            {\setlength{\leftmargin}{\bibhang}%
            \setlength{\itemindent}{-\leftmargin}%
            \setlength{\itemsep}{2ex}%
            \setlength{\parsep}{\bibparsep}}}
            {\endlist}
            {\item}

        \defbibheading{bibliography}[\refname]{%
            \chapter*{#1}%
            \addcontentsline{toc}{chapter}{#1}%
            \markboth{\MakeUppercase#1}{\MakeUppercase#1}
            \vspace{-\itemsep}
        } 
    }{}

    \@ifpackagewith{babel}{english}{%
        \makeatletter
        \InputIfFileExists{texts/eng.babel}{}{}
        \makeatother
    }{}

    \defauthor@a \defa@o
    \RequirePackage{datetime2}
    \DTMsetup{useregional}
    \newcommand{\my@date}{\DTMdate{\@date}}
    \DTMsavedate{mydate}{\@date}
    \newcommand{\date@year}{\DTMfetchyear{mydate}}
}
