-- Name: Richy Eduardo Castro
-- Date:
-- Course: ITEC 320 Procedural Analysis and Design

-- This program is written to satisfy the requirements given for Project 2
-- This program will read a file containing ISBN numbers and possibly
-- other data. This program will interpret a 10 digit number by applying
-- a sum check formula provided by Dr. Okie and provide results stating which
-- numbers passed the sum check and which did not.

WITH Ada.Text_IO; Use Ada.Text_IO;
WITH Ada.Integer_Text_IO; Use Ada.Integer_Text_IO;
WITH Ada.Characters.Handling; Use Ada.Characters.Handling;

PROCEDURE isbn_check IS

  TYPE isbn_array IS ARRAY(1 .. 1000, 1 .. 11) OF INTEGER;
----------------------------------------------------------
-- Purpose: initialize_array reads in a string value and processes it accordingly by
-- inserting integer values into the array this_array(1)(1 .. 10)
-- and identifying any non - valid strings along with their respective errors
-- Parameters: this_array is an array of isbn_array type
-- Precondition: array is declared
-- Postcondition: array will have integer values inserted
----------------------------------------------------------
  PROCEDURE initialize_array(this_array : OUT isbn_array; count : OUT INTEGER) IS

    array1_index : INTEGER := 1;   -- initialized to begin 2D array traversal in the correct index

    array2_index : INTEGER := 1;   -- initialized to begin 2D array traversal in the correct index

    qmark_found : BOOLEAN := FALSE;   -- boolean variable will keep track of too many question marks

  BEGIN

    count := 0;   --initialize count

    File_Loop:
    WHILE (not End_of_File) LOOP   -- loops through the whole file

      getstring: DECLARE --new block
      current_line : String := get_line;   -- gets string from file

      BEGIN

      count := count + 1;   -- number of strings are increased by one per reading

      String_Loop:
      FOR i IN current_line'RANGE LOOP   -- for each character in the string

        IF( array2_index > 10 ) THEN   -- if the string is too long

          put_line("ERROR in Line " &  Integer'Image(count) & ". String too long : <" & current_line & ">");   -- print error message

          this_array(array1_index, 11) := -1;   -- insert reference value of negative one in the check sum place to identify the invalid string later in the program

          new_line;   -- space the output

          exit;   -- exit the loop for this line of string

        ELSIF (is_digit(current_line(i))) THEN   -- if the character is a digit then

          this_array(array1_index, array2_index) := abs(Integer'Value((1 => current_line(i))));     -- insert integer into the array

          array2_index := array2_index + 1;     -- array2_index is increased to prepare for the next insertion

        ELSIF (current_line(i) = Character'Val(63) AND qmark_found) THEN    -- if the a question mark is found and a question mark has already been found

          put_line("ERROR in Line " &  Integer'Image(count) & ". Too many question marks: <" & current_line & ">");    -- print an error message

          this_array(array1_index, 11) := -1;     -- insert a reference value into the check_sum spot to identify the invalid string later in the program

          new_line;   -- space the output

          exit;    --- exit the loop for this line of string

        ELSIF (current_line(i) = Character'Val(63)) THEN    -- if the character is the first question mark

          this_array(array1_index, array2_index) := -1;   -- insert a -1 into the array to change later in the validate procedure

          array2_index := array2_index + 1;     -- array2_index is increased to prepare for the next insertion

          qmark_found := TRUE;     -- question mark is found

        ELSIF ((current_line(i) = Character'Val(88))) THEN    -- if the character is 'x' or 'X'

          this_array(array1_index, array2_index) := 10;   -- insert 10 into the array

          array2_index := array2_index + 1;   -- array2_index is increased to prepare for the next insertion

        ELSIF ((current_line(i) /= Character'Val(45))) THEN   -- if character is not a '-'

          put_line("ERROR in Line " &  Integer'Image(count) & ". Invalid character in string : <" & current_line & ">");   -- print an error message

          this_array(array1_index, 11) := -1;   -- insert a reference value into the check_sum spot to identify the invalid string later in the program

          new_line;  -- space the output

          exit;  --exit loop

        END IF;      -- end big "IF" statement

      END LOOP String_Loop;  -- end loop through string

      array1_index := array1_index + 1;  -- increase index of 2D array for the insertion of the next line of integers

      array2_index := 1;  -- reset one dimension of the 2D array to loop through the next input string

      qmark_found := false;

      END getstring;  -- end get string block

    END LOOP File_Loop;    -- end loop through the file

  END initialize_array;

  ----------------------------------------------------------
  -- Purpose: Validate procedure will calculate the check sum
  -- and insert reference values into this_array(i, 11)
  -- Parameters: this_array , count
  -- Precondition: this_array is initialized and the number
  -- of strings have been count
  -- Postcondition: check sums are calculated and reference
  -- values are inserted
  ----------------------------------------------------------

  PROCEDURE Validate(this_array : IN OUT isbn_array; count : IN INTEGER) IS

  test_value1 : INTEGER := 0;   -- variable is used to determine the best fit value in place of a question mark. Variable may not be used

  test_value2 : INTEGER := 0;  -- variable is used to determine the best fit value in place of a question mark. Variable may not be used

  check_sum: INTEGER := 0;    -- variable is used for the value of the check_sum

  index_to_fix : INTEGER := 0;    -- variable is used to reference the index where a question mark was placed

  find_value : BOOLEAN := FALSE;    -- variable is used to determine whether a question mark value needs calculation

  BEGIN

    FOR i IN 1 .. count LOOP   -- for each isbn number   -- For each isbn number

      IF (this_array(i, 11) /= -1) THEN   -- The value of this array spot being -1 means that it is invalid and ignore it

        FOR j IN 1 .. 10 LOOP    -- for each number in the isbn number

          IF this_array(i,j) = -1 THEN    -- If a value is -1 , then it must be changed for the aggregate check sum to be 0

            find_value := TRUE;    -- boolean variable will determine whether finding the check sum value is necessary

            index_to_fix := Integer(j);   -- index to fix is stored in this variable

            this_array(i, j) := 0;    -- set the value of the index to fix to zero

            check_sum := check_sum + (Integer(j) * this_array(i,j));  -- check sum will be calculated using 0 value

          ELSE

            check_sum := check_sum + (Integer(j) * this_array(i,j));   -- check sum will be calculated using array space value

          END IF;

        END LOOP;

          IF find_value = True AND (check_sum)mod 11 > 0 THEN     -- if find_value variable is true and check_sum modded by 11 is greater than zero than

            WHILE((check_sum + test_value2)mod 11 > 0 AND test_value1 < 11) LOOP    --  While the check sum modded by 11 is greater than zero but less than 11

              test_value1 := test_value1 + 1;    -- increase the test_value1 by 1

              test_value2 := test_value1 * index_to_fix;    -- multiply test_value1 with test_value2. If this value is added to the check sum, the check sum can be tested by modding it with eleven

            END LOOP;

            this_array(i, index_to_fix) := test_value1;    -- set the index to fix to the calculated value of test_value1

            check_sum := check_sum + test_value2;    -- add the new test_value2 (test_value1 * index_to_fix)

          END IF;

        this_array(i, 11) := Integer((check_sum)mod 11);    -- insert the check sum value into its designated array spot

      END IF;    -- end if : if -1 value represents invalid value

      check_sum := 0;   -- reset the check sum to zero in preparation for the next check_sum calculation

      find_value := FALSE;   -- reset find_value in preparation for the next check_sum calculation

      index_to_fix := 0;

      test_value1 := 0;

      test_value2 := 0;

    END LOOP;

  END Validate;

  ----------------------------------------------------------
  -- Purpose: Print results will format the output of the array values procedure
  -- Parameters: this_array , count
  -- Precondition: this_array is initialized and validated. The number
  -- of strings have been count
  -- Postcondition: output depicting the invalid and valid check sums
  ----------------------------------------------------------

  PROCEDURE print_results(this_array : IN isbn_array; count : IN INTEGER) IS

  BEGIN

  put_line("Valid Check Sums: ");    --  print the line "value check sums: "

  FOR i IN 1 .. count LOOP    -- for each isbn number in the array

    IF (this_array(i, 11) = 0) THEN    -- if the check sum spot is 11 then

      FOR j IN 1 .. 11 LOOP      -- loop through the isbn number

        IF j < 11 THEN

        put(Item => this_array(i, j), Width => 1, Base => 10);   -- print the number

        ELSE

        put(Item => this_array(i, j), Width => 3, Base => 10);     -- if its the check sum, print it slightly spaced
        END IF;


      END LOOP;

      new_line;

    END IF;

  END LOOP;

  new_line;

  put_line("Invalid Check Sums: ");    -- print "Invalid check sums"

  FOR i IN 1 .. count LOOP

  IF (this_array(i, 11) > 0) THEN    -- if the check sum is greater than 0

    FOR j IN 1 .. 11 LOOP    -- loop through the whole isbn number

      IF j < 11 THEN

      put(Item => this_array(i, j), Width => 1, Base => 10);  -- print the isbn number

      ELSE

      put(Item => this_array(i, j), Width => 3, Base => 10);     -- print the check sum slightly separate

      END IF;

    END LOOP;

    new_line;

   END IF;

  END LOOP;

  END print_results;

  isbn_numbers : isbn_array;

  isbn_count : INTEGER;

BEGIN

  initialize_array(isbn_numbers, isbn_count);

  Validate(isbn_numbers, isbn_count);

  print_results(isbn_numbers, isbn_count);

END isbn_check;

