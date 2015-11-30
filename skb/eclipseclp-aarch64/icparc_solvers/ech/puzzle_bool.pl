% BEGIN LICENSE BLOCK
% Version: CMPL 1.1
%
% The contents of this file are subject to the Cisco-style Mozilla Public
% License Version 1.1 (the "License"); you may not use this file except
% in compliance with the License.  You may obtain a copy of the License
% at www.eclipse-clp.org/license.
% 
% Software distributed under the License is distributed on an "AS IS"
% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.  See
% the License for the specific language governing rights and limitations
% under the License. 
% 
% The Original Code is  The ECLiPSe Constraint Logic Programming System. 
% The Initial Developer of the Original Code is  Cisco Systems, Inc. 
% Portions created by the Initial Developer are
% Copyright (C) 2006 Cisco Systems, Inc.  All Rights Reserved.
% 
% Contributor(s): 
% 
% END LICENSE BLOCK

/*
Article: 5653 of comp.lang.prolog
Newsgroups: comp.lang.prolog
Path: ecrc!Germany.EU.net!mcsun!ub4b!news.cs.kuleuven.ac.be!bimbart
From: bimbart@cs.kuleuven.ac.be (Bart Demoen)
Subject: boolean constraint solvers
Message-ID: <1992Oct19.093131.11399@cs.kuleuven.ac.be>
Sender: news@cs.kuleuven.ac.be
Nntp-Posting-Host: hera.cs.kuleuven.ac.be
Organization: Dept. Computerwetenschappen K.U.Leuven
Date: Mon, 19 Oct 1992 09:31:31 GMT
Lines: 120

	?- calc_constr(N,C,L) . % with N instantiated to a positive integer

generates in the variable C a datastructure that can be interpreted as a
boolean expression (and in fact is so by SICStus Prolog's bool:sat) and in L
the list of variables involved in this boolean expression; so

	?- calc_constr(N,C,L) , bool:sat(C) , bool:labeling(L) .
			% with N instantiated to a positive integer

shows the instantiations of L for which the boolean expression is true
e.g.

	| ?- calc_constr(3,C,L) , bool:sat(C) , bool:labeling(L) .
	% C = omitted
	L = [1,0,1,0,1,0,1,0,1] ? ;

	no

it is related to a puzzle which I can describe if people are interested

SICStus Prolog can solve this puzzle up to N = 9  on my machine; it then
fails because of lack of memory (my machine has relatively little: for N=9
SICStus needs 14 Mb - and about 50 secs runtime + 20 secs for gc on Sparc 1)

I am interested in hearing about boolean constraint solvers that can deal with
the expression generated by the program below, for large N and in reasonable
time and space; say N in the range 10 to 20: the number of solutions for
different N varies wildly; there is exactly one solution for N = 10,12,13,15,20
but for N=18 or 19 there are several thousand, so perhaps it is best to
restrict attention to N with only one solution - unless that is unfair to your
solver

in case you have to adapt the expression for your own boolean solver, in
the expression generated, ~ means negation, + means disjunction,
* means conjunction and somewhere in the program, 1 means true


Thanks

Bart Demoen
*/

:- [bool]. % load in boolean ECH handler

% test(N,L) :- calc_constr(N,C,L) , bool:sat(C) , bool:labeling(L) .
test(N,L) :-   calc_constr(N,C,L) , solve_bool(C,1).
testbl(N,L) :- calc_constr(N,C,L) , solve_bool(C,1), labeling.
testul(N,L) :- calc_constr(N,C,L) , solve_bool(C,1), label_bool(L).

calc_constr(N,C,L) :-
		M is N * N ,
		functor(B,b,M) ,
		B =.. [_|L] ,
		cc(N,N,N,B,C,1) .

cc(0,M,N,B,C,T) :- ! ,
		NewM is M - 1 ,
		cc(N,NewM,N,B,C,T) .
cc(_,0,_,B,C,C) :- ! .
cc(I,J,N,B,C,T) :-
		neighbours(I,J,N,B,C,S) ,
		NewI is I - 1 ,
		cc(NewI,J,N,B,S,T) .


neighbours(I,J,N,B,C,S) :-
		add(I,J,N,B,L,R1) ,
		add(I-1,J,N,B,R1,R2) ,
		add(I+1,J,N,B,R2,R3) ,
		add(I,J-1,N,B,R3,R4) ,
		add(I,J+1,N,B,R4,[]) ,	% L is the list of neighbours of (I,J)
					% including (I,J)
		odd(L,C,S) .

add(I,J,N,B,S,S) :- I =:= 0 , ! .
add(I,J,N,B,S,S) :- J =:= 0 , ! .
add(I,J,N,B,S,S) :- I > N , ! .
add(I,J,N,B,S,S) :- J > N , ! .
add(I,J,N,B,[X|S],S) :- A is (I-1) * N + J , arg(A,B,X) .


% odd/2 generates the constraint that an odd number of elements of its first
% argument must be 1, the rest must be 0

odd(L,C*S,S):- exors(L,C).

  exors([X],X).
  exors([X|L],X#R):- L=[_|_],
	exors(L,R).


/*
% did this by enumeration, because there are only 4 possibilities

odd([A],	A * S,S) :- ! .

odd([A,B,C],	((A * ~~(B) * ~~(C)) + 
		(A * B * C) + 
		( ~~(A) * B * ~~(C)) + 
		( ~~(A) * ~~(B) * C))  * S,S)
		:- ! .

odd([A,B,C,D],	((A * ~~(B) * ~~(C) * ~~(D)) +
		(A * B * C * ~~(D)) +
		(A * B * ~~(C) * D) +
		(A * ~~(B) * C * D) +
		( ~~(A) * B * ~~(C) * ~~(D)) +
		( ~~(A) * B * C * D) +
		( ~~(A) * ~~(B) * C * ~~(D)) +
		( ~~(A) * ~~(B) * ~~(C) * D))  * S,S )
		:- ! .

odd([A,B,C,D,E],((A * ~~(B) * ~~(C) * ~~(D) * ~~(E)) +
		(A * B * C * ~~(D) * ~~(E)) +
		(A * B * ~~(C) * D * ~~(E)) +
		(A * ~~(B) * C * D * ~~(E)) +
		(A * B * ~~(C) * ~~(D) * E) +
		(A * ~~(B) * C * ~~(D) * E) +
		(A * ~~(B) * ~~(C) * D * E) +
		(A * B * C * D * E) +
		( ~~(A) * B * ~~(C) * ~~(D) * ~~(E)) +
		( ~~(A) * B * ~~(C) * D * E) +
		( ~~(A) * B * C * ~~(D) * E) +
		( ~~(A) * B * C * D * ~~(E)) +
		( ~~(A) * ~~(B) * C * ~~(D) * ~~(E)) +
		( ~~(A) * ~~(B) * C * D * E) +
		( ~~(A) * ~~(B) * ~~(C) * D * ~~(E)) +
		( ~~(A) * ~~(B) * ~~(C) * ~~(D) * E))  * S,S ) :- ! .

*/








