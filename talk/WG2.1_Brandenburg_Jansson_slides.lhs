%-*-Latex-*-
\documentclass{beamer}
\usetheme{Madrid}
% Hide navigation symbols
\setbeamertemplate{navigation symbols}{}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8x]{inputenc}
\usepackage{xcolor}
\usepackage{tabu}
\usepackage{hyperref}
\hypersetup{pdfpagemode={FullScreen}}
\RequirePackage{ucs}
\RequirePackage{amsfonts}
\usepackage{tikz}
\usepackage{tikz-cd}
\usetikzlibrary{trees,graphs,quotes}
%include dslmagda.format
%include tfpie2018slides.format
% the `doubleequals' macro is due to Jeremy Gibbons
\def\doubleequals{\mathrel{\unitlength 0.01em
  \begin{picture}(78,40)
    \put(7,34){\line(1,0){25}} \put(45,34){\line(1,0){25}}
    \put(7,14){\line(1,0){25}} \put(45,14){\line(1,0){25}}
  \end{picture}}}

\title[DSLM Examples \& Results]{Examples and Results from a BSc-level Course on\\ Domain Specific Languages of Mathematics}
\date{WG2.1, 2018-07-05}
\author[Jansson, Einarsdóttir, Ionescu]{
\underline{Patrik Jansson} \and Sólrún Halla Einarsdóttir \and Cezar Ionescu}
\institute[FP, Chalmers]{Functional Programming division, Chalmers University of Technology}
\begin{document}
\begin{frame}
\maketitle
\end{frame}
% Introduce course - show example

%% -------------------------------------------------------------------

\begin{frame}
\frametitle{Background to \emph{Domain-Specific Languages of Mathematics}}

\begin{itemize}
\item Gothenburg, 2015 (73:rd meeting): Jansson and Ionescu:  ``\href{http://www.cse.chalmers.se/~patrikj/talks/WG2.1_Goteborg_Jansson_Ionescu_DSLsofMath.pdf}{DSLM - Presenting Mathematical Analysis Using Functional Programming}''.

\item Pedagogical project to develop the course (incl.\ material)
\item 2015: paper at ``Trends in Functional Programming in Education''
\item 2016, 17, 18: Undergraduate course at Chalmers (28, 43, 39 students)
\item 2018: new TFPIE paper (reported on in this talk)
\end{itemize}


% In 2015, at the \href{https://ifipwg21wiki.cs.kuleuven.be/IFIP21/Goteborg}{73rd meeting of IFIP WG2.1, in Gothenburg}, we (Jansson and Ionescu) gave the talk ``\href{http://www.cse.chalmers.se/~patrikj/talks/WG2.1_Goteborg_Jansson_Ionescu_DSLsofMath.pdf}{DSLM - Presenting Mathematical Analysis Using Functional Programming}''.
% \begin{quote}
%   In this talk (and the accompanying paper), we present the approach underlying a course on Domain-Specific Languages of Mathematics, which is currently being developed at Chalmers in response to difficulties faced by third-year students in learning and applying classical mathematics (mainly real and complex analysis). The main idea is to encourage the students to approach mathematical domains from a functional programming perspective: to identify the main functions and types involved and, when necessary, to introduce new abstractions; to give calculational proofs; to pay attention to the syntax of the mathematical expressions; and, finally, to organize the resulting functions and types in domain-specific languages.
% \end{quote}


\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
% TODO: update title & contents!
\frametitle{Course goal and focus}

\begin{block}{Goal}
  Encourage students to approach mathematical domains from a
  functional programming perspective.
\end{block}

\begin{block}{Course focus}
\begin{itemize}
\item Make functions and types explicit

\item Explicit distinction between syntax and semantics

\item Types as carriers of semantic information

%\item introduce functions and types for implicit operations such as the power series interpretation of a sequence

\item Organize the types and functions in DSLs

\item{} [New] Make variable binding and scope explicit
\end{itemize}
\end{block}

Lecture notes and more available at:
  \url{https://github.com/DSLsofMath/DSLsofMath}
\end{frame}



%% -------------------------------------------------------------------

\begin{frame}
\frametitle{Example 1 - The limit of a function}
\begin{quote}
  We say that \(f(x)\) \textbf{approaches the limit} \(L\) as \(x\)
  \textbf{approaches} \(a\), and we write
%
  \[\lim_{x\to a} f(x) = L,\]
%
  if the following condition is satisfied:\\
  for every number \(\varepsilon > 0\) there exists a number
  \(\delta > 0\), possibly depending on \(\varepsilon\), such that if
  $0 < \lvert x - a\rvert < \delta$, then \(x\) belongs to the domain of \(f\)
  and
  \[
    \lvert f(x) - L\rvert  < \varepsilon
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
    \forall \varepsilon > 0\]
    \[\exists \delta > 0\]
  such that
  if \[0 < \lvert x - a\rvert < \delta,\] then
  \[
    x\in Dom\, f \wedge \lvert f(x) - L\rvert  < \varepsilon
  \]
\end{quote}
\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
  \frametitle{Limit of a function - continued}
First attempt at translation:
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (P epsilon delta))

  where  P epsilon delta =  (0 < absBar (x - a) < delta) =>
                            (x `elem` Dom f  && absBar (f x - L) < epsilon)
\end{spec}
\end{frame}

%% -------------------------------------------------------------------

\begin{frame}
  \frametitle{Limit of a function - continued}
Finally (after adding a binding for |x|):
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (P epsilon delta))

  where  P epsilon delta =    Forall x (Q epsilon delta x)

         Q epsilon delta x =  (0 < absBar (x - a) < delta) =>
                              (x `elem` Dom f  && absBar (f x - L) < epsilon)
\end{spec}

\pause
Lesson learned: be careful with scope and binding (of |x| in this case).

\pause
\vspace{1cm}
{\small [We will now assume limits exist and use |lim| as a function from |a| and |f| to |L|.]}

\end{frame}

%% -------------------------------------------------------------------

\newsavebox{\diagramD}
\savebox{\diagramD}{%
\begin{tikzcd}
         \pgfmatrixnextcell \arrow[dl, "|D f|", swap] \arrow[d, "|psi f|"] |REAL| \\
  |REAL| \pgfmatrixnextcell \arrow[l, "|lim 0|"] |(REAL->REAL)|
\end{tikzcd}%
}
\begin{frame}[fragile]{Example 2: derivative}

\begin{quote}
  The \textbf{derivative} of a function |f| is another function |f'| defined by
%
  \[
    f'(x) = \lim_{h \to 0} \frac{f(x+h) - f(x)}{h}
  \]
%
  at all points |x| for which the limit exists (i.e., is a finite real
  number). If \(f'(x)\) exists, we say that |f| is \textbf{differentiable}
  at |x|.
\end{quote}


We can write

\savecolumns
\begin{spec}
  D f x  = lim 0 g        where            g  h = frac (f(x+h) - f x) h
\end{spec}
\pause
\vspace{-0.5cm}
\restorecolumns
\begin{spec}
  D f x  = lim 0 (phi x)  where       phi  x  h = frac (f(x+h) - f x) h
\end{spec}
\pause
\vspace{-0.5cm}
\restorecolumns
\begin{spec}
  D f    = lim 0 . psi f  where  psi  f    x  h = frac (f(x+h) - f x) h {-"\usebox{\diagramD}"-}
\end{spec}
\vspace*{-5cm}\hspace*{8cm}\vspace*{15cm}

\end{frame}

\begin{frame}{Derivatives, cont.}

Examples:

\begin{spec}
  D : (REAL->REAL) -> (REAL->REAL)

  sq x       =  x^2
  double x   =  2*x
  c2 x       =  2

  sq'   ==  D sq   == D (\x -> x^2) == D ({-"{}"-}^2) == (2*) == double
  sq''  ==  D sq'  == D double == c2 == const 2
\end{spec}

Note: we cannot \emph{implement} |D| (of this type) in Haskell.
%

Given only |f : REAL -> REAL| as a ``black box'' we
cannot compute the actual derivative |f' : REAL -> REAL|.

We need the ``source code'' of |f| to apply rules from calculus.

\end{frame}

%% -------------------------------------------------------------------
% Overview - what material does the course cover
\begin{frame}
  \frametitle{Course material (chapters)}
  \begin{enumerate}
  \item A DSL for arithmetic expressions and complex numbers
  \item Logic and calculational proofs
  \item Types in Mathematics
  \item Compositional Semantics and Algebraic Structures
  \item Polynomials and Power Series
  \item Higher-order Derivatives and their Applications
  \item Matrix algebra and linear transformations
  \item Exponentials and Laplace
  \end{enumerate}
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
% Show results

%% -------------------------------------------------------------------
% Student numbers, pass rates
\begin{frame}
\frametitle{Course results}
\begin{itemize}
\item 2016: 28 students, pass rate: 68\%
\item 2017: 43 students, pass rate: 58\%
\item 2018: 39 students, pass rate: 89\%
\end{itemize}
\end{frame}


%% -------------------------------------------------------------------
% Subsequent results
\begin{frame}
\frametitle{Results in subsequent courses}
\begin{table}[h]
  \centering
  \begin{tabu}{l*{3}{c}}
                       & PASS  & IN   & OUT  \\
    \hline
    TSS pass rate   & 77\%  & 57\% & 36\% \\
    \rowfont{\scriptsize}
    TSS mean grade  & 4.23  & 4.10 & 3.58 \\
    Control pass rate   & 68\%  & 45\% & 40\% \\
    \rowfont{\scriptsize}
    Control mean grade  & 3.91  & 3.88 & 3.35 \\

  \end{tabu}
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
  \begin{tabu}{l*{3}{c}}
                                     & PASS  & IN   & OUT  \\
    \hline
    Pass rate for first 3 semesters  & 97\%  & 92\% & 86\% \\
    \rowfont{\scriptsize}
    Mean grade for first 3 semesters & 3.95  & 3.81 & 3.50 \\
    Math/physics pass rate           & 96\%  & 91\% & 83\% \\
    \rowfont{\scriptsize}
    Math/physics mean grade          & 4.01  & 3.84 & 3.55 \\

  \end{tabu}
  %\caption{Pass rate and mean grade for courses taken prior to taking (or not
  % taking) DSLsofMath.}
\end{table}
  Group sizes: PASS 34, IN 53, OUT 92 (145 in all)
\end{frame}

\begin{frame}
\frametitle{Results}
\begin{table}[h]
  \centering
  \begin{tabular}{l*{3}{c}}
                                     & PASS  & IN   & OUT  \\
    \hline
    Pass rate for first 3 semesters  & 97\%  & 92\% & 86\% \\
    Math/physics pass rate           & 96\%  & 91\% & 83\% \\
    TSS pass rate   & 77\%  & 57\% & 36\% \\
    Control pass rate   & 68\%  & 45\% & 40\% \\

  \end{tabular}
  %\caption{Pass rate and mean grade for courses taken prior to taking (or not
  % taking) DSLsofMath.}
\end{table}
  Group sizes: PASS 34, IN 53, OUT 92 (145 in all)

\end{frame}

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
  \item Polish the lecture notes into a book
  \item (Perhaps: more rigorous empirical evaluation of course efficacy)
\end{itemize}

\pause
  \textbf{Questions?}
  % Link to lecture notes!

  \url{https://github.com/DSLsofMath/DSLsofMath}

  [Hint: There are bonus slides;-]
\end{frame}

\subsection{Type inference and understanding: Lagrangian case study}
\begin{frame}{Example 3: Lagrangian}

  From [Sussman 2013, Functional Differential Geometry]:

\begin{quote}
  A mechanical system is described by a Lagrangian function of the
  system state (time, coordinates, and velocities).
%
  A motion of the system is described by a path that gives the
  coordinates for each moment of time.
%
  A path is allowed if and only if it satisfies the Lagrange
  equations.
%
  Traditionally, the Lagrange equations are written

\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]

What could this expression possibly mean?

\end{quote}

\end{frame}

\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]

\begin{itemize}
\item The use of notation for ``partial derivative'', \(∂L / ∂q\), suggests
that |L| is a function of at least a pair of arguments:
\begin{spec}
  L : ℝⁱ → ℝ,    i ≥ 2
\end{spec}

This is consistent with the description: ``Lagrangian function of the
system state (time, coordinates, and velocities)''.
%
So, if we let ``coordinates'' be just one coordinate, we can take |i =
3|:
%
\begin{spec}
  L : ℝ³ → ℝ
\end{spec}
%
The ``system state'' here is a triple, of type |S = (T, Q, V)|,
and we can call the the three components |t : T| for time, |q : Q| for
coordinate, and |v : V| for velocity.
%
(|T = Q = V = ℝ|.)
\end{itemize}
\end{frame}

\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]

\begin{itemize}
\item Looking again at \(∂L / ∂q\), \(q\) is the name of a variable,
  one of the 3 args to \(L\).
%
  In the context, which we do not have, we would expect to find
  somewhere the definition of the Lagrangian as
  %
  \begin{spec}
    L  :  (T, Q, V)  ->  ℝ
    L     (t, q, v)  =   ...
  \end{spec}

\item therefore, \(∂L / ∂q\) should also be a function of the same
  triple:

  \begin{spec}
    (∂L / ∂q) : (T, Q, V) -> ℝ
  \end{spec}

  It follows that the equation expresses a relation between
  \emph{functions}, therefore the \(0\) on the right-hand side is
  \emph{not} the real number \(0\), but rather the constant function
  |const 0|:

  \begin{spec}
    const 0  :  (T, Q, V)  →  ℝ
    const 0     (t, q, v)  =   0
  \end{spec}
\end{itemize}
\end{frame}

\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]
\begin{itemize}
\item We now have a problem: |d / dt| can only be applied to functions
  of \emph{one} real argument |t|, and the result is a function of one
  real argument:

%format dotq = "\dot{q}"
%format ddotq =  ∂ dotq
%format juxtapose f x = f "\," x
\begin{spec}
    juxtapose (d / dt) (∂L / ∂dotq)  :  T → ℝ
\end{spec}

Since we subtract from this the function \(∂L / ∂q\), it follows that
this, too, must be of type |T -> ℝ|.
%
But we already typed it as |(T, Q, V) → ℝ|, contradiction!
%
\label{item:L:contra}

\item The expression \(∂L / ∂\dot{q}\) appears to also be malformed.
%
  We would expect a variable name where we find \(\dot{q}\), but
  \(\dot{q}\) is the same as \(dq / dt\), a function.
\end{itemize}
\end{frame}
\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]
\begin{itemize}
\item The only immediate candidate for an application of \(d/dt\) is
  ``a path that gives the coordinates for each moment of time''.
%
  Thus, the path is a function of time, let us say
%
  \begin{spec}
    w  :  T → Q  -- with |T| for time and |Q| for coords (|q : Q|)
  \end{spec}

  We can now guess that the use of the plural form ``equations'' might
  have something to do with the use of ``coordinates''.
%
  In an |n|-dim.\ space, a position is given by |n| coordinates.
%
  A path would then be
%
  \begin{spec}
    w  :  T → Q  -- with |Q = ℝⁿ|
  \end{spec}
%
  which is equivalent to |n| functions of type |T → ℝ|, each computing
  one coordinate as a function of time.
%
  We would then have an equation for each of them.
%
  We will use |n=1| for the rest of this example.

\end{itemize}

\end{frame}
\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]
\begin{itemize}
\item Now that we have a path, the coordinates at any time are given
  by the path.
  %
  And as the time derivative of a coordinate is a velocity, we can
  actually compute the trajectory of the full system state |(T, Q, V)|
  starting from just the path.
%
  \begin{spec}
    q  :  T → Q
    q t  =  w t        -- or, equivalently, |q = w|

    dotq : T → V
    dotq t = dw /dt    -- or, equivalently, |dotq = D w|
  \end{spec}
%
  We combine these in the ``combinator'' |expand|, given by
  %
  \begin{spec}
    expand : (T → Q) → (T → (T, Q, V))
    expand w t  =  (t, w t, D w t)
  \end{spec}
\end{itemize}
\end{frame}

\begin{frame}{Lagrangian, cont.}
\[\frac{d}{dt} \frac{∂L}{∂\dot{q}} - \frac{∂L}{∂q} = 0\]
\vspace{-0.5cm}
\begin{itemize}
\item With |expand| in our toolbox we can fix the typing problem.
  %
  \begin{spec}
    (∂L / ∂q) . (expand w)  :  T -> ℝ
  \end{spec}


\item We now move to using |D| for |d / dt|, |D₂| for |∂ / ∂q|, and
  |D₃| for |∂ / ∂dotq|.
  %
  In combination with |expand w| we find these type correct
  combinations for the two terms in the equation:
  %
  \begin{spec}
    D ((D₂ L)  ∘  (expand w))  :  T → ℝ
       (D₃ L)  ∘  (expand w )  :  T → ℝ
  \end{spec}

  The equation becomes
  %
  \begin{spec}
    D ((D₃ L) ∘ (expand w))  -  (D₂ L) ∘ (expand w)  =  const 0
  \end{spec}
  or, after simplification:
  \begin{spec}
    D (D₃ L ∘ expand w)  =  D₂ L ∘ expand w
  \end{spec}

\end{itemize}
\end{frame}

\begin{frame}{Example 3: Lagrangian, summary}

  ``A path is allowed if and only if it satisfies the Lagrange
  equations'' means that this equation is a predicate on paths:
  %
  \begin{spec}
    Lagrange(L, w) =  {-"\qquad"-} D (D₃ L ∘ expand w) == D₂ L ∘ expand w
  \end{spec}
  %

  Thus: If we can describe a mechanical system in terms of ``a
  Lagrangian'' (|L : S -> ℝ|), then we can use the predicate to check
  if a particular candidate path |w : T → ℝ| qualifies as a ``motion
  of the system'' or not.
%
  The unknown of the equation is the path |w|, and the equation is an
  example of a partial differential equation (a PDE).

\end{frame}

\end{document}

%% -------------------------------------------------------------------

\begin{frame}
\frametitle{}
\vfill
\vfill
\end{frame}

%% -------------------------------------------------------------------
