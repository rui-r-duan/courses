% declarative concurrency

declare X Y
fun lazy {F1 X}
   X+5
end
fun lazy {F2 Y}
   Y*2
end
B = {F1 X}
C = {F2 Y}
thread A = B + C end
{Browse A}
thread X = 1 Y = 10 end
{Browse 5}

declare
fun lazy {Fact N}
   if N=<0 then
      1
   else
      N*{Fact N-1}
   end
end
local X Y in
   X={Fact 100}
   Y=X+1			% the value of X is needed and fact is computed
   {Browse [X Y]}
end

declare
fun {Ints N Max}
   if N<Max then
      {Delay 1000}
      N | {Ints N+1 Max}
   else nil end
end
fun {Sum A Xs}
   case Xs of X|Xr then
      A | {Sum A+X Xr}
   [] nil then nil end
end

% "Batch": sequential computation
declare Xs Ys in
{Browse Xs}
{Browse Ys}
Xs={Ints 1 10}
Ys={Sum 0 Xs}

% "Incremental": concurrent computation
declare Xs Ys in
{Browse Xs}
{Browse Ys}
thread Xs={Ints 1 10} end
thread Ys={Sum 0 Xs} end

% Incremental (lazy), not concurrent
declare
fun lazy {LazyInts N Max}
   if N<Max then
      {Delay 1000}
      N | {LazyInts N+1 Max}
   else nil end
end
fun lazy {LazySum A Xs}
   case Xs of X|Xr then
      A | {LazySum A+X Xr}
   [] nil then nil end
end
% Lazy: no calculation until requested
declare Xs Ys in
{Browse Xs}
{Browse Ys}
Xs={LazyInts 1 10}
Ys={LazySum 0 Xs}
% Request a result triggers calculation
{Browse Ys.2.1}
{Browse Ys.2.2.2.1}

% Lazy Pascal Triangle (refer to chap1.oz)

% Combining Laziness and Threading
declare
fun {Buffer Xs N}
   End=thread {List.drop Xs N} end
   fun lazy {Loop Xs End}
      case Xs of X|Xr then
	 X|{Loop Xr thread End.2 end}
      end
   end
in
   {Loop Xs End}
end
fun lazy {LazyInts N Max}
   if N<Max then
      {Delay 1000}
      N|{LazyInts N+1 Max}
   else nil end
end
% Buffer requests three elements
declare
{Browse Xs}
{Browse Ys}
Xs={LazyInts 1 10}
Ys={Buffer Xs 3}
% Request second element
{Browse Ys.2.1}

declare
R=[1 3 5 7]
{Browse {List.drop R 3}}

% Fibo without Threading
declare
fun {Fibo N}
   if N=<2 then 1
   else {Fibo N-1} + {Fibo N-2}
   end
end
for I in 1..20 do {Browse {Fibo I}}
end

% Multithreading Fibo
declare
fun {Fib X}
   case X
   of 1 then 1
   [] 2 then 1
   else thread {Fib X-1} end + thread {Fib X-2} end
   end
end
{Browse {Fib 6}}
{Browse {Fib 25}}

% Avoid creating exponential threading
declare
fun {Fib X}
   if X==0 then 0
   elseif X==1 then 1
   else {Delay 100}
      thread {Fib X-1} end + {Fib X-2}
   end
end
{Browse {Fib 25}}

% Concurrent map function
declare
fun {CMap Xs F}
   case Xs
   of nil then nil
   [] X|Xr then
      thread {F X} end | {CMap Xr F}
   end
end
declare F X Y Z
{Browse thread {CMap X F} end}
X=1|2|Y
fun {F X} X*X end
Y=3|Z
Z=nil

% Dataflow variables example
local
   X
in
   {Browse hello}
   thread {Browse X+3} end
   {Delay 3000}
   X=4
end

% Synchronization using Dataflow variables
declare X0 X1 X2 X3
{Browse [X0 X1 X2 X3]}
thread
   Y0 Y1 Y2 Y3
in
   {Browse [Y0 Y1 Y2 Y3]}
   thread Y0=X0+1 end
   thread Y1=X1+Y0 end
   thread Y2=X2+Y1 end
   thread Y3=X3+Y2 end
   {Wait Y3}
   {Browse completed}
end
X0=10
X1=10
X2=10
X3=10

declare X
{Browse X}
local Y in
   thread {Delay 1000} Y=10*10 end
   X=Y+100*100
end

% use {Browse endOfProgram} to test if there is any blocking
local X in
   {Browse hello}
   %% !! blocks
   {Browse X+3}
   X=4
end
{Browse endOfProgram}

% use Debug to test if there is any blocking
declare [Debug] = {Module.link ['x-oz://boot/Debug']}
local X in
   {Debug.setRaiseOnBlock {Thread.this} true}
   %% !! blocks
   {Browse X+3}
   X=4
end

% interleaving
local X in
   thread {Browse X} end
   thread X=3 end
end

% Example of Casual Order
local A B in
   thread {Browse A} end
   thread {Browse B} end
   thread {Delay 5000} A=3 end
   thread B=A+2 end
end

% thread without dataflow variables = no synchronization (i.e., no incremental computation
declare
proc {GeneKelly}
   thread {Dance} end
   thread {Sing} end
end
proc {Dance}
   {Browse im_dancing}
   {Browse im_dancing}
end
proc {Sing}
   {Browse and_singing}
   {Browse in_the_rain}
end
{GeneKelly}

% Advantage 3: developing Stream Agents
declare
fun {Double X|Xr}
   2*X | thread {Double Xr} end
end

declare A B C D E in
{Browse starting}
{Browse {Double 1|A}}
{Browse next}
A=10|B
B=5|3|C
C=7|13|D

% Port
declare P S in
{NewPort S P}
{Browse S}
thread {Send P 1} end
thread {Send P 2} end
