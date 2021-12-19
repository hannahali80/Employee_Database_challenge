-- Retrieve the emp no, first name, and last name columns from the Employees table.
SELECT emp_no, first_name, last_name 
FROM employees

-- Retrieve the title, from date, and to date columns from the Titles table
SELECT title, from_date, to_date
FROM titles 

-- Create new table for retiring employees
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no;

Select * From retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (from_date BETWEEN '1952-01-01' AND '1999-01-01')
ORDER BY emp_no, title DESC;


Select * From unique_titles


-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(ut.emp_no),
ut.title
INTO retiring_titles
FROM unique_titles as UT 
GROUP BY title 
ORDER BY COUNT(title) DESC;

Select * From retiring_titles


-- Mentorship Eligibility table that holds the employees who are eligible to participate
SELECT DISTINCT ON(e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
	   e.birth_date,
	   t.from_date,
	   t.to_date,
       t.title
INTO mentorship_eligibility
FROM employees AS e
left outer join dept_emp as de
ON (e.emp_no = de.emp_no)
left outer join titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
ORDER BY emp_no;

Select * From mentorship_eligibility
