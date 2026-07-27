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
   --  Boundaries are the perfect squares 1, 4, 9, 16 ... 169.
   function Hydrogen (M : Square_M) return Base_Address is
   begin
      if M = 169 then
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
   --  Boundaries are the self-powers 1**1, 2**2, 3**3 ... 13**13.
   function Oxygen (M : Large_M) return Base_Address is
      Abs_M : constant Large_M := abs M;
   begin
      if Abs_M = Ceiling then
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
      elsif Abs_M <= 13 then
         return Base_Address (Abs_M);
      elsif Abs_M <= 169 then
         return Hydrogen (Square_M (Abs_M));
      else
         return Oxygen (Abs_M);
      end if;
   end Water;

   --  I_Cycle: signed rem 4, preserves the air/water side.
   --  Gives 0, 1, 2, 3 on the water side and 0, -1, -2, -3 on the air side.
   function I_Cycle (Power : Integer) return Integer is
   begin
      return Power rem 4;
   end I_Cycle;

   --  Mod_Six: address lookup, always non-negative.
   --  6 is the product of the first two primes (2 x 3).
   --  12 mod 6 = 0 -> reverse pointer dissolves to origin.
   --  10 mod 6 = 4 -> composite points to Factorial.
   --  11 mod 6 = 5 -> prime confirmed.
   --  13 mod 6 = 1 -> prime, back to Unity.
   --  -13 mod 6 = 5 -> the air side folds onto a water-side address.
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
