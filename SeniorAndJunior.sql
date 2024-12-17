WITH CTE AS(
  SELECT 
    experience,
    employee_id,
    sum(salary) over (partition by experience order by salary, employee_id) as sal_sum
    from candidates
)

select
    'Senior' as experience, 
    Count(*) as accepted_candidates from CTE
    where sal_sum <= 70000 and experience = 'Senior'
UNION

select
    'Junior' as experience, 
    Count(*) as accepted_candidates from CTE
    where experience = 'Junior' and sal_sum <= (
        select 70000 - IFNULL(MAX(sal_sum),0)
        from CTE
        where experience = 'Senior' and sal_sum <=70000
    )