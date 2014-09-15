declare
fun {Pow N M}
   if M==0 then 1
   else N * {Pow N M-1}
   end
end

{Show {Pow 2 3}}
{Show {Pow 2 64}}

%{Show {Pow -2 3}}
%*************************** type error *************************
%**
%** ill-typed builtin application
%**
%** Builtin:         Number.'-'
%** At argument:     1
%** Expected types:  number x number x number
%** Argument names:  {Number.'-' Pow _ _}
%** Argument values: {Number.'-' <P/3 Pow> 2 _<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/PowerOfN.oz", line 11, column 11
%** ------------------ rejected (1 error)

%{Show {Pow (-2) 3}}
%*************************** parse error ************************
%**
%** syntax error, unexpected T_ADD
%**
%** in file "c:/Users/Ryan/code/courses/pl/PowerOfN.oz", line 24, column 12
%** ------------------ rejected (1 error)
