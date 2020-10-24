with Ada.Text_IO;         use Ada.Text_IO;
with listpkg;
use listpkg;
procedure demo is
   a, b: List;
begin
   init(a);
   init(b);
   makelist(11, 13, a);
   makelist(11, 13, b);
   putlist(a);
   new_line;
   putlist(b);
   new_line;
   if equal(a, b) then
      put_line("same");
   else
      put_line("different");
   end if;
end demo;

