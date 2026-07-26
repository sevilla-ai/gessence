
package Essence_Resolver is

   subtype Base_Address is Integer range 1 .. 13; --atom counter -- can go up to the hebrew numbers ? hebrew first ? 
   subtype Large_M is Long_Long_Integer range -302_875_106_592_253 .. 302_875_106_592_253; --13^13
   
   
   -- type Transition_Address is delta 0.1 range 1.0 .. 13.0;
   --- Na_Pointer - 11 -> 1.1 ; Helium flush 

   function Is_Prime (M : Base_Address) return Boolean;

   -- √ pointer — for ada_13x13 (1-169)
   function Hydrogen  (M : Positive) return Base_Address;

   -- M^M pointer — for ada_13^13 (170 – 302_875_106_592_253)
   function Oxygen  (M : Long_Long_Integer) return Base_Address;

   -- resolves any M back to base regardless of which matrix it came from
   function Water (M : Long_Long_Integer) return Base_Address;
   
   function I_Cycle (Power : Integer) return Integer;
   function Mod_Six (M : Natural) return Natural;
   function Rem_Six (M : Integer ) return Integer;
   function Hydrogen_Resolve (M : Integer) return Integer;

end Essence_Resolver;