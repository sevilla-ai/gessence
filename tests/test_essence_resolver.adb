--  test_essence_resolver.adb
--  Self-checking harness for the base 1 .. 13 address system.
--  Exits with status 1 if any expectation fails.

with Ada.Command_Line;
with Ada.Text_IO;
with Essence_Resolver;

procedure Test_Essence_Resolver is

   use Ada.Text_IO;

   package ER renames Essence_Resolver;

   Failures : Natural := 0;

   procedure Check (Label : String; Actual, Expected : Long_Long_Integer);
   procedure Check (Label : String; Actual, Expected : Boolean);

   procedure Check (Label : String; Actual, Expected : Long_Long_Integer) is
   begin
      if Actual = Expected then
         Put_Line ("  ok   " & Label);
      else
         Failures := Failures + 1;
         Put_Line ("  FAIL " & Label
                   & " expected" & Expected'Image
                   & " got" & Actual'Image);
      end if;
   end Check;

   procedure Check (Label : String; Actual, Expected : Boolean) is
   begin
      if Actual = Expected then
         Put_Line ("  ok   " & Label);
      else
         Failures := Failures + 1;
         Put_Line ("  FAIL " & Label
                   & " expected " & Expected'Image
                   & " got " & Actual'Image);
      end if;
   end Check;

begin
   Put_Line ("Is_Prime");
   for M in ER.Base_Address loop
      Check ("Is_Prime" & M'Image,
             ER.Is_Prime (M),
             M in 1 | 2 | 3 | 5 | 7 | 11 | 13);
   end loop;

   Put_Line ("Hydrogen (floor sqrt over the 13 x 13 matrix)");
   Check ("Hydrogen 1", Long_Long_Integer (ER.Hydrogen (1)), 1);
   Check ("Hydrogen 3", Long_Long_Integer (ER.Hydrogen (3)), 1);
   Check ("Hydrogen 4", Long_Long_Integer (ER.Hydrogen (4)), 2);
   Check ("Hydrogen 14", Long_Long_Integer (ER.Hydrogen (14)), 3);
   Check ("Hydrogen 168", Long_Long_Integer (ER.Hydrogen (168)), 12);
   Check ("Hydrogen 169", Long_Long_Integer (ER.Hydrogen (169)), 13);

   Put_Line ("Oxygen (self-power boundaries)");
   Check ("Oxygen 1", Long_Long_Integer (ER.Oxygen (1)), 1);
   Check ("Oxygen 27", Long_Long_Integer (ER.Oxygen (27)), 3);
   Check ("Oxygen 255", Long_Long_Integer (ER.Oxygen (255)), 3);
   Check ("Oxygen 256", Long_Long_Integer (ER.Oxygen (256)), 4);
   Check ("Oxygen 16_777_216", Long_Long_Integer (ER.Oxygen (16_777_216)), 8);
   Check ("Oxygen ceiling",
          Long_Long_Integer (ER.Oxygen (ER.Ceiling)), 13);
   Check ("Oxygen -ceiling (air side mirrors water side)",
          Long_Long_Integer (ER.Oxygen (-ER.Ceiling)), 13);

   Put_Line ("Water (every M resolves inside 1 .. 13)");
   Check ("Water 0 grounds out at Unity",
          Long_Long_Integer (ER.Water (0)), 1);
   Check ("Water 1", Long_Long_Integer (ER.Water (1)), 1);
   Check ("Water 13", Long_Long_Integer (ER.Water (13)), 13);
   Check ("Water 42", Long_Long_Integer (ER.Water (42)), 6);
   Check ("Water 169", Long_Long_Integer (ER.Water (169)), 13);
   Check ("Water 170 crosses into Oxygen",
          Long_Long_Integer (ER.Water (170)), 3);
   Check ("Water -13 (air side)", Long_Long_Integer (ER.Water (-13)), 13);
   Check ("Water -42 (air side)", Long_Long_Integer (ER.Water (-42)), 6);
   Check ("Water ceiling",
          Long_Long_Integer (ER.Water (ER.Ceiling)), 13);
   Check ("Water -ceiling",
          Long_Long_Integer (ER.Water (-ER.Ceiling)), 13);

   --  The whole point of the address space: nothing escapes 1 .. 13.
   for M in Long_Long_Integer range -400 .. 400 loop
      declare
         A : constant Integer := ER.Water (M);
      begin
         if A not in ER.Base_Address then
            Failures := Failures + 1;
            Put_Line ("  FAIL Water" & M'Image & " left the base:" & A'Image);
         end if;
      end;
   end loop;
   Put_Line ("  ok   Water (-400 .. 400) stays inside 1 .. 13");

   Put_Line ("Mod_Six / Rem_Six (address vs weight)");
   Check ("Mod_Six 12", Long_Long_Integer (ER.Mod_Six (12)), 0);
   Check ("Mod_Six 10", Long_Long_Integer (ER.Mod_Six (10)), 4);
   Check ("Mod_Six 11", Long_Long_Integer (ER.Mod_Six (11)), 5);
   Check ("Mod_Six 13", Long_Long_Integer (ER.Mod_Six (13)), 1);
   Check ("Mod_Six -12 collapses to origin",
          Long_Long_Integer (ER.Mod_Six (-12)), 0);
   Check ("Mod_Six -13 folds onto a water-side address",
          Long_Long_Integer (ER.Mod_Six (-13)), 5);
   Check ("Rem_Six -12", Long_Long_Integer (ER.Rem_Six (-12)), 0);
   Check ("Rem_Six -13 keeps the air-side sign",
          Long_Long_Integer (ER.Rem_Six (-13)), -1);

   --  mod is the address, rem is the weight: they must disagree on the air
   --  side, otherwise the signed distinction the pair exists for is lost.
   Check ("Mod_Six and Rem_Six differ on the air side",
          ER.Mod_Six (-13) /= ER.Rem_Six (-13), True);

   Put_Line ("I_Cycle / Hydrogen_Resolve");
   Check ("I_Cycle 5", Long_Long_Integer (ER.I_Cycle (5)), 1);
   Check ("I_Cycle -5", Long_Long_Integer (ER.I_Cycle (-5)), -1);
   Check ("Hydrogen_Resolve 13",
          Long_Long_Integer (ER.Hydrogen_Resolve (13)), 0);
   Check ("Hydrogen_Resolve -13",
          Long_Long_Integer (ER.Hydrogen_Resolve (-13)), 0);

   New_Line;
   if Failures = 0 then
      Put_Line ("All checks passed.");
   else
      Put_Line (Failures'Image & " check(s) failed.");
      Ada.Command_Line.Set_Exit_Status (1);
   end if;
end Test_Essence_Resolver;
