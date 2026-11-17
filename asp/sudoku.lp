% Wenzel Uhlmann - uhlmann@uni-potsdam.de - 809724
%


% Hints:
% - For subgrid_size(s), subgrids can be identified by labels 0..s*s-1
% - A cell (x,y) can be mapped to the subgrid labeled (((x-1)/s)*s + (y-1)/s)

% set-up parameters 
size(81).
subgrid_size(3).
row(1..9).
col(1..9).
num(1..9).

% Generator 

% Every initial must be in the answer set.
sudoku(I, J, N) :- initial(I,J,N).

% For every non initial position, there is exacly ONE sudoku predicate, with one of the allowed numbers.
1 { sudoku(I, J, N) : num(N) } 1 :- row(I), col(J), not initial(I, J, _).

% Tester 

% Two sudoku predicates in the same col, must not have the same number, unless its the same predicate. 
:- sudoku(I, J, N), sudoku(I', J, N), I != I'.

% Same for rows. 
:- sudoku(I, J, N), sudoku(I, J', N), J != J'.

% Grid - Each cell must be labeled accordingly to the scheme. 
label(I, J, (((I-1)/S)*S + (J-1)/S)) :- row(I), col(J), subgrid_size(S).

% No sudoku predicate can have the same number as another predicate, if there corresponding labels map them to the 
% same subgrid, except if the predicate is compared to it self. 
% To achieve that, we compare all 9 predicates of a number, while we enforce that either row or col is different.
%:- sudoku(I, J, N), sudoku(I', J', N), label(I, J, L), label(I', J', L), (I, J) != (I', J').
:- sudoku(I, J, N), sudoku(I', J', N), label(I, J, L), label(I', J', L), I!=I'.
:- sudoku(I, J, N), sudoku(I', J', N), label(I, J, L), label(I', J', L), J!=J'.

#show sudoku/3.
