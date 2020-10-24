-- File: hw1.adb
-- Name: Richy Eduardo Castro 
-- Date: 08/26/2019

-- Purpose: Calculate points surplus or deficit
--          based on hours taken and GPA

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure hw1 is

   -- Personal data
   name: constant String := "Richy Eduardo Castro";      -- Student name

   hours_attempted: constant Natural := 18;   -- Hours taken
   current_gpa: constant Float := 3.5;        -- Current GPA
   desired_gpa: constant := 3.5;              -- GPA desired

   -- Calculated point requirements
   current_points: Float;            -- Points actually attained
   desired_points: Float;            -- Points needed to reach desired GPA

   -- Points calculations
   surplus, deficit: Float;          -- Points above or below Desired

begin
   -- Calculations
   current_points := Float(hours_attempted) * current_gpa;
   desired_points := desired_gpa * Float(hours_attempted);

   -- Calculate both even though one will not be needed
   surplus := current_points - desired_points;
   deficit := desired_points - current_points;

   -- Output
   put_line("Name: " & name);
   put_line("Hours:" & hours_attempted'img);

   put("Current GPA: ");
   put(item => current_gpa, fore => 1, aft => 2 , exp => 0);
   new_line;

   --  Not formatted
   put("Desired GPA: ");
   put(item => desired_gpa, fore => 1, aft => 2, exp => 0); 
   new_line;

   put("Current Points: ");
   put(item => current_points, fore => 1, aft => 2, exp => 0);
   new_line;
 
   put("Desired Points: ");
   put(item => desired_points, fore => 1, aft => 2, exp => 0);
   new_line;

   -- Surplus or deficit
   if current_points > desired_points then
      put("Point surplus: ");
      put(item => surplus, fore => 1, aft => 2, exp => 0);
  
   elsif current_points = desired_points then
      put("Desired Points achieved with no surplus");
  
   elsif current_points < desired_points then 
      put("Point Deficit: ");
      put(item => deficit, fore => 1, aft => 2, exp => 0);
   end if;

end hw1;
