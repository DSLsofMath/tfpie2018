%-*-Latex-*-
\documentclass{../eptcsstyle/eptcs}

% current annoyance: this will be fixed
% by the next update of agda.fmt
\def\textmu{}

\usepackage{amsmath}
%include dslmagda.format

\usepackage{todonotes}

\title{TODO: new title needed - was: Domain-Specific Languages of Mathematics:
   Presenting Mathematical Analysis Using Functional Programming}


 \author{
Patrik Jansson
\institute{Chalmers Univ. of Technology}
\email{\quad patrikj@@chalmers.se}
\and
  Sólrún Halla Einarsdóttir
\institute{Chalmers Univ. of Technology}
\email{\quad slrn@@chalmers.se}
\and
Cezar Ionescu
\institute{Chalmers Univ. of Technology}
\email{cezar@@chalmers.se}
}

\def\titlerunning{DSLs of Mathematics}
\def\authorrunning{P. Jansson \& S. H. Einarsdóttir \& C. Ionescu}
\newcommand{\event}{7th International Workshop on Trends in Functional Programming in Education, TFPIE 2018}

\DeclareMathOperator{\Drop}{Drop}



%include dslm.format

\begin{document}

\maketitle

\begin{abstract}

  TODO

\end{abstract}


\section{Introduction}

TODO: background and motivation

TODO: current status (third run of the course, student counts)

link to homepage: \url{https://github.com/DSLsofMath/DSLsofMath}

TODO: cite the lecture notes

\section {Functions and types}
\label{sec:fandt}


\subsection{Two examples}
\label{subsec:twoexamples}


\section{Domain-specific languages}
\label{sec:dsls}


\subsection{A case study: TODO}

\section{Evaluation and results}

% Describe how the ``measurements'' were done and interpret the results.

We considered student results for students from the D program at Chalmers who
started their studies in 2014 and 2015. In the spring of their second year at
Chalmers (2016 and 2017), these students had the option of either taking the
DSLsofMath course or \todo{what goes here?}.

We considered only ``active'' students, that is, students who had signed up for
at least half of the required courses in the D program during the semesters
being considered (Fall 2014 - Fall 2017). This amounted to 145 students, where
53 signed up for the DSLsofMath course (whereas 92 did not) and 34 of those 53
passed the course.

Our hypothesis was that taking our course would help prepare the students for
the math-instensive compulsory courses in the third year which many students
struggle with, Transforms, signals and systems (SSY080) and Reglerteknik (ERE103).

\todo{Table with results of in/out group in those courses}
\todo{Discuss results}
\subsection{Students' previous results}
We were curious to see how we could characterize the students who sign up for
our course...

\todo{discuss results}
\todo{present numbers in table}

\subsection{Significance of taking DSLsofMath}

\todo{Is taking DSLM significant in improving future results or were the
  students just better to begin with?}


\section{Conclusions and future work}


\bibliographystyle{../eptcsstyle/eptcs}
\bibliography{dslm}

%% \appendix
%% \section{Educational context and evaluation}

%% In a first instance, the new course will be an elective course for the
%% second or third year within the BSc programs in CS, CSE, SE, and Math.
%% %
%% The prerequisites are informally one full time year (60 hec) of
%% university level study consisting of a mix of mathematics and computer
%% science.
%% %
%% More formally:

%% \begin{quote}
%%   The student should have successfully completed:
%%   \begin{itemize}
%%   \item a course in discrete mathematics as for example Introductory
%%     Discrete Mathematics.
%%   \item 15 hec in mathematics, for example Linear Algebra and Calculus
%%   \item 15 hec in computer science, for example (Introduction to
%%     Programming or Programming with Matlab) and Object-oriented
%%     Software Development
%%   \item an additional 22.5 hec of any mathematics or computer science
%%     courses.
%%   \end{itemize}
%% \end{quote}


\end{document}


In part, we feel that this is because the logic-based
approach that works in discrete mathematics is too low-level for the
kind of abstractions needed in real and complex analysis.  In
particular, the treatment of functions and datatypes is somewhat
shallow: there are no higher-order functions, recursion is only
treated in the context of recurrence relations for sequences, there is
no discussion of fixed points, and no inductive (let alone
co-inductive) datatypes.


From the review file:

Concepts which cannot be implemented will be dealt with on a
case-by-case basis: we approximate real numbers by floats (and mention
rationals and interval arithmetic as alternatives), we implement some
functions as relations (and mention property based testing and
interactive theorem proving), etc.
