-- WordPkg.Palindrome is created to have a function which returns a
-- boolean value determining whether a word is a palindrome under certain conditions

PACKAGE BODY WordPkg.Palindromes IS

-----------------------------------------------------------------------------------------------------------------------------------
-- Purpose: Takes a word as a parameter and returns a boolean value determining whether it is a palindrome under certain conditions
-- Parameters: w : word to be evaluated for its palindrome status
-- Postcondition: boolean value determining whether the word is palindrome will be returned 
-----------------------------------------------------------------------------------------------------------------------------------

    FUNCTION is_Pal(w: Word) RETURN Boolean IS

        frontIndex : NATURAL := 1;
        mirrorIndex : NATURAL := w.Length;
        isPal : BOOLEAN := TRUE;

    BEGIN

        WHILE frontIndex < MirrorIndex LOOP

            IF w.Letters(frontIndex) /= w.Letters(MirrorIndex) THEN

                isPal := FALSE;

                EXIT;

            END IF;

            frontIndex := frontIndex + 1;

            mirrorIndex := mirrorIndex - 1;

        END LOOP;

        RETURN isPal;

    END is_Pal;
end WordPkg.Palindromes;

