-- Name: Richy Eduardo Castro
-- Date: 12/5/2019
-- Course: ITEC 320 Procedural Analysis and Design

-- Purpose: This program simulates a contest where the name, age, and skill
-- level are provided and the winner is determined based on certain criteria
-- Input is a text file where each contestant gets two successive lines.
-- First line will provide the contestant's name and the next line will provide
-- the a skill level and age respectively.
-- Player with the larger skill level wins.
-- If skill levels are equivalent, player with more age wins.
-- If skill and age are equivalent, player with larger number of wins wins.
-- If skill, age, and wins are equivalent, player with least losses wins.
-- If skill, age, wins, and losses are equivalent, then the player who
-- arrived first wins.

WITH stacks;
WITH queues;
WITH Ada.Strings.Unbounded; USE Ada.Strings.Unbounded;
WITH Ada.Strings.Unbounded.Text_IO; USE Ada.Strings.Unbounded.Text_IO;
WITH Ada.Strings; USE Ada.Strings;
WITH Ada.Text_IO; USE Ada.Text_IO;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;

PROCEDURE compete IS

    SUBTYPE skill_level IS INTEGER RANGE 1 .. 999;
    SUBTYPE age IS INTEGER RANGE 3 .. 99;

    TYPE competitor IS RECORD   -- Type is created to hold Name, skill, age, arrival order, wins, and losses
        Name : Unbounded_String;
        skill : skill_level;
        player_age : age;
        arrival_number : INTEGER;
        wins : INTEGER := 0;
        losses : INTEGER := 0;
    END RECORD;

---------------------------------------------------------------
-- Purpose : print_competitor dictates and formats how the a competitor object
-- is printed via the print procedure
-- Parameters : this_competitor is a custom competitor type and
-- identifies which competitor object is to be printed
-- Precondition : competitor type is declared and instantiated
---------------------------------------------------------------

    PROCEDURE print_competitor(this_competitor : competitor) IS
    BEGIN
        put(Item => this_competitor.arrival_number, Width => 5, Base => 10);
        put("  ");
        put(Item => this_competitor.player_age, Width => 5, Base => 10);
        put(Item => this_competitor.skill, Width => 7, Base => 10);
        put(Item => this_competitor.wins, Width => 5, Base => 10);
        put(Item => this_competitor.losses, Width => 7, Base => 10);
        put("    ");
        put(this_competitor.Name);
    END print_competitor;

    PACKAGE competition_stack IS NEW stacks (ItemType => competitor, print => print_competitor);
    USE competition_stack;
    PACKAGE competition_queue IS NEW queues (ItemType => competitor, print => print_competitor);
    USE competition_queue;

-------------------------------------------------------------------------------
-- Purpose : return_winner will compare two competitor types and will return the
-- match winner based on criteria stated at the beginning of the document
-- Parameters : competitor1 and competitor2 are the two competitors that will
-- compete against each other
-- Precondition : competitor1 and competitor2 must be instantiated
-- Postcondition : function will return the winner
-------------------------------------------------------------------------------

    FUNCTION return_winner(competitor1, competitor2 : IN competitor) RETURN competitor IS

    BEGIN

        IF competitor1.skill > competitor2.skill THEN   -- compare skill level first

            RETURN competitor1;

        ELSIF competitor2.skill > competitor1.skill THEN

            RETURN competitor2;

        ELSIF competitor1.player_age > competitor2.player_age THEN    -- if skill level is equivalent, compare age

            RETURN competitor1;

        ELSIF competitor2.player_age > competitor1.player_age THEN

            RETURN competitor2;

        ELSIF competitor1.wins > competitor2.wins THEN     -- if ages are equivalent, compare wins

            RETURN competitor1;

        ELSIF competitor2.wins > competitor1.wins THEN

            RETURN competitor2;

        ELSIF competitor1.losses < competitor2.losses THEN   -- if wins are equivalent, compare losses

            RETURN competitor1;

        ELSIF competitor2.losses < competitor1.losses THEN

            RETURN competitor2;

        ELSIF competitor1.arrival_number > competitor2.arrival_number THEN   -- losses are equivalent, compare arrival order

            RETURN competitor1;

        ELSE

            RETURN competitor2;

        END IF;

    END return_winner;
