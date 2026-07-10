-- essence_resolver.adb
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics;

package body Essence_Resolver is

   package Long_Math is new
      Ada.Numerics.Generic_Elementary_Functions (Long_Float);

   function Is_Prime (M : Base_Address) return Boolean is
   begin
      case M is
         when 2|3|5|7|11|13 => return True;
         when others         => return False;
      end case;
   end Is_Prime;

   function Hydrogen (M : Positive) return Base_Address is
      Root : constant Long_Float :=
         Long_Math.Sqrt (Long_Float (M));
   begin
      return Base_Address'Min (13, Base_Address'Max (1,
             Base_Address (Integer (Root))));
   end Hydrogen;

   function Oxygen (M : Positive) return Base_Address is
      Root : constant Long_Float :=
         Long_Float (M) ** (1.0 / 3.0);
   begin
      return Base_Address'Min (13, Base_Address'Max (1,
             Base_Address (Integer (Root))));
   end Oxygen;

   function Water (M : Positive) return Base_Address is
   begin
      if M <= 13     then return M;
      elsif M <= 169 then return Hydrogen (M);
      else                return Oxygen (M);
      end if;
   end Water;

end Essence_Resolver;