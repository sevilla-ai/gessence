
package Essence_Resolver is

   subtype Base_Address is Integer range 1 .. 13; --atom counter -- can go up to the hebrew numbers ? hebrew first ? 
   subtype Large_M is Long_Long_Integer range 1 .. 302_875_106_592_253; --13^13
   
   
   -- type Transition_Address is delta 0.1 range 1.0 .. 13.0;
   --- Na_Pointer - 11 -> 1.1 ; Helium flush 

   function Is_Prime (M : Base_Address) return Boolean;

   -- √ pointer — for ada_13x13 (1-169)
   function Hydrogen  (M : Positive) return Base_Address;

   -- ∛ pointer — for ada_99x99 (13 – 23298085122481)
   function Oxygen  (M : Long_Long_Integer) return Base_Address;

   -- resolves any M back to base regardless of which matrix it came from
   function Water (M : Long_Long_Integer) return Base_Address;
   
   function I_Cycle (Power : Positive) return Natural;
   function Mod_Eleven (M    : Positive) return Natural;
   function Hydrogen_Resolve (M : Positive) return Natural;

end Essence_Resolver;