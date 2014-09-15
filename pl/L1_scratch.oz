{Show 'Hello World'}

%{Show "Hello World"}
%72|101|108|108|111|32|87|111|114|108|,,,|,,,

{Browse 9999*9999}

declare
V=9999*9999
{Browse V*V}

declare
fun {F X}
   3*X+1
end

{Browse F}
%{Browse {F}}
{Browse {F 2}}
{Browse {F 3}}

declare
fun {Fact N}
   if N==0 then 1
   else N*{Fact N-1}
   end
end

{Show {Fact 100}}

declare
fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R})
end

%{Show {Comb f10 3}}
%*************************** type error *************************
%**
%** Expected type: int or float
%**                uniformly for all arguments
%** In statement:  {-1 f10 1 _<optimized>}
%**
%** Call Stack:
%** procedure 'Fact' in file "Oz", line 18, column 0, PC = 32318652
%** procedure 'Comb' in file "Oz", line 28, column 0, PC = 5167176
%**--------------------------------------------------------------

{Show {Comb 10 3}}

declare
fun {Fibo N}
   case N of
      1 then 1
   [] 2 then 1
   [] M then {Fibo (M-1)} + {Fibo (M-2)}
   end
end

%{show {Fibo 100}}
%********************** static analysis error *******************
%**
%** applying non-procedure and non-object
%**
%** Value found: show
%** in file "Oz", line 46, column 0
%** ------------------ rejected (1 error)

{Browse {Fibo 100}}

{Show 3}

%3
%
%************************** syntax error ************************
%**
%** expression at statement position
%**
%** in file "c:/Users/Ryan/code/courses/pl/L1_scratch.oz", line 72, column 0
%** ------------------ rejected (1 error)

%{Show -2}
%
%*************************** type error *************************
%**
%** ill-typed builtin application
%**
%** Builtin:         Number.'-'
%** At argument:     1
%** Expected types:  number x number x number
%** Argument names:  {Number.'-' Show _ _}
%** Argument values: {Number.'-' <P/1 System.show> 2 _<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/L1_scratch.oz", line 80, column 6
%** ------------------ rejected (1 error)
