--  hello.adb -- sandbox sanity check.
--  container/Hello.sh matches this output exactly, so the success line must
--  stay the only thing printed when the resolver is healthy.

with Ada.Command_Line;
with Ada.Text_IO;
with Essence_Resolver;

procedure Hello is
   use Ada.Text_IO;

   --  Touching the resolver puts it in this main's closure, so the documented
   --  "gprbuild -P gessence.gpr" builds the library instead of hello alone.
   Origin : constant Essence_Resolver.Base_Address := Essence_Resolver.Water (0);
begin
   if Origin /= 1 then
      Put_Line ("Resolver check failed: origin resolved to" & Origin'Image);
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
      return;
   end if;

   Put_Line ("Ada library sandbox is alive.");
end Hello;
