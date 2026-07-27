--  main_essence_test.adb
--  Human-readable console walk-through of the Essence_Resolver math.
--  Prints the base 1 .. 13 table, then a set of edge values, so the sign
--  handling and the ceiling behaviour can be read at a glance.
--  This main checks nothing and always exits 0; the automated expectations
--  live in test_essence_resolver.adb.

with Ada.Text_IO;
with Essence_Resolver;

procedure Main_Essence_Test is

   use Ada.Text_IO;

   package ER renames Essence_Resolver;

   M_Width   : constant := 18;
   Col_Width : constant := 10;

   Int_Low  : constant Long_Long_Integer := Long_Long_Integer (Integer'First);
   Int_High : constant Long_Long_Integer := Long_Long_Integer (Integer'Last);

   --  Origin, the reverse pointer, the primes 13 and -13, the corners of the
   --  13 x 13 matrix, and both ends of the 13**13 range.
   Edges : constant array (1 .. 9) of ER.Large_M :=
     [-ER.Ceiling, -169, -13, -12, 0, 12, 13, 169, ER.Ceiling];

   function Pad (S : String; W : Natural) return String;
   function Img (V : Long_Long_Integer) return String;
   procedure Put_Row (M : ER.Large_M; With_Prime : Boolean);

   --  Right aligns S in a field of W characters, so the columns line up
   --  without pulling in a formatting library.
   function Pad (S : String; W : Natural) return String is
   begin
      if S'Length >= W then
         return S;
      else
         return String'(1 .. W - S'Length => ' ') & S;
      end if;
   end Pad;

   --  'Image puts a blank where the minus sign would go; drop it.
   function Img (V : Long_Long_Integer) return String is
      S : constant String := V'Image;
   begin
      if S (S'First) = ' ' then
         return S (S'First + 1 .. S'Last);
      else
         return S;
      end if;
   end Img;

   --  Mod_Six and Rem_Six take an Integer, so the two ceiling values fall
   --  outside their domain and are reported as "n/a" rather than skipped.
   procedure Put_Row (M : ER.Large_M; With_Prime : Boolean) is
      Fits : constant Boolean := M in Int_Low .. Int_High;
   begin
      Put (Pad (Img (M), M_Width));

      if With_Prime then
         Put (Pad (ER.Is_Prime (ER.Base_Address (M))'Image, Col_Width));
      end if;

      Put (Pad (Img (Long_Long_Integer (ER.Water (M))), Col_Width));

      if Fits then
         Put (Pad (Img (Long_Long_Integer (ER.Mod_Six (Integer (M)))),
                   Col_Width));
         Put (Pad (Img (Long_Long_Integer (ER.Rem_Six (Integer (M)))),
                   Col_Width));
      else
         Put (Pad ("n/a", Col_Width));
         Put (Pad ("n/a", Col_Width));
      end if;

      New_Line;
   end Put_Row;

begin
   Put_Line ("GEssence -- Essence_Resolver native check");
   Put_Line ("Ceiling is 13**13 =" & ER.Ceiling'Image
             & ", mirrored on the air side.");
   New_Line;

   Put_Line ("Base addresses 1 .. 13");
   Put_Line (Pad ("M", M_Width) & Pad ("Is_Prime", Col_Width)
             & Pad ("Water", Col_Width) & Pad ("Mod_Six", Col_Width)
             & Pad ("Rem_Six", Col_Width));
   Put_Line (Pad ("--", M_Width) & Pad ("--------", Col_Width)
             & Pad ("-----", Col_Width) & Pad ("-------", Col_Width)
             & Pad ("-------", Col_Width));

   for M in ER.Base_Address loop
      Put_Row (Long_Long_Integer (M), With_Prime => True);
   end loop;

   New_Line;
   Put_Line ("Edge and air-side values");
   Put_Line (Pad ("M", M_Width) & Pad ("Water", Col_Width)
             & Pad ("Mod_Six", Col_Width) & Pad ("Rem_Six", Col_Width));
   Put_Line (Pad ("--", M_Width) & Pad ("-----", Col_Width)
             & Pad ("-------", Col_Width) & Pad ("-------", Col_Width));

   for M of Edges loop
      Put_Row (M, With_Prime => False);
   end loop;

   New_Line;
   Put_Line ("Mod_Six is the address lookup and is never negative.");
   Put_Line ("Rem_Six is the weight and keeps the air (negative) side.");
   Put_Line ("Water grounds the origin at Unity and folds the air side onto"
             & " its water-side address.");
end Main_Essence_Test;
