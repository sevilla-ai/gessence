--  essence_resolver.adb

package body Essence_Resolver is

   --  Unity is a direct prime here: 1 is reachable only from itself, so it
   --  belongs with the addresses that have no factor pointer. This is a
   --  deliberate departure from the number-theory convention.
   function Is_Prime (M : Base_Address) return Boolean is
   begin
      case M is
         when 1 | 2 | 3 | 5 | 7 | 11 | 13 => return True;
         when others                      => return False;
      end case;
   end Is_Prime;

   --  Hydrogen: sqrt (M) -> nearest base address.
   --  Boundaries are the perfect squares 1, 4, 9, 16 ... 196.
   function Hydrogen (M : Square_M) return Base_Address is
   begin
      if M = 196 then
         return 14;
      elsif M >= 169 then
         return 13;
      elsif M >= 144 then
         return 12;
      elsif M >= 121 then
         return 11;
      elsif M >= 100 then
         return 10;
      elsif M >= 81 then
         return 9;
      elsif M >= 64 then
         return 8;
      elsif M >= 49 then
         return 7;
      elsif M >= 36 then
         return 6;
      elsif M >= 25 then
         return 5;
      elsif M >= 16 then
         return 4;
      elsif M >= 9 then
         return 3;
      elsif M >= 4 then
         return 2;
      else
         return 1;
      end if;
   end Hydrogen;

   --  Oxygen: M**M -> nearest base address.
   --  Boundaries are the self-powers 1**1, 2**2, 3**3 ... 14**14.
   function Oxygen (M : Large_M) return Base_Address is
      Abs_M : constant Large_M := abs M;
   begin
      if Abs_M = Ceiling then
         return 14;
      elsif Abs_M >= 302_875_106_592_253 then
         return 13;
      elsif Abs_M >= 8_916_100_448_256 then
         return 12;
      elsif Abs_M >= 285_311_670_611 then
         return 11;
      elsif Abs_M >= 10_000_000_000 then
         return 10;
      elsif Abs_M >= 387_420_489 then
         return 9;
      elsif Abs_M >= 16_777_216 then
         --  Perfect Elephant pointer (Terry Davis).
         return 8;
      elsif Abs_M >= 823_543 then
         return 7;
      elsif Abs_M >= 46_656 then
         return 6;
      elsif Abs_M >= 3_125 then
         return 5;
      elsif Abs_M >= 256 then
         return 4;
      elsif Abs_M >= 27 then
         return 3;
      elsif Abs_M >= 4 then
         return 2;
      else
         return 1;
      end if;
   end Oxygen;

      --  Helium: irrational prime-root band.
   --  Prime roots 1, 2, 3 fold to band 1.
   --  Prime roots 5, 7, 11, 13 fold to band 2.
   --  Non-prime inputs are not useful in this layer and return 0.
   function Helium (M : Base_Address) return Natural is
   begin
      if not Is_Prime (M) then
         return 0;
      end if;

      case M is
         when 1 | 2 | 3 =>
            return 1;
         when 5 | 7 =>
            return 2;
         when 11 | 13 =>
            return 3;
         when others =>
            return 0;
      end case;
   end Helium;

   --  Gas: composite band, the mirror of Helium.
   --  Composites 4, 6, 8   fold to band 1.
   --  Composites 9, 10     fold to band 2.
   --  Composites 12, 14    fold to band 3.
   --  Prime inputs are not useful in this layer and return 0.
   function Gas (M : Base_Address) return Natural is
   begin
      if Is_Prime (M) then
         return 0;
      end if;
 
      case M is
         when 4 | 6 | 8 =>
            return 1;
         when 9 | 10 =>
            return 2;
         when 12 | 14 =>
            return 3;
         when others =>
            return 0;
      end case;
   end Gas;
   --  Water: routes any M back to base 1 .. 13.
   --  Negative M uses its absolute value for the address lookup; the sign is
   --  carried by the weight (rem), never by the address (mod).
   --  The origin has no address of its own, so 0 grounds out at Unity, which
   --  is what Hydrogen and Oxygen already do for the low end of their ranges.
   function Water (M : Large_M) return Base_Address is
      Abs_M : constant Large_M := abs M;
   begin
      if Abs_M = 0 then
         return 1;
      elsif Abs_M <= 14 then
         return Base_Address (Abs_M);
      elsif Abs_M <= 196 then
         return Hydrogen (Square_M (Abs_M));
      else
         return Oxygen (Abs_M);
      end if;
   end Water;

      --  I_Cycle: signed fold counter in the ±2^3 band (rem 8),
      --  preserving the air/water side.
   function I_Cycle (Power : Integer) return Integer is
   begin
      return Power rem 8;
   end I_Cycle;

   --  Mod_Six: examines behavior around the first prime product (2×3 = 6).
   --  Multiples of 6 collapse to origin, nearby values reveal composite vs prime.
   function Mod_Six (M : Integer) return Natural is
   begin
      return M mod 6;
   end Mod_Six;

   --  Rem_Six: weight calculation, signed, preserves the air/water side.
   --  -12 rem 6 = 0  -> air side reverse pointer still collapses.
   --  -13 rem 6 = -1 -> air side prime, negative H.
   function Rem_Six (M : Integer) return Integer is
   begin
      return M rem 6;
   end Rem_Six;

   --  Hydrogen_Resolve: ground state. Any M rem 1 = 0, so every address is
   --  fully consumed and returned to the origin, on either side.
   function Hydrogen_Resolve (M : Integer) return Integer is
   begin
      return M rem 1;
   end Hydrogen_Resolve;

end Essence_Resolver;
