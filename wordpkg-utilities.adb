-- This Ada package specification adds palindrome checking,
-- removal of non-letters, and transforming to upper and lower case
-- to the word package.
-- All procedures/functions have been tested and passed acceptance testing

WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Characters.Handling; USE Ada.Characters.Handling;

-----------------------------------------------------------------------
-- Purpose: Returns a word type that has all of its letters capitalized
-- Parameters: w : word type to be capitalized
-- Postcondition: w will be returned with all letters capitalized
-----------------------------------------------------------------------

PACKAGE BODY WordPkg.Utilities IS

    FUNCTION to_Upper(w: Word) RETURN Word IS

        word_to_return : Word;

    BEGIN

        word_to_return := w;

        word_to_return.Letters := Ada.Characters.Handling.To_Upper(w.Letters);

        RETURN word_to_return;

    END to_Upper;

---------------------------------------------------------------------------------------
-- Purpose: Returns a word that has any non letter characters removed
-- Parameters: w : word type to be changed
-- Precondition: w must have non letter characters
-- Postcondition: function returns a word with all non letter characters will be removed
----------------------------------------------------------------------------------------


    FUNCTION remove_NonLetter(w: Word) RETURN Word IS

        word_to_return : Word;

        new_string : String(1 .. MaxWordSize);

        word_to_return_index : INTEGER := 1;

    BEGIN

        FOR i in 1 .. w.Length LOOP

            IF(Is_Letter(w.Letters(i))) THEN

                new_string(word_to_return_index) := w.Letters(i);

                word_to_return_index := word_to_return_index + 1;

            END IF;

        END LOOP;

        word_to_return := New_Word(new_string);

        word_to_return.Length := word_to_return_index - 1;

        RETURN word_to_return;

    END remove_NonLetter;

----------------------------------------------------------------------------------------
-- Purpose: take a word as a parameter and returns the word with all letters capitalized
-- Parameters: w : word which will be capitalized
-- Precondition: word must not be fully capitalized
-- Postcondition: word will be fully capitalized
----------------------------------------------------------------------------------------

    PROCEDURE to_Upper(w: in out Word) IS

    BEGIN

        w.Letters := Ada.Characters.Handling.To_Upper(w.Letters);

    END to_Upper;

---------------------------------------------------------------------------------------------
-- Purpose: take a word as a parameter and returns the word with any non letter character erased
-- Parameters: w : word which will be edited
-- Precondition: word must have non letter character
-- Postcondition: word will be only letter characters
---------------------------------------------------------------------------------------------

    PROCEDURE remove_Nonletter(w: in out Word) IS

        new_string : String(1 .. MaxWordSize);

        new_string_index : INTEGER := 1;

    BEGIN

        FOR i in 1 .. w.Length LOOP

            IF(Is_Letter(w.Letters(i))) THEN

                new_string(new_string_index) := w.Letters(i);

                new_string_index := new_string_index + 1;

            END IF;

        END LOOP;

        w := New_Word(new_string);

        w.Length := new_string_index - 1;

    END remove_Nonletter;

end WordPkg.Utilities;

