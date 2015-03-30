var a = [1, 2, 3, 4, 5];
console.log(a);

delete a[1];
console.log(a);
console.log(a.length);
console.log(a[1]);
console.log(a['1']);		// a.1 and a.'1' are syntax error

delete a[3];
console.log(a);
console.log(a.length);
console.log(a['2']);
