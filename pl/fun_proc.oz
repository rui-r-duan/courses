declare
fun {Foo X Y}
   % X = X + 1			% runtime failure:
%********************** static analysis error *******************
%**
%** illegal arity in application
%**
%** Arity found:          4
%** Expected:             3
%** Application (names):  {Bar _ _ XX _}
%** Application (values): {<P/3 Bar> 3 4 XX<optimized> _<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/fun_proc.oz", line 17, column 11
%** ------------------ rejected (1 error)   
   X + Y
end

declare
proc {Bar X Y Z}
   Z = X + Y
end

{Browse {Foo 3 4}}
local XX in
   {Bar 3 4 XX}
   {Browse XX}
%   {Browse {Bar 3 4 XX}}
%********************** static analysis error *******************
%**
%** illegal arity in application
%**
%** Arity found:          4
%** Expected:             3
%** Application (names):  {Bar _ _ XX _}
%** Application (values): {<P/3 Bar> 3 4 XX<optimized> _<optimized>}
%** in file "c:/Users/Ryan/code/courses/pl/fun_proc.oz", line 17, column 11
%** ------------------ rejected (1 error)
end

declare
fun {Boo X}
   X + 5
end