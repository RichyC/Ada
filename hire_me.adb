-- File: hire_me.adb
-- Author: Richy Eduardo Castro

-- This program is created as an assignment for ITEC 320 at Radford University
-- I applied exception handling for data errors

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;

procedure hire_me is

  type Verbosity is (Verbose, Quiet);

  package Verbosity_IO is new Ada.Text_IO.Enumeration_IO(Verbosity);

  use Verbosity_IO;

  format:Verbosity;

  Dataset_Size:Integer;

  Rejected_Size:Float;

  Natural_Log:Float:= 2.7_1828_1828;

  Found_Better:Boolean;

  Found_Best:Boolean;

  Best_in_r:Integer;

  Best_Found:Integer;

  Current_Value:Integer;

  Best:Integer;

  Correct_Results:Integer:= 0;

  Incorrect_Results:Integer:= 0;

  Total_Datasets:Integer:= 0;

  Percent_Correct:Float;

  begin
  --Get statement will retrieve the verbosity type created in the declarations listing
  get(format);
  --Case statement is used to determine what the output of the program will depending on whether the verbosity type is
  --Verbose or Quiet
    Case format is
     when Verbose =>
     -- Put line is used for the columns of the verbose output
      put_line("   n     r   Best in r   Selected   Best Overall   Correct   Not Correct");
      Program_Loop_Verbose:
        while (not End_Of_File) loop
          get(Dataset_Size);
          Total_Datasets:= Total_Datasets + 1;
          Rejected_Size:= Float(Dataset_Size)/Natural_Log;
          get(Best_Found);
          Best_in_r:= Best_Found;
          Found_Best:= False;
          Found_Better:= False;
            Dataset_Loop_Verbose:
              for Iteration in 2 .. Dataset_Size loop
                get(Current_Value);
                  if Current_Value > Best_Found and Iteration <= Integer(Float'Floor(Rejected_Size)) then
                    Best_Found:= Current_Value;
                    Best_in_r:= Current_Value;
                  elsif Current_Value > Best_Found and not Found_Better then
                    Best_Found:= Current_Value;
                    Found_Better:= True;
                  elsif Current_Value > Best_Found and not Found_Best then
                    Best:= Current_Value;
                    Found_Best:= True;
                  elsif Current_Value > Best and Found_Best then
                    Best:= Current_Value;
                  end if;
                  if Iteration = Dataset_Size then
                    if not Found_Better then
                      Best:= Best_Found;
                      Best_Found:= Current_Value;
                    elsif Found_Better and not Found_Best then
                      Best:= Best_Found;
                    end if;
                    if Best = Best_Found then
                      Correct_Results:= Correct_Results + 1;
                    else
                      Incorrect_Results:= Incorrect_Results + 1;
                    end if;
                    put(Item => Dataset_Size, Width => 5, Base => 10);
                    put(Item => Integer(Float'Floor(Rejected_Size)), Width => 5, Base => 10);
                    put(Item => Best_in_r, Width => 8, Base => 10);
                    put(Item => Best_Found, Width => 12, Base => 10);
                    put(Item => Best, Width => 12, Base => 10);
                    put(Item => Correct_Results, Width => 13, Base => 10);
                    put(Item => Incorrect_Results, Width => 12, Base => 10);
                    new_line;
                  end if;
        end loop Dataset_Loop_Verbose;
      end loop Program_Loop_Verbose;
    when Quiet =>
      Program_Loop_Quiet:
        while (not End_Of_File) loop
          get(Dataset_Size);
          Total_Datasets:= Total_Datasets + 1;
          Rejected_Size:= Float(Dataset_Size)/Natural_Log;
          get(Best_Found);
          Best_in_r:= Best_Found;
          Found_Best:= False;
          Found_Better:= False;
            Dataset_Loop_Quiet:
              for Iteration in 2 .. Dataset_Size loop
                get(Current_Value);
                  if Current_Value > Best_Found and Iteration <= Integer(Float'Floor(Rejected_Size)) then
                    Best_Found:= Current_Value;
                    Best_in_r:= Current_Value;
                  elsif Current_Value > Best_Found and not Found_Better then
                    Best_Found:= Current_Value;
                    Found_Better:= True;
                  elsif Current_Value > Best_Found and not Found_Best then
                    Best:= Current_Value;
                    Found_Best:= True;
                  elsif Current_Value > Best and Found_Best then
                    Best:= Current_Value;
                  end if;
                  if Iteration = Dataset_Size then
                    if not Found_Better then
                      Best:= Best_Found;
                      Best_Found:= Current_Value;
                    elsif Found_Better and not Found_Best then
                      Best:= Best_Found;
                    end if;
                    if Best = Best_Found then
                      Correct_Results:= Correct_Results + 1;
                    else
                      Incorrect_Results:= Incorrect_Results + 1;
                    end if;
                  end if;
        end loop Dataset_Loop_Quiet;
      end loop Program_Loop_Quiet;
    end case;
  Percent_Correct:= (Float(Correct_Results) / Float(Total_Datasets)) * 100.0;
  new_line;
  new_line;
  put_line("   Correct   Not Correct   Total   Percent Correct");
  Put("     " & Integer'Image(Correct_Results) & "         " & Integer'Image(Incorrect_Results) & "          " & Integer'Image(Total_Datasets) & "          ");
  Put(item => Percent_Correct, fore => 3, aft => 1, exp => 0);
  exception
   when Data_Error =>
       new_line;
       put_line("Please make sure all input values are integers and verbosity type is correct");
  end hire_me;