---------------------------------------------------------------------------
-- Purpose : get_competitors initializes the zero-loss queue
-- Parameters : this_queue is a queue data structure and identifies the queue
-- the queue to be instantiated.
-- Precondition : Queue type must be created and instantiated with standard
-- input in the correct formatting
-- Postcondition : queue will contain all identifiable competitor objects
-- within standard input
---------------------------------------------------------------------------


    PROCEDURE get_competitors(this_queue : IN OUT Queue; player_count : IN OUT NATURAL) IS
        this_string : Unbounded_String;  -- this unbounded string will hold the name
        this_skill : skill_level;     -- skill
        player_age : age;
    BEGIN
        WHILE not End_Of_File LOOP         -- go through the whole text file
                player_count := player_count + 1;   -- player count will increase per competitor
                this_string := get_line;      -- get_line will get the name of competitor
                this_string := Trim(this_string, Both);      -- trim the string so it's down to its most economic size
                get(this_skill);        -- get the skill next
                get(player_age);        -- get the age next
                enqueue((this_string, this_skill, player_age, player_count, 0, 0), this_queue);  -- add competitor to queue
                IF not End_Of_File THEN
                    skip_line;
                END IF;
        END LOOP;
    END get_competitors;

------------------------------------------------------------------------------
-- Purpose : start_competition will initiate and complete the competition per
-- Dr. Okie's instructions. start_competition will also print the results.
-- Parameters : round1q will be the zero loss queue, round2q is the one-loss queues,
-- and the done_stack is the stack used for the competitors with two Losses
-- Precondition : queues and stacks must be instantiated.
-- Postcondition : stack will have each competitor in their corresponding order
------------------------------------------------------------------------------

    PROCEDURE start_competition(round1q : IN OUT Queue; round2q : IN OUT Queue; done_stack : IN OUT Stack) IS

        competitor1 : competitor;
        competitor2 : competitor;

    BEGIN

        WHILE size(round1q) > 1 LOOP          -- round 1 elimination
            competitor1 := front(round1q);
            dequeue(round1q);
            competitor2 := front(round1q);
            dequeue(round1q);
            IF return_winner(competitor1, competitor2) = competitor1 THEN  -- Depending on who the winner is
                competitor1.wins := competitor1.wins + 1;               -- one gets a win tallied
                competitor2.losses := competitor2.losses + 1;           -- one gets a loss tallied
                enqueue(competitor1, round1q);
                enqueue(competitor2, round2q);
            ELSE
                competitor2.wins := competitor2.wins + 1;
                competitor1.losses := competitor1.losses + 1;
                enqueue(competitor2, round1q);
                enqueue(competitor1, round2q);
            END IF;
        END LOOP;

        WHILE size(round2q) > 1 LOOP          -- round 2 elimination
            competitor1 := front(round2q);
            dequeue(round2q);
            competitor2 := front(round2q);
            dequeue(round2q);
            IF return_winner(competitor1, competitor2) = competitor1 THEN

                competitor1.wins := competitor1.wins + 1;
                competitor2.losses := competitor2.losses + 1;
                enqueue(competitor1, round2q);
                push(competitor2, done_stack);

            ELSE

                competitor2.wins := competitor2.wins + 1;
                competitor1.losses := competitor1.losses + 1;
                enqueue(competitor2, round2q);
                push(competitor1, done_stack);

            END IF;

        END LOOP;

        competitor1 := front(round1q);
        competitor2 := front(round2q);

        WHILE (competitor1.losses < 2 AND competitor2.losses <2) LOOP

            IF return_winner(competitor1, competitor2) = competitor1 THEN
                competitor1.wins := competitor1.wins + 1;
                competitor2.losses := competitor2.losses + 1;
            ELSE
                competitor2.wins := competitor2.wins + 1;
                competitor1.losses := competitor1.losses + 1;
            END IF;

        END LOOP;

        IF competitor1.losses = 2 THEN

            push(competitor1, done_stack);
            push(competitor2, done_stack);

        ELSE

            push(competitor2, done_stack);
            push(competitor1, done_stack);

        END IF;

        print(done_stack);

    END start_competition;

    round1_queue : Queue;
    round2_queue : Queue;
    all_done_stack : Stack;

    competitor_count : NATURAL := 0;

BEGIN

    get_competitors(round1_queue, competitor_count);

    put_line("  Number  Age  Skill  Wins Losses  Name");

    start_competition(round1_queue, round2_queue, all_done_stack);

END compete;

