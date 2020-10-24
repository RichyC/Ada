-- File: fix_errors.adb
-- Name: Richy Eduardo Castro 
-- Date: 09/04/2019

-- This program is supposed to print the following:
--    n,
--    the sum of the values from 1 to n
--    the average of those values
--
-- The program contains about 17 compilation errors.  Fix those errors.
-- After fixing the syntax errors, compare it's output with the sample run,
--   and fix any additional errors.
-- You should correct the errors in order as the compiler identifies them.
--
-- Sample run:
--          10
--          55
--
-- 5.5

with ada.text_io; use ada.text_io; 
with ada.integer_text_io; use ada.integer_text_io; 
with ada.float_text_io; use ada.float_text_io; 
 
procedure fix_errors is 
   sum:Integer;
   avg:Float;
   n:Integer:= 10;
begin
   sum := 0;
   for i in 1 .. n loop
      sum := sum + Integer(i);
   end loop;

   avg := Float(sum) / Float(n);

   new_line;
   put(n);

   new_line;
   put(sum);

   new_line;

   put(item => avg, fore => 1, aft => 1, exp => 0);
   new_line;
end fix_errors;
