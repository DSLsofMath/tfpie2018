%-*-Latex-*-
\documentclass{../eptcsstyle/eptcs}

% current annoyance: this will be fixed
% by the next update of agda.fmt
\def\textmu{}

\usepackage[fleqn]{amsmath}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8x]{inputenc}
\RequirePackage{ucs}
%include dslmagda.format
%include dslm.format
\usepackage{todonotes}

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
  Sólrún Halla Einarsdóttir
  \institute{Chalmers Univ. of Technology}
  \email{\quad slrn@@chalmers.se}
\and
  Cezar Ionescu
  \institute{Chalmers Univ. of Technology}%TODO: perhaps Oxford now?
  \email{cezar@@chalmers.se}
}

\def\titlerunning{Examples from DSLs of Mathematics}
\def\authorrunning{P. Jansson \& S. H. Einarsdóttir \& C. Ionescu}
\newcommand{\event}{7th International Workshop on Trends in Functional Programming in Education, TFPIE 2018}

\DeclareMathOperator{\Drop}{Drop}



%include dslm.format

\begin{document}

\maketitle

\begin{abstract}
  At the workshop on Trends in Functional Programming in Education (TFPIE) in
  2015 Ionescu and Jansson presented the approach underlying the ``Domain
  Specific Languages of Mathematics'' (DSLsofMath) course even before the first
  course instance.
  %
  We were then encouraged to come back to present our experience and the student
  results.
  %
  Now, three years later, we have seen three groups of learners attend the
  course, and the first two groups have also continued on to take challenging
  courses in the subsequent year.
  %
  In this paper we present three examples from the course material to set the
  scene, and we present an evaluation of the student results showing
  improvements in the pass rates and grades in later courses.
\end{abstract}

\paragraph{Keywords:} functional programming, computer science education,
calculus, didactics, formalisation, correctness, Haskell, types, syntax,
semantics, scope

\section{Introduction}

