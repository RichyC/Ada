-- Name: Richy Eduardo Castro
-- Date: November 9, 2019
-- Course: ITEC 320 Procedural Analysis and Design


-- Purpose: This program takes a text file through standard input and
-- returns the words and their status as palindromes in different states
-- which include the following:
-- 1. Palindrome as is
-- 2. Palindrome when non-letters are removed
-- 3. Palindrome when all letters are capitalized
-- 4. Palindrome when all letters are capitalized and non-letters are removed
-- Sample input:
-- b hi madamimadam
-- corresponding output:
-- String: b
-- status: palindrome as is
--
-- String: hi
-- Status: never a palindrome
--
-- String: madamimadam
-- Status: palindrome as is

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH WordPkg;
WITH WordPkg.Utilities;
WITH WordPkg.Palindromes;

PROCEDURE more_pals IS

    PACKAGE wordFun IS NEW WordPkg (maximum_word_size => 60);
    USE wordFun;

    PACKAGE wordFunMore IS NEW wordFun.Utilities;
    USE wordFunMore;

    PACKAGE wordFunPalindromes IS NEW wordFun.Palindromes;
    USE wordFunPalindromes;

    palindrome_as_is, pal_when_nonletters_removed, pal_when_capitalized, pal_when_capitalized_and_lettersonly : BOOLEAN;

    word_to_evaluate : Word;

BEGIN

    WHILE not End_Of_File LOOP

        Get(word_to_evaluate);

        palindrome_as_is := is_Pal(word_to_evaluate);

        pal_when_nonletters_removed := is_Pal(remove_NonLetter(word_to_evaluate));

        pal_when_capitalized := is_Pal(to_Upper(word_to_evaluate));

        pal_when_capitalized_and_lettersonly := is_Pal(to_Upper(remove_NonLetter(word_to_evaluate)));

        IF palindrome_as_is THEN

            put("String: ");
            put(word_to_evaluate);

            new_line;

            put_line("Status: Palindrome as is");

            new_line;

        ELSIF pal_when_nonletters_removed THEN

            put("String: ");
            put(word_to_evaluate);

            new_line;

            put_line("Status: Palindrome when non-letters are removed");

            put("PalStr: ");
            put(remove_NonLetter(word_to_evaluate));

            new_line(2);

        ELSIF pal_when_capitalized THEN

            put("String: ");
            put(word_to_evaluate);

            new_line;

            put_line("Status: Palindrome when converted to upper case");

            put("PalStr: ");
            put(to_Upper(word_to_evaluate));

            new_line(2);

        ELSIF pal_when_capitalized_and_lettersonly THEN

            put("String: ");
            put(word_to_evaluate);

            new_line;

            put_line("Status: Palindrome when converted to upper case and non-letters are removed");

            put("PalStr: ");
            put(to_Upper(remove_NonLetter(word_to_evaluate)));

            new_line(2);

        ELSE

            put("String: ");
            put(word_to_evaluate);

            new_line;

            put_line("Status: Never a palindrome");

            new_line;

        END IF;

    END LOOP;

END more_pals;

