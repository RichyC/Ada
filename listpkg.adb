with Ada.Text_IO;         use Ada.Text_IO;
package body listpkg is
   procedure init(l: in out List) is
   begin
      l := null;   -- warning creates garbage
   end init;
   --  would be nice to have a delete list

   PROCEDURE makeList(first, last: Natural; l: In out List) IS
   BEGIN
      l := null;
      FOR i in reverse first .. last LOOP
         l := new Node'(i, l);
      END LOOP;
    END makeList;

   PROCEDURE putList(l: List) IS
      t : List := l;
   BEGIN
      WHILE t /= null LOOP
          put(t.val'img);
          t := t.next;
      END LOOP;
   END putList;

   -- compare entire list, not just pointers l and r
   FUNCTION equal(l, r: List) RETURN BOOLEAN IS
      equality : BOOLEAN := TRUE;
      q : List := l;
      z : List := r;
   BEGIN
      WHILE q /= null AND z /= null LOOP
          IF q.val /= z.val THEN
              equality := FALSE;
              EXIT;
          END IF;
          q := q.next;
          z := z.next;
      END LOOP;
      RETURN equality AND z = q;
   END equal;

   procedure copy(dest: out List; source: In List) is
   begin
      dest := source;  -- warning: shallow copy
   end copy;
   a, b: List;
end listpkg;