For the last few years we have been working on the border between
education and functional programming research under the common heading
of ``Domain Specific Languages of Mathematics''
(\href{https://github.com/DSLsofMath/}{DSLsofMath}).
%
This activity started from a desire to improve the mathematical
education of computer scientists and the computer science education of
mathematicians.
%
In 2014 Ionescu and Jansson applied for a pedagogical project grant to
develop a new BSc level course, and from 2016 on the course has been
offered to students at Chalmers and University of Gothenburg.
%

At the workshop on Trends in Functional Programming in Education
(TFPIE) in 2015 Ionescu and Jansson
\cite{DBLP:journals/corr/IonescuJ16} presented the approach underlying
the DSLsofMath course even before the first course instance.
%
We were then encouraged to come back to present our experience and the
student results.
%
Now, three years later, we have seen three groups of learners attend
the course, and the first two groups have also continued on to take
mathematically challenging compulsory courses in the subsequent year.
%*TODO: what is the best wording?: class / cohort / group / form ...
%\todo{more on current status (student counts, hints about results from LADOK)}

The course focus is on types and specifications and on the syntax and semantics
of domain specific languages used as tools for thinking.
%
In this paper we present three examples from the course material to
set the scene, and we present an evaluation of the student results.

The DSLsofMath activity has also lead to other developments not
covered in this paper: presentations at TFPIE 2015, the Workshop on
Domain Specific Languages Design and Implementation (DSLDI 2015), IFIP
Working Group 2.1 on Algorithmic Languages and Calculi meeting in 2015, and two
BSc thesis projects (one in 2016 about Transforms, Signals, and
Systems \cite{JonssonTSLwithDLS2016} and one in 2018 called ``Learn
You a Physics'' --- see appendix \ref{app:LearnYouAPhysics}).

% WG2.1: 2015 http://www.cse.chalmers.se/~patrikj/talks/WG2.1_Goteborg_Jansson_Ionescu_DSLsofMath.pdf

\section{Static checking: Scope and Types in Mathematics}

The DSLsofMath lecture notes \cite{JanssonIonescuDSLsofMathCourse}
have evolved from raw text notes for the first instance to 152 pages
of PDF generated from literate Haskell + LaTeX sources for the third
instance.
%
To give the reader a feeling for the course contents, we will show two
smaller and, in the next section, one larger examples from the lecture notes.
%
The two smaller examples are limits and derivatives.

% In several places the book contains an indented quote of a definition
% or paragraph from a mathematical textbook, followed by detailed
% analysis of that quote.
% %
% The aim is to improve the reader's skills in understanding, modelling,
% and implementing mathematical text.

In many of the chapters we start from a textbook definition and ``tease it
apart'' to identify parameters, types, and to help the students
understand exactly what it means.
%
When we first presented the course
\cite{DBLP:journals/corr/IonescuJ16}, we stressed the importance of
syntax and semantics, types and specifications.
%
As the material developed we noticed that variable binding (and scope)
is also an important (and in mathematical texts often implicit)
ingredient.
%
In our first example here, limits, we show the students that an
innocent-looking ``if A then B'' can actually implicitly bind one of
the names occurring in A.

\subsection{Case 1: Scoping Mathematics: The limit of a function}
\label{sec:LimitOfFunction}

This case is from Chapter two of the DSLsofMath lecture notes which
talks about the definition of the limit of a function of type |REAL ->
REAL| from \cite{adams2010calculus}:

\begin{quote}
  We say that \(f(x)\) \textbf{approaches the limit} \(L\) as \(x\)
  \textbf{approaches} \(a\), and we write
%
  \[\lim_{x\to a} f(x) = L,\]
%
  if the following condition is satisfied:\\
  for every number \(\epsilon > 0\) there exists a number
  \(\delta > 0\), possibly depending on \(\epsilon\), such that if
  |0 < absBar (x - a) < delta|, then \(x\) belongs to the domain of \(f\)
  and
  \begin{spec}
    absBar (f(x) - L) < epsilon {-"."-}
  \end{spec}

\end{quote}

\noindent
The |lim| notation has four components: a variable name |x|, a point
|a| an expression \(f(x)\) and the limit |L|.
%
The variable name and the expression can be combined into just the
function |f| and this leaves us with three essential components: |a|, |f|,
and |L|.
%
Thus, |lim| can be seen as a ternary (3-argument) predicate which is
satisfied if the limit of |f| exists at |a| and equals |L|.
%
If we apply our logic toolbox we can define |lim| starting something like this:
%
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (P epsilon delta))
\end{spec}
%
It is often useful to introduce a local name (like |P| here) to help
break the definition down into more manageable parts.
%
If we now naively translate the last part we get this ``definition''
for |P|:
%
\begin{spec}
{-"\quad"-}  where  P epsilon delta = (0 < absBar (x - a) < delta) => (x `elem` Dom f  && absBar (f x - L) < epsilon))
\end{spec}
%
Note that there is a scoping problem: we have |f|, |a|, and |L| from
the ``call'' to |lim| and we have |epsilon| and |delta| from the two
quantifiers, but where did |x| come from?
%
It turns out that the formulation ``if \ldots then \ldots'' hides a
quantifier that binds |x|.
%
Thus we get this definition:
%
\begin{spec}
lim a f L  =  Forall (epsilon > 0) (Exists (delta > 0) (Forall x (P epsilon delta x)))
  where  P epsilon delta x = (0 < absBar (x - a) < delta) => (x `elem` Dom f  && absBar (f x - L) < epsilon))
\end{spec}
%
The predicate |lim| can be shown to be a partial function of two
arguments, |f| and |a|.
%
This means that each function |f| can have \emph{at most} one limit
|L| at a point |a|.
%
(This is not evident from the definition and proving it is a good
exercise.)

%format Dom f = "\mathcal{D}" f

\subsection{Case 2: Typing Mathematics: derivative of a function}

The lecture notes include some other material in between this example and the
previous one, but here we
jump directly to dissecting one of the classical definitions of the
derivative (from \cite{adams2010calculus}).
%
We now assume limits exist and use |lim| as a function from |a| and |f| to |L|.
%

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
%
We can start by assigning types to the expressions in the definition.
%
Let's write |X| for the domain of |f| so that we have |f : X -> REAL|
and |X included REAL| (or, equivalently, |X : PS REAL|).
%
If we denote with |Y| the subset of |X| for which |f| is
differentiable we get |f' : Y -> REAL|.
%
Thus, the operation which maps |f| to |f'| has type \linebreak |(X->REAL) ->
(Y->REAL)|.
%
Unfortunately, the only notation for this operation given (implicitly)
in the definition is a postfix prime.
%
To make it easier to see we we use a prefix |D| instead and we can
thus write |D : (X->REAL) -> (Y->REAL)|.
%
We will often assume that |X = Y| so that we can can see |D| as
preserving the type of its argument.

Now, with the type of |D| sorted out, we can turn to the actual
definition of the function |D f|.
%
The definition is given for a fixed (but arbitrary) |x|.
%**DONE: removed this back reference now when they are in direct sequence
% (At this point it is useful to briefly look back to the definition of
% ``limit of a function'' in Section~\ref{sec:LimitOfFunction}.)
%
The |lim| expression is using the (anonymous) function |g h = frac
(f(x+h) - f x) h| and that the limit of |g| is taken at |0|.
%
Note that |g| is defined in the scope of |x| and that its definition
uses |x| so it can be seen as having |x| as an implicit, first
argument.
%
To be more explicit we write |phi x h = frac (f(x+h) - f x) h| and take
the limit of |phi x| at 0.
%
So, to sum up, |D f x = lim 0 (phi x)|.
%
We could go one step further by noting that |f| is in the scope of |phi| and used in its definition.
%
Thus the function |psi f x h = phi x h|, or |psi f = phi|, is used.
%
With this notation we obtain a point-free definition that can come in
handy:
%
|D f = lim 0 . psi f|.
%
To sum up, here are the steps again, now with typed helpers:

\begin{spec}
  D f x  = lim 0 g        where            g  h = frac (f(x+h) - f x) h; {-"\quad"-}  g    :                             REAL -> REAL
  D f x  = lim 0 (phi x)  where       phi  x  h = frac (f(x+h) - f x) h;              phi  :                    REAL ->  REAL -> REAL
  D f    = lim 0 . psi f  where  psi  f    x  h = frac (f(x+h) - f x) h;              psi  : (REAL -> REAL) ->  REAL ->  REAL -> REAL
\end{spec}


The key here is that we name, type, and specify the operation of
computing the derivative (of a one-argument function).
%
This operation is used quite a bit in the rest of the lecture notes,
but here are just a few examples to get used to the notation.

\begin{spec}
  D : (REAL->REAL) -> (REAL->REAL)

  sq x      =  x^2
  double x  =  2*x
  c2 x      =  2
  sq'   =  D sq   = D (\x -> x^2) = D ({-"{}"-}^2) = (2*) = double
  sq''  =  D sq'  = D double = c2 = const 2
\end{spec}

What we cannot do at this stage is to actually \emph{implement} |D| in
Haskell.
%
If we only have a function |f : REAL -> REAL| as a ``black box'' we
cannot really compute the actual derivative |f' : REAL -> REAL|, only
numerical approximations.
%
But if we also have access to the ``source code'' of |f|, then we can
apply the usual rules we have learnt in calculus.

\section{Type inference and understanding: Lagrangian case study}
\label{sec:Lagrangian}

Our third case study from the lecture notes is the analysis of
Lagrangian equations, also studied in Sussman and Wisdom 2013
\cite{sussman2013functional} in their prologue on ``Programming and
Understanding''.

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

\noindent
To start answering the question, we start typing the elements involved:

\begin{enumerate}
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
The ``system state'' here is a triple (of type |S = (T, Q, V) = ℝ³|)
and we can call the the three components |t : T| for time, |q : Q| for
coordinate, and |v : V| for velocity.
%
(We use |T = Q = V = ℝ| in this example but it can help the reading to
remember the different uses of |ℝ|.)

\item Looking again at the same derivative, \(∂L / ∂q\) suggests that
  \(q\) is the name of a real variable, one of the three arguments to
  \(L\).
%
  In the context, which we do not have, we would expect to find
  somewhere the definition of the Lagrangian as
  %
  \begin{spec}
    L  :  (T, Q, V)  ->  ℝ
    L     (t, q, v)  =   ...
  \end{spec}

\item therefore, \(∂L / ∂q\) should also be a function of the same
  triple of arguments:

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

\item Looking back at the description above, we see that the only
  immediate candidate for an application of \(d/dt\) is ``a path that
  gives the coordinates for each moment of time''.
%
  Thus, the path is a function of time, let us say
%
  \begin{spec}
    w  :  T → Q  -- with |T = ℝ| for time and |Q = ℝ| for coordinates (|q : Q|)
  \end{spec}

  We can now guess that the use of the plural form ``equations'' might
  have something to do with the use of ``coordinates''.
%
  In an |n|-dimensional space, a position is given by |n|
  coordinates.
%
  A path would then be a function
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

\item With |expand| in our toolbox we can fix the typing problem in
  item \ref{item:L:contra} above.
  %
  The Lagrangian is a ``function of the system state (time,
  coordinates, and velocities)'' and the ``expanded path'' (|expand
  w|) computes the state from just the time.
  %
  By composing them we get a function
  %
  \begin{spec}
    L . (expand w)  :  T -> ℝ
  \end{spec}
  %
  which describes how the Lagrangian would vary over time if the
  system would evolve according to the path |w|.

  This particular composition is not used in the equation, but we do
  have
  %
  \begin{spec}
    (∂L / ∂q) . (expand w)  :  T -> ℝ
  \end{spec}
  %
  which is used inside |d / dt|.

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
  %
  where both sides are functions of type |T → ℝ|.

\item ``A path is allowed if and only if it satisfies the Lagrange
  equations'' means that this equation is a predicate on paths (for a
  particular |L|):
  %
  \begin{spec}
    Lagrange(L, w) =  {-"\qquad"-} D (D₃ L ∘ expand w) == D₂ L ∘ expand w
  \end{spec}
  %
  where we use |(==)| to avoid confusion with the equality sign (|=|)
  used for the definition of the predicate.
\end{enumerate}

So, we have figured out what the equation ``means'', in terms of
operators we recognise.
%
If we zoom out slightly we see that the quoted text means something
like:
%
If we can describe the mechanical system in terms of ``a Lagrangian''
(|L : S -> ℝ|), then we can use the equation to check if a particular
candidate path |w : T → ℝ| qualifies as a ``motion of the system'' or
not.
%
The unknown of the equation is the path |w|, and as the equation
involves partial derivatives it is an example of a partial
differential equation (a PDE).
%



\section{Evaluation and results}

% Describe how the ``measurements'' were done and interpret the results.

We considered student results for students from the CSE programme at Chalmers%
\footnote{Computer Science and Engineering (CSE) is a five-year BSc+MSc
  programme at Chalmers. It is called ``Datateknik (D)'' in Swedish.}
who started their studies in 2014 and 2015. In the spring of their second year at
Chalmers (2016 and 2017), these students had the option of either taking the
DSLsofMath course or a course on Parallel computer organization and design.

We considered only ``active'' students, that is, students who had signed up for
at least half of the compulsory courses in the CSE programme during the semesters
being considered (Fall 2014 - Fall 2017). This amounted to 145 students, where
53 signed up for the DSLsofMath course (whereas 92 did not) and 34 of those 53
passed the course.

We had access to data on these students' results in all compulsory courses in
the programme as well as the more common elective courses (21 courses in all).
%
At Chalmers students pass a course with a grade of 3, 4, or 5, with 5 being the
highest grade, or fail the course with no specified grade. Students have many
opportunities to retake exams from courses they took in past semesters, to
attempt to obtain a passing score or improve their grade in the course.


\subsection{Student results before and after DSLsofMath}

Our hope was that taking our course would help prepare the students
for the math-intensive compulsory courses in the subsequent year which
many students struggle with,
%
Transforms, signals and systems (TSS%
\footnote{In Swedish:
  \href{https://student.portal.chalmers.se/en/chalmersstudies/courseinformation/Pages/SearchCourse.aspx?course_id=28314&parsergrp=3}{SSY080
    Transformer, signaler och system}})
%
and Control theory (Control%
\footnote{In Swedish:
  \href{https://student.portal.chalmers.se/en/chalmersstudies/courseinformation/Pages/SearchCourse.aspx?course_id=24149&parsergrp=3}{ERE103
    Reglerteknik}})

In the following table we see the pass rate and the mean grade (of those who
passed) for the above mentioned courses, where PASS represents the students who
took the DSLsofMath course and passed it, IN is the group of students who took
DSLsofMath (whether or not they passed), and OUT is the students who did not
sign up for DSLsofMath.

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
  \caption{Pass rate and mean grade in third year courses for students who took and
  passed DSLsofMath and those who did not.}
\end{table}

As we can see, the students who took DSLsofMath had higher mean grades in the
third-year courses and were more likely to pass, in particular those who managed
to pass the DSLsofMath course. The correlation between taking, and especially
passing, DSLsofMath and success in the third year courses is clear. But perhaps
the students who chose to take our course did so because they enjoyed
mathematics, and were already more likely to succeed in the subsequent
math-heavy courses regardless of whether they took our course.

%\subsubsection{Characterising students who chose DSLsofMath}
%We were curious to see how we could characterize the students who sign up for
%our course, for instance whether they were likely to be students who had done
%well in mathematics in the past who were interested in studying more maths,
%or perhaps students who had struggled with mathematics in the past and were
%therefore looking for more support and new methods for studying maths.

We looked at the students' results from their first three semesters at Chalmers,
prior to having the option of taking DSLsofMath. We were particularly interested
in students' performance in the compulsory mathematics and physics courses
\footnote{For details see appendix \ref{app:coursecodes}.}.
%
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
  \caption{Pass rate and mean grade for courses taken prior to taking (or not
    taking) DSLsofMath.}
\end{table}

Here we can see that there seems to be a small positive bias: those
students who choose the DSLsofMath course (the IN group) were a bit
more successful in the first three semesters than those in the OUT
group.
%
And (not surprisingly) those who pass the course fare even better, on
average.
%
Given that many other factors also vary it is not easy to prove that
taking DSLsofMath is a significant factor in improving future results,
but it does seem likely.


\subsection{Students' course assessment and resulting changes}

Each course instance has been evaluated with a standard questionnaire sent to
all participants as part of the university wide course evaluation process.
%
The evaluation of the first instance, with Cezar Ionescu as lecturer, identified
a need to restructure the initial four-lecture sequence, to re-order a few
lectures and to replace the two guest lectures by Linear Algebra.
%

In preparation for the second instance, with Patrik Jansson as lecturer, the
initial lecture sequence was changed to include more Haskell introduction and
less formal logic, and two new lectures on Linear Algebra were developed.
%
In the evaluation of the second (2017) instance, the students requested more
lecture notes and more weekly exercises to make it easier to get started.
%
The evaluation also indicated that the average student had spent too few hours
on the course, and the exam results suffered (42\% failed, up from 32\% in 2016).

At this point we decided to push for course material development and one of the
student evaluators from 2017 (Daniel Heurlin) was hired part time to help out
with these improvements.
%
Patrik spent the autumn of 2017 on converting raw text notes and photos of
blackboards to LaTeX-based literate Haskell lecture notes covering the full
course and Daniel developed more exercises to solve.
%
The primary focus was on complementing the exam questions from earlier years
with easier exercises to start each week with and with more material on
functional programming in Haskell.

The recent evaluation of the 2018 instance was overall positive and the course
saw a strong improvement in the pass rate: only 11\% failed.
%
The student evaluators suggested to ``increase the pressure'' on solving the
exercises, to make the students better prepared for the hand-in assignments and
the written exam.

\section{Related work}

Others have worked on using functional programming to help teach mathematics, in
particular algebra, to younger (primary and secondary school) students.
%
The Bootstrap project has
successfully developed a functional programming-based curriculum that has
improved students' performance in solving algebra
problems~\cite{Schanzer:2018:ABA:3159450.3159498,Schanzer:2015:TSS:2676723.2677238}.
In \cite{EPTCS270.2}, d'Alves et al.\ describe using functional programming in
Elm to introduce algebraic thinking to students.

In \cite{DBLP:journals/corr/Walck16} and \cite{DBLP:journals/corr/Walck14},
Walck describes using Haskell programming to deepen university students'
understanding of physics, and in \cite{EPTCS106.3} Ragde describes using
functional programming to introduce university students to more precise
mathematical notation.
We are not aware of previous literature on the use of functional programming to
present mathematical analysis as we have done.

\section{Conclusions and future work}

During the last four years we have developed course material and worked with
150+ computer science students to improve their mathematical education through
the course ``Domain Specific Languages of Mathematics''.
%
We have shown how mathematical concepts like |lim|, |D|, |Lagrangian| can be
explored and explained using typed functional programming.
% TODO perhaps include for the full paper Sometimes new insights arise: Stream calculus, for example.
%
(Much more about that can be read in the lecture notes
\cite{JanssonIonescuDSLsofMathCourse}.)
%
We have investigated the group of students who picked DSLsofMath as an elective
and we have measured positive results on later courses with mathematical content.
%\todo[inline]{TODO[Solrun] perhaps add more ``meat'' about the student results}

There are several avenues for future work: upstream and downstream curriculum
changes, better tool support, and empirical evaluation.
%
\begin{itemize}
\item Upstream, we would really like to work with the teachers of the
  mathematics courses in the first year to see if some of the ideas from
  DSLsofMath could be included already at that stage.
  %
  Ideally, in the long term, the DSLsofMath course material should be
  ``absorbed'' by these earlier courses.
\item Downstream, it would be interesting to see how the new course could affect
  the way the ``Transforms, signals and systems'' and ``Automatic control''
  courses are taught.
  %
  It seems that we may also affect the Physics course -- see the BSc project
  ``Learn You a Physics'' summary in appendix \ref{app:LearnYouAPhysics}.
\item When it comes to tool support it would be interesting to see how systems
  like Liquid Haskell, Agda, etc.\ could help the students learn.
  %
  We have been cautious so far, taking it one step at a time, to avoid stressing
  the student by yet another language / system / tool to learn.
\item Finally, we are well aware that our evaluation of the effect of the course
  on the students' learning is lacking the rigour of a proper empirical study.
  %
  It would be interesting to work with experts on teaching and learning in
  higher education on such a study.


\end{itemize}





\subsection*{Acknowledgements}

The support from Chalmers Quality Funding 2015 (Dnr C 2014-1712, based
on Swedish Higher Education Authority evaluation results) is
gratefully acknowledged.
%
Thanks also to R. Johansson (as Head of Programme in CSE) and P.
Ljunglöf (as Vice Head of the CSE Department for BSc and MSc
education) who provided continued financial support when the national
political winds changed.
%
Thanks to D. Heurlin who provided many helpful comments during his
work as a student research assistant in 2017.

This work was partially supported by the projects GRACeFUL (grant
agreement No 640954) and CoeGSS (grant agreement No 676547), which
have received funding from the European Union’s Horizon 2020 research
and innovation programme.


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


\section{BSc project ``Learn You a Physics''}
\label{app:LearnYouAPhysics}

The online learning material
\href{https://dslsofmath.github.io/BScProj2018/}{``Learn You a Physics''} (by E.
Sjöström, O. Lundström, J. Johansson, B. Werner) is the result of a BSc project
at Chalmers (supervised by P. Jansson) where the goal is to create an
introductory learning material for physics aimed at programmers with a basic
understanding of Haskell.
%
It does this by identifying key areas in physics with a well defined scope, for
example dimensional analysis or single particle mechanics, and develops a domain
specific language around each of these areas.
%
The implementation of these DSLs are the meat of the learning material with
accompanying text to explain every step and how it relates to the physics of
that specific area.
%
The text is written in such a way as to be as non-frightening as possible, and
to only require a beginner knowledge in Haskell.
%
Inspiration is taken from \href{http://learnyouahaskell.com/}{Learn You a
  Haskell for Great Good} and the project
\href{https://github.com/DSLsofMath/DSLsofMath}{DSLsofMath} at Chalmers and
University of Gothenburg.
%
The \href{https://github.com/DSLsofMath/BScProj2018/tree/master/Physics}{source
  code} and \href{https://dslsofmath.github.io/BScProj2018/}{learning material}
is freely available online.

\section{Course codes}
\label{app:coursecodes}

The courses used to calculate the first 3 semesters pass rate and mean
grade were:

\begin{tabular}{ll}
    TDA555 & Introduktion till funktionell programmering
\\  TMV210 & Inledande diskret matematik
\\  EDA452 & Grundläggande datorteknik
\\  TMV216 & Linjär algebra
\\  DAT043 & Objektorienterad programmering
\\  TMV170 & Matematisk analys
\\  EDA343 & Datakommunikation
\\  EDA481 & Maskinorienterad programmering
\\  DAT290 & Datatekniskt projekt
\\  MVE055 & Matematisk statistik och diskret matematik
\\  DAT037 & Datastrukturer
\\  TIF085 & Fysik för ingenjörer.
\end{tabular}

Of these, the ones used to calculate the Math/physics pass rate and
mean grade were TMV210, TMV216, TMV170, MVE055 and TIF085.




\bibliographystyle{../eptcsstyle/eptcs}
\bibliography{dslm}
\end{document}
