%-*-Latex-*-
\documentclass{../eptcsstyle/eptcs}

% current annoyance: this will be fixed
% by the next update of agda.fmt
\def\textmu{}

\usepackage{amsmath}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{ucs}
%include dslmagda.format
%include dslm.format

% the `doubleequals' macro is due to Jeremy Gibbons
\def\doubleequals{\mathrel{\unitlength 0.01em
  \begin{picture}(78,40)
    \put(7,34){\line(1,0){25}} \put(45,34){\line(1,0){25}}
    \put(7,14){\line(1,0){25}} \put(45,14){\line(1,0){25}}
  \end{picture}}}
%% If you remove the %format == command the lhs2TeX default yields ≡, which can be a problem
\def\tripleequals{\mathrel{\unitlength 0.01em
  \begin{picture}(116,40)
    \put(7,34){\line(1,0){25}} \put(45,34){\line(1,0){25}} \put(83,34){\line(1,0){25}}
    \put(7,14){\line(1,0){25}} \put(45,14){\line(1,0){25}} \put(83,14){\line(1,0){25}}
  \end{picture}}}

\title{Examples and Results from a BSc-level Course on\\ Domain Specific Languages of Mathematics}

\author{
  Patrik Jansson
  \institute{Chalmers Univ. of Technology}
  \email{\quad patrikj@@chalmers.se}
\and
  Sólrún Einarsdóttir
  \institute{Chalmers Univ. of Technology}
  \email{\quad slrn@@chalmers.se}
\and
  Cezar Ionescu
  \institute{Chalmers Univ. of Technology}%TODO: perhaps Oxford now?
  \email{cezar@@chalmers.se}
}

\def\titlerunning{Examples from DSLs of Mathematics}
\def\authorrunning{P. Jansson \& S. Einarsdóttir \& C. Ionescu}
\newcommand{\event}{7th International Workshop on Trends in Functional Programming in Education, TFPIE 2018}

\DeclareMathOperator{\Drop}{Drop}



%include dslm.format

\begin{document}

\maketitle

\begin{abstract}

  TODO

\end{abstract}


\section{Introduction}

TODO: textify background and motivation: What is ``DSLs of Math''?

  ``Domain Specific Languages of Mathematics''
  \url{https://github.com/DSLsofMath/}

  \begin{itemize}
  \item A BSc-level course (2016-01 CeIo, 2017 onwards: PaJa, DaSc)

   TODO: more on current status (student counts, hints about results from LADOK)

  \item A pedagogical project to develop the course (DaHe, SoEi)

  \item A BSc thesis project ``Learn You a Physics'' (see appendix
     \ref{app:LearnYouAPhysics})

  \end{itemize}

  Aim: ``\ldots improve the mathematical education of computer
  scientists and the computer science education of mathematicians.''

  Focus on types \& specifications, syntax \& semantics

  DSL examples: Power series, Differential equations, Linear Algebra


TODO: cite the lecture notes: \cite{JanssonIonescuDSLsofMathCourse}

TODO: cite the earlier TFPIE paper \cite{DBLP:journals/corr/IonescuJ16}

\section{Types in Mathematics}


\subsection{Two examples}
\label{subsec:twoexamples}


\paragraph{Case 1: limits \cite{adams2010calculus}}

\begin{quote}
  We say that \(f(x)\) \textbf{approaches the limit} \(L\) as \(x\)
  \textbf{approaches} \(a\), and we write
\vspace{-0.5cm}

  \[\lim_{x\to a} f(x) = L,\]

  if the following condition is satisfied:\\
  for every number \(\epsilon > 0\) there exists a number
  \(\delta > 0\), possibly depending on \(\epsilon\), such that if
  |0 < absBar (x - a) < delta|, then \(x\) belongs to the domain of \(f\)
  and
  \begin{spec}
    absBar (f(x) - L) < epsilon {-"."-}
  \end{spec}

\end{quote}

Four parts: name |x|, point |a|, expr.\ \(f(x)\), limit |L|.

Name + expr. combines to just |f|: thus three parts: |a|, |f|, and |L|.

%format Dom f = "\mathcal{D}" f

First attempt:
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (P epsilon delta))
  where  P epsilon delta = (0 < absBar (x - a) < delta) => (x `elem` Dom f  && absBar (f x - L) < epsilon))
\end{spec}

Where did |x| come from?

Second attempt:
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (Forall x (P epsilon delta x)))
  where  P epsilon delta x = (0 < absBar (x - a) < delta) => (x `elem` Dom f  && absBar (f x - L) < epsilon))
\end{spec}

\paragraph{Case 2: derivative}

We now assume limits exist and use |lim| as a function from |a| and |f| to |L|.

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

TODO: add explanation for the next step

\restorecolumns
\begin{spec}
  D f x  = lim 0 (phi x)  where       phi  x  h = frac (f(x+h) - f x) h
\end{spec}

TODO: add explanation for the next step

\restorecolumns
\begin{spec}
  D f    = lim 0 . psi f  where  psi  f    x  h = frac (f(x+h) - f x) h
\end{spec}

Examples:

\begin{spec}
  D : (REAL->REAL) -> (REAL->REAL)

  sq x      =  x^2
  double x  =  2*x
  c2 x      =  2
  sq'   =  D sq   = D (\x -> x^2) = D ({-"{}"-}^2) = (2*) = double
  sq''  =  D sq'  = D double = c2 = const 2
\end{spec}

Note: we cannot \emph{implement} |D| of this type in Haskell.
%

Given only |f : REAL -> REAL| as a ``black box'' we
cannot compute the actual derivative |f' : REAL -> REAL|.

We need the ``source code'' of |f| to apply rules from calculus.




\section{Type inference and understanding}

\subsection{Case 3: Lagrangian}

  From \cite{sussman2013functional}:

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

\paragraph{Case 3: Lagrangian, summary}

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

\paragraph{DSLsofMath: Typing Mathematics}

  \begin{itemize}
  \item Mathematical concepts like |lim|, |D|, |Lagrangian| can be
    explored and explained using typed functional programming.
  \item Sometimes new insights arise: Stream calculus, for example.
  \item Aim: ``\ldots improve the mathematical education of computer
    scientists and the computer science education of mathematicians.''
  \item Focus on types \& specifications, syntax \& semantics
  \item DSL examples: Power series, Differential equations, Linear
    Algebra
  \end{itemize}

TODO[Solrun] add summary of the student results as well



\appendix

\section{DSLsofMath learning outcomes}

\begin{itemize}
\item Knowledge and understanding
  \begin{itemize}
  \item design and implement a DSL for a new domain
  \item organize areas of mathematics in DSL terms
  \item explain main concepts of analysis, algebra, and lin.\ alg.
  \end{itemize}
\item Skills and abilities
  \begin{itemize}
  \item develop adequate notation for mathematical concepts
  \item perform calculational proofs
  \item use power series for solving differential equations
  \item use Laplace transforms for solving differential equations
  \end{itemize}
\item Judgement and approach
  \begin{itemize}
  \item discuss and compare different software implementations of
        mathematical concepts
  \end{itemize}
\end{itemize}

\url{https://github.com/DSLsofMath/DSLsofMath/blob/master/Course2018.md}


\section{BSc project ``Learn you a Physics''}
\label{app:LearnYouAPhysics}

The online learning material \href{https://dslsofmath.github.io/BScProj2018/}{``Learn you a Physics''} (by E. Sjöström, O. Lundström, J. Johansson, B. Werner) is the result of a BSc project at Chalmers (supervised by P. Jansson) where the goal is to create an introductory learning material for physics aimed at programmers with a basic understanding of Haskell.
%
It does this by identifying key areas in physics with a well defined scope, for example dimensional analysis or single particle mechanics, and develops a domain specific language around each of these areas.
%
The implementation of these DSL's are the meat of the learning material with accompanying text to explain every step and how it relates to the physics of that specific area.
%
The text is written in such a way as to be as non-frightening as possible, and to only require a beginner knowledge in Haskell.
%
Inspiration is taken from \href{http://learnyouahaskell.com/}{Learn you a Haskell for Great Good} and the project \href{https://github.com/DSLsofMath/DSLsofMath}{DSLsofMath} at Chalmers and University of Gothenburg.
%
The \href{https://github.com/DSLsofMath/BScProj2018/tree/master/Physics}{source code} and \href{https://dslsofmath.github.io/BScProj2018/}{learning material} is freely available online.



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
