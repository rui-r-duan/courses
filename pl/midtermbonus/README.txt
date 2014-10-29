It works but slow due to lots of redundant computation in the recursion.

A possible solution is to make use of MEMOIZATION which caches the previously
computed terms.  But memoized table requires mutable list.

If we don't have any mutable table, we can probably implement memoization
powered by lazy stream that contains the terms of the triangle sequentially.

Rui Duan
Oct 28, 2014
