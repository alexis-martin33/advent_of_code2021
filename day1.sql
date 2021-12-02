create table aoc_2021.day1_input(
input integer
);

copy aoc_2021.day1_input 
from '/path_to_file/day1.csv'
delimiter ',' csv;

-- Solves part 1
with with_rownum as (
	select ROW_NUMBER() over (), input
	from aoc_2021.day1_input
)
select sum(case when depth_increased is true then 1 else 0 end) as solution 
from (
-- join the table onto itself using the row number and next row number. 
	select wr_1.input as first_depth, 
	wr_2.input as next_depth,
	wr_2.input > wr_1.input as depth_increased
	from with_rownum as wr_1
	left join with_rownum as wr_2 on wr_1.row_number = (wr_2.row_number -1)
) as sol
;

-- Solves part 2
with with_rownum as (
	select ROW_NUMBER() over () as the_row, input as the_depth
	from aoc_2021.day1_input
),
-- Use a window function to compute a rolling sum of the next 3 rows
sliding_window as (
select
	the_row,
	sum(the_depth) over (rows between current row and 2 following) as sliding_sums
from with_rownum)
--
select 
sum(case when depth_increased is true then 1 else 0 end) as solution
from (
	select 
	sw_1.sliding_sums as first_window,
	sw_2.sliding_sums as second_window,
	sw_2.sliding_sums > sw_1.sliding_sums as depth_increased 
	from sliding_window as sw_1
	left join sliding_window as sw_2 on sw_1.the_row = (sw_2.the_row -1)
) as sol





	
	
	
	
	
	