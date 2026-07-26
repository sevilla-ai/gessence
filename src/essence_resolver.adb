-- essence_resolver.adb
package body Essence_Resolver is

   function Is_Prime (M : Base_Address) return Boolean is
   begin
      case M is
         when 2|3|5|7|11|13 => return True;
         when others         => return False;
      end case;
   end Is_Prime;

   -- Hydrogen: √M → nearest base address
   -- boundaries are perfect squares: 1,4,9,16...169
   function Hydrogen (M : Positive) return Base_Address is
   begin
      if    M >= 169 then return 13;
      elsif M >= 144 then return 12;
      elsif M >= 121 then return 11;
      elsif M >= 100 then return 10;
      elsif M >= 81  then return 9;
      elsif M >= 64  then return 8;
      elsif M >= 49  then return 7;
      elsif M >= 36  then return 6;
      elsif M >= 25  then return 5;
      elsif M >= 16  then return 4;
      elsif M >= 9   then return 3;
      elsif M >= 4   then return 2;
      else                return 1;
      end if;
   end Hydrogen;

   -- Oxygen: M^M → nearest base address
   -- boundaries are self-powers: 1^1, 2^2, 3^3...13^13
   function Oxygen (M : Long_Long_Integer) return Base_Address is
      Abs_M : constant Long_Long_Integer := abs M;
   begin
      if    Abs_M >= 302_875_106_592_253 then return 13;
      elsif Abs_M >= 8_916_100_448_256   then return 12;
      elsif Abs_M >= 285_311_670_611     then return 11;
      elsif Abs_M >= 10_000_000_000      then return 10;
      elsif Abs_M >= 387_420_489         then return 9;
      elsif Abs_M >= 16_777_216          then return 8; -- Perfect Elephant pointer (Terry Davis)
      elsif Abs_M >= 823_543             then return 7;
      elsif Abs_M >= 46_656              then return 6;
      elsif Abs_M >= 3_125               then return 5;
      elsif Abs_M >= 256                 then return 4;
      elsif Abs_M >= 27                  then return 3;
      elsif Abs_M >= 4                   then return 2;
      else                                    return 1;
      end if;
   end Oxygen;

   -- Water: routes any M back to base 1-13
   -- negative M uses abs value for address lookup
   -- sign preserved in weight (rem), not address (mod)
   function Water (M : Long_Long_Integer) return Base_Address is
      Abs_M : constant Long_Long_Integer := abs M;
   begin
      if    Abs_M <= 13  then return Base_Address (Integer (Abs_M));
      elsif Abs_M <= 169 then return Hydrogen (Integer (Abs_M));
      else                    return Oxygen (Abs_M);
      end if;
   end Water;

   -- I_Cycle: signed rem 4 — preserves air/water side
   -- rem 4 gives: 0,1,2,3,-1,-2,-3 depending on sign
   function I_Cycle (Power : Integer) return Integer is
   begin
      return Power rem 4;
   end I_Cycle;

   -- Mod_Six: address lookup — always positive
   -- mod 6 = product of first two primes (2×3)
   -- 12 mod 6 = 0 → reverse pointer dissolves to origin
   -- 10 mod 6 = 4 → composite points to Factorial
   -- 11 mod 6 = 5 → prime confirmed
   -- 13 mod 6 = 1 → prime, back to Unity
   function Mod_Six (M : Natural) return Natural is
   begin
      return M mod 6;
   end Mod_Six;

   -- Rem_Six: weight calculation — signed, preserves air/water side
   -- -12 rem 6 = 0  → air side reverse pointer still collapses
   -- -13 rem 6 = -1 → air side prime, negative H
   function Rem_Six (M : Integer) return Integer is
   begin
      return M rem 6;
   end Rem_Six;

   -- Hydrogen_Resolve: ground state function
   -- any M rem 1 = 0 → fully consumed, returned to origin
   -- works for both positive (water) and negative (air)
   function Hydrogen_Resolve (M : Integer) return Integer is
   begin
      return M rem 1;
   end Hydrogen_Resolve;

end Essence_Resolver;