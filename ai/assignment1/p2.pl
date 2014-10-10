employee(mcardon,1,5).
employee(treeman,2,3).
employee(chapman,1,2).
employee(claessen,4,1).
employee(petersen,5,8).
employee(cohn,1,7).
employee(duffy,1,9).
department(1,board).
department(2,human_resources).
department(3,production).
department(4,technical_services).
department(5,administration).
salary(1,1000).
salary(2,1500).
salary(3,2000).
salary(4,2500).
salary(5,3000).
salary(6,3500).
salary(7,4000).
salary(8,4500).
salary(9,5000).

% (1) Design a Prolog query to select those employees who earn between $3,000
% and $4,500 per month;
% also select all employees who are in salary scale 1, and working in
% department 1.
earn_between(Employee) :-
	employee(Employee,_,Scale),
	salary(Scale,Salary),
	Salary >= 3000,
	Salary =< 4500,
	write(Employee),nl,
	fail.
select_employee(Employee) :-
	employee(Employee,DepartmentNum,Scale),
	Scale == 1,
	DepartmentNum == 1,
	write(Employee),nl,
	fail.

% (2)
project_name_scale(Name,Scale) :-
	employee(Name,_,Scale),
	format("~w ~w",[Name,Scale]),nl,
	fail.

% (3)
join_employee_department([]) :-
	employee(Name,DepNum,Scale),
	department(DepNum,DepName),
	format("~w ~w ~w ~w", [Name,DepNum,DepName,Scale]),nl,
	fail.
