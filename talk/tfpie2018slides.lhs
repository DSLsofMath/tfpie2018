%-*-Latex-*-
\documentclass{beamer}
\usepackage[utf8x]{inputenc}
\usepackage{hyperref}
\usepackage{xcolor}
\usetheme{boxes}
% TODO: look into what other theme to use?
\addheadbox{section}{\quad \tiny TFPIE, 2018-06-14}
\title{Examples and Results from a BSc-level Course on\\ Domain Specific Languages of Mathematics}

\author[P. Jansson and S.H. Einarsdóttir and C. Ionescu]{
  Patrik Jansson
  %\qquad {\small \texttt{ patrikj@@chalmers.se}}\\
\and
\underline{Sólrún Halla Einarsdóttir}
%\qquad {\small \texttt{slrn@@chalmers.se}}\\
\and
Cezar Ionescu
%\qquad {\small \texttt{cezar@@chalmers.se}}
} %TODO: get this more nicely aligned

\begin{document}
\setbeamertemplate{navigation symbols}{}
\date{}
\begin{frame}

\maketitle

\end{frame}
% Introduce course - show example

%% -------------------------------------------------------------------

\begin{frame}
\frametitle{Introduction}
\emph{Domain-Specific Languages of Mathematics} (DSLsofMath)
\begin{itemize}
\item Undergraduate course developed at Chalmers, taught since 2016.
\item Goal: Encourage students to approach mathematical domains from a
functional programming perspective.
\end{itemize}
\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
% TODO: update title & contents!
\frametitle{Course focus}

\begin{itemize}
\item Make functions and types explicit

\item Explicit distinction between syntax and semantics

\item Types as carriers of semantic information

%\item introduce functions and types for implicit operations such as the power series interpretation of a sequence

\item Organize the types and functions in DSLs

\item Make variable binding and scope explicit
\end{itemize}

\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
\frametitle{Example - The limit of a function}
\begin{quote}
  We say that \(f(x)\) \textbf{approaches the limit} \(L\) as \(x\)
  \textbf{approaches} \(a\), and we write
%
  \[\lim_{x\to a} f(x) = L,\]
%
  if the following condition is satisfied:\\
  for every number \(\epsilon > 0\) there exists a number
  \(\delta > 0\), possibly depending on \(\epsilon\), such that if
  $0 < \lvert x - a\rvert < \delta$, then \(x\) belongs to the domain of \(f\)
  and
  \[
    \lvert f(x) - L\rvert  < \epsilon
  \]
\end{quote}
\begin{flushright}
  - Adams \& Essex, Calculus - A Complete Course
\end{flushright}
\end{frame}
%% -------------------------------------------------------------------

\begin{frame}
  \frametitle{Limit of a function - continued}
\begin{quote}
%
  \[\lim_{x\to a} f(x) = L,\]
%
  if \[
    \forall \epsilon > 0\]
    \[\exists \delta > 0\]
  such that
  if \[0 < \lvert x - a\rvert < \delta,\] then
  \[
    x\in Dom\, f \wedge \lvert f(x) - L\rvert  < \epsilon
  \]
\end{quote}
\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
  \frametitle{Limit of a function - continued}
First attempt at translation:
  \[
  lim\; a\; f\; L  =  \forall (\epsilon > 0) (\exists (\delta > 0) (P \; \epsilon\; \delta))
\]
where
\[P \;\epsilon \;\delta = (0 < \lvert x - a\rvert < \delta) \Rightarrow (x \in
  Dom\, f  \wedge \lvert f(x) - L\rvert < \epsilon))\]
\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
  \frametitle{Limit of a function - continued}
Finally:
\[
  lim\; a\; f\; L  =  \forall (\epsilon > 0) (\exists (\delta > 0) (\forall x (P
  \; \epsilon\; \delta\; x)))
\]
where
\[P \;\epsilon \;\delta \; x = (0 < \lvert x - a\rvert < \delta) \Rightarrow (x \in
  Dom\, f  \wedge \lvert f(x) - L\rvert < \epsilon))\]
\end{frame}

%% -------------------------------------------------------------------
% Overview - what material does the course cover
\begin{frame}
  \frametitle{Course material}
  \begin{itemize}
  \item A DSL for arithmetic expressions and complex numbers
  \item Logic and calculational proofs
  \item Types in Mathematics
  \item Compositional Semantics and Algebraic Structures
  \item Polynomials and Power Series
  \item Higher-order Derivatives and their Applications
  \item Matrix algebra and linear transformations
  \item Exponentials and Laplace
  \end{itemize}
\end{frame}

%% -------------------------------------------------------------------
% Where is the course in the curriculum and why was it developed for this program
\begin{frame}
\frametitle{Course context}
% TODO: more contents here - image thingy?
\begin{itemize}
\item Semi-compulsory course, spring of second year in CSE programme
\item Students struggle with math-heavy courses in third year
\item Students do well with (functional) programming
\item Can a functional programming perspective help to clarify the mathematics?
\end{itemize}
\end{frame}

% Show results

%% -------------------------------------------------------------------
% Student numbers, pass rates
\begin{frame}
\frametitle{Course results}
\begin{itemize}
\item 2016: 28 students, pass rate: 58\%
\item 2017: 43 students, pass rate: 68\%
\item 2018: 39 students, pass rate: 89\%
\end{itemize}
\end{frame}

%% -------------------------------------------------------------------
% Table
\begin{frame}
\frametitle{CSE program}
\begin{table}[h]
  \centering
  \begin{tabular}{lll}
                       & Fall  & Spring\\
    \hline
    Year 1  & \textcolor{gray}{Compulsory courses}  & \textcolor{gray}{Compulsory courses} \\
    Year 2  & \textcolor{gray}{Compulsory courses}  & \textcolor{red}{DSLsofMath} OR ConcProg \\
    Year 3  & \textcolor{blue}{TSS + Control}  & ... \\

  \end{tabular}
\end{table}

\end{frame}

%% -------------------------------------------------------------------
% Subsequent results
\begin{frame}
\frametitle{Results in subsequent courses}
\begin{table}[h]
  \centering
  \begin{tabular}{l*{3}{c}}
                       & PASS  & IN   & OUT  \\
    \hline
    TSS pass rate   & 77\%  & 57\% & 36\% \\
    TSS mean grade  & 4.23  & 4.10 & 3.58 \\
    Control pass rate   & 68\%  & 45\% & 40\% \\
    Control mean grade  & 3.91  & 3.88 & 3.35 \\

  \end{tabular}
  %\caption{Pass rate and mean grade in third year courses for students who took and
  %  passed DSLsofMath and those who did not.}
\end{table}
  Group sizes: PASS 34, IN 53, OUT 92 (145 in all)

\end{frame}

% Prior results
\begin{frame}
\frametitle{Results in previous courses}
\begin{table}[h]
  \centering
  \begin{tabular}{l*{3}{c}}
                                     & PASS  & IN   & OUT  \\
    \hline
    Pass rate for first 3 semesters  & 97\%  & 92\% & 86\% \\
    Mean grade for first 3 semesters & 3.95  & 3.81 & 3.50 \\
    Math/physics pass rate           & 96\%  & 91\% & 83\% \\
    Math/physics mean grade          & 4.01  & 3.84 & 3.55 \\

  \end{tabular}
  %\caption{Pass rate and mean grade for courses taken prior to taking (or not
  % taking) DSLsofMath.}
\end{table}
  Group sizes: PASS 34, IN 53, OUT 92 (145 in all)
\end{frame}

%\begin{frame}
%\frametitle{}
%\vfill
%\vfill
%\end{frame}

% Student feedback?

% Another example?

% Conclusions
% Future work?
\begin{frame}
\frametitle{Future work}
\begin{itemize}
  \item Working with earlier and later courses, can these ideas be useful in
    their curriculum? 
  \item Better tool support in the course, proof systems?
  \item More rigorous empirical evaluation of course efficacy
    
\end{itemize}

\end{frame}
\begin{frame}
  \frametitle{Thanks!}
  % Link to lecture notes!
  \url{https://github.com/DSLsofMath/DSLsofMath}
\end{frame}


\end{document}

%% -------------------------------------------------------------------

\begin{frame}
\frametitle{}
\vfill
\vfill
\end{frame}

%% -------------------------------------------------------------------
