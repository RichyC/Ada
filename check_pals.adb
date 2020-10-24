-- Name: Richy Eduardo Castro
-- Date:
-- Course: ITEC 320 Procedural Analysis and Design

-- Purpose: This program will read a text file from standard input and provide an output
-- which will place each line 60 characters or less into a category of one of the following
-- three :
-- 1. Palindrome
-- 2. Palindrome Capitalized
-- 3. Not a Palindrome
-- DID NOT FINISH THIS ASSIGNMENT!!!!!!!

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
WITH Ada.Characters.Handling; USE Ada.Characters.Handling;
WITH Ada.Containers.Generic_Array_Sort;
WITH Ada.Containers.Generic_Constrained_Array_Sort;

PROCEDURE check_pals IS

  TYPE program_arrays IS ARRAY(1 .. 100, 1 .. 60) OF CHARACTER;

  TYPE word_sizes IS ARRAY(1 .. 100) OF INTEGER;

  TYPE arrays IS RECORD

    storage_array : program_arrays;

    reverse_storage : program_arrays;

    palindromes : program_arrays;

    cap_palindromes : program_arrays;

    non_palindromes : program_arrays;

    sizes : word_sizes;

    word_count : INTEGER := 0;

    pals_sizes : word_sizes;

    non_pals_sizes : word_sizes;

    cap_pals_sizes : word_sizes;

    pals_count : INTEGER := 0;

    non_pals_count : INTEGER := 0;

    cap_pals_count : INTEGER := 0;

  END RECORD;

  ----------------------------------------------------------
  -- Purpose: initialize_array reads in a string value and processes it accordingly by
  -- inserting character values into an array of program_array type
  -- and identifying any non - valid characters to ignore
  -- Parameters: arrays_record is an record of arrays type
  -- Precondition: arrays_record is declared
  -- Postcondition: arrays_record.storage_array and
  -- arrays_record.reverse_storage will have character values inserted
  ----------------------------------------------------------

  PROCEDURE initialize_array (arrays_record : IN OUT arrays) IS

    array_index1 : INTEGER := 1;

    array_index2 : INTEGER := 1;

    letter_count : INTEGER := 0;

    reverse_letter_count : INTEGER := 0;

  BEGIN

  File_Loop:
  WHILE (not End_of_File) LOOP   -- loops through the whole file

    getstring: DECLARE -- new block
    current_line : String := get_line;   -- gets string from file

    BEGIN

      String_Loop:
      FOR i IN current_line'RANGE LOOP

        IF ((current_line(i) >= 'A' AND current_line(i) <= 'Z') OR (current_line(i) >= 'a' AND current_line(i) <= 'z')) THEN

          arrays_record.storage_array(array_index1, array_index2) := current_line(i);

          letter_count := letter_count + 1;

          array_index2 := array_index2 + 1;

        ELSIF (current_line(i) = ' ') THEN

          arrays_record.storage_array(array_index1, array_index2) := '"';

          arrays_record.storage_array(array_index1, array_index2 + 1) := current_line(i);

          arrays_record.storage_array(array_index1, array_index2 + 2) := '"';

          letter_count := 3;

          exit;

        END IF;

      END LOOP String_Loop;

      array_index2 := 1;

      reverse_letter_count := letter_count;

      Reverse_String_Loop:
      FOR i IN 1 .. letter_count LOOP

        arrays_record.reverse_storage(array_index1, array_index2) := arrays_record.storage_array(array_index1, reverse_letter_count);

        array_index2 := array_index2 + 1;

        reverse_letter_count := reverse_letter_count - 1;

      END LOOP Reverse_String_Loop;

      arrays_record.sizes(array_index1) := letter_count;

      array_index1 := array_index1 + 1;

      array_index2 := 1;

      arrays_record.word_count := arrays_record.word_count + 1;

      letter_count := 0;

    END getstring;

    END LOOP File_Loop;

  END initialize_array;

  ----------------------------------------------------------
  -- Purpose: process_arrays procedure will determine any non-palindromes
  -- and insert them into the non_palindromes array of the record
  -- Parameters: data_record
  -- Precondition: data_record is initialized and characters
  -- have been inserted into the records
  -- Postcondition: check sums are calculated and reference
  -- values are inserted
  ----------------------------------------------------------

  PROCEDURE process_arrays (data_record : IN OUT arrays) IS

    non_pals_index : INTEGER := 0;

    pals_index : INTEGER := 0;

    cap_pals_index : INTEGER := 0;

    word_size : INTEGER;

  BEGIN

    FOR i IN 1 .. data_record.word_count LOOP

      word_size := data_record.sizes(i);

      FOR j IN 1 .. data_record.sizes(i) LOOP

        IF (data_record.storage_array(i, j) /=  data_record.reverse_storage(i, j)) THEN

          FOR q IN 1 .. data_record.sizes(i) LOOP

            data_record.non_palindromes(i, q) := data_record.storage_array(i, q);

          END LOOP;

          non_pals_index := non_pals_index + 1;

          data_record.non_pals_sizes(non_pals_index) := data_record.sizes(i);

          exit;

        END IF;

      END LOOP;

    END LOOP;

    data_record.non_pals_count := non_pals_index;

    data_record.pals_count := pals_index;

    data_record.cap_pals_count := cap_pals_index;

  END process_arrays;

  ----------------------------------------------------------
  -- Purpose: Print results will format the output of the array values procedure
  -- Parameters: data_record
  -- Precondition: data_record is initialized and validated. The number
  -- of strings have been count
  -- Postcondition: prints non_palindromes
  ----------------------------------------------------------

  PROCEDURE print_arrays (data_record : IN OUT arrays) IS

  BEGIN

    put_line("Here are the non_palindromes");

    new_line;

    FOR i IN 1 .. data_record.non_pals_count LOOP

      FOR j IN 1 .. data_record.non_pals_sizes(i) LOOP

        put(data_record.non_palindromes(i, j));

      END LOOP;

      new_line;

    END LOOP;

  END;

  program_data : arrays;

BEGIN

  initialize_array(program_data);

  process_arrays(program_data);

  print_arrays(program_data);

END check_pals;

