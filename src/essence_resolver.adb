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
   -- instead of computing √, we know the boundaries:
   -- √1=1, √4=2, √9=3, √16=4... √169=13
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

   -- Oxygen: ∛M → nearest base address
   -- ∛1=1, ∛8=2, ∛27= after this its 64 x 4, fits U64 4 times

   function Oxygen (M : Long_Long_Integer) return Base_Address is
   begin
      if    M >= 302_875_106_592_253 then return 13;
      elsif M >= 8_916_100_448_256   then return 12;
      elsif M >= 285_311_670_611     then return 11;
      elsif M >= 10_000_000_000      then return 10;
      elsif M >= 387_420_489         then return 9;
      elsif M >= 16_777_216          then return 8;
      elsif M >= 823_543             then return 7;
      elsif M >= 46_656              then return 6;
      elsif M >= 3_125               then return 5;
      elsif M >= 256                 then return 4;
      elsif M >= 27                  then return 3;
      elsif M >= 4                   then return 2;
      else                                return 1;
      end if;
   end Oxygen;

   function Water (M : Long_Long_Integer) return Base_Address is
   begin
      if    M <= 13  then return Base_Address (Integer (M));
      elsif M <= 256 then return Hydrogen (Integer (M));
      else                return Oxygen (M);
      end if;
   end Water;

   function I_Cycle (Power : Positive) return Natural is -- should resolve to 3's 
   begin
      return Power mod 9;
   end I_Cycle;

   function Mod_Eleven (M : Positive) return Natural is -- should resolve 0's in double digits
   begin
      return M mod 11;
   end Mod_Eleven;

   function Hydrogen_Resolve (M : Positive) return Natural is  -- my "else" or "max" 
   begin
      if M = 1 then return 0;
      else          return M mod 1;
      end if;
   end Hydrogen_Resolve;

end Essence_Resolver;