
package Essence_Resolver is

   subtype Base_Address is Integer range 1 .. 13; --pebble counter -- can go up to the hebrew numbers ? hebrew first ? 

   -- type Transition_Address is delta 0.1 range 1.0 .. 13.0;
   --- Na_Pointer - 11 -> 1.1 ; Helium flush 

   function Is_Prime (M : Base_Address) return Boolean;

   -- √ pointer — for ada_13x13 (1-169)
   function Hydrogen  (M : Positive) return Base_Address;

   -- ∛ pointer — for ada_99x99 (13 – 23298085122481)
   function Oxygen  (M : Positive) return Base_Address;

   -- resolves any M back to base regardless of which matrix it came from
   function Water (M : Positive) return Base_Address;

end Essence_Resolver;