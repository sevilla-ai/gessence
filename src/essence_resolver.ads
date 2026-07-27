--  essence_resolver.ads
--  Prime address system: resolves any M back to base address 1 .. 13.

package Essence_Resolver is

   --  Atom counter. 13 = 3**2 + 2**2, closes the WebAssembly section loop.
   subtype Base_Address is Integer range 1 .. 13;

   --  System ceiling is 13**13, mirrored on the air (negative) side.
   Ceiling : constant := 302_875_106_592_253;

   subtype Large_M is Long_Long_Integer range -Ceiling .. Ceiling;

   --  Square space: the 13 x 13 matrix.
   subtype Square_M is Integer range 1 .. 169;

   --  Seven direct primes in the base: 1, 2, 3, 5, 7, 11, 13.
   --  Unity counts as prime in this system; the six composites are
   --  4, 6, 8, 9, 10, 12.
   function Is_Prime (M : Base_Address) return Boolean;

   --  Square-root pointer, for the 13 x 13 matrix.
   function Hydrogen (M : Square_M) return Base_Address;

   --  Self-power pointer, for the M**M space up to 13**13.
   function Oxygen (M : Large_M) return Base_Address;

   --  Resolves any M back to base, regardless of which matrix it came from.
   function Water (M : Large_M) return Base_Address;

   function I_Cycle (Power : Integer) return Integer;

   --  Address lookup: always non-negative, on both sides of the origin.
   function Mod_Six (M : Integer) return Natural;

   --  Weight calculation: signed, preserves the air/water side.
   function Rem_Six (M : Integer) return Integer;

   function Hydrogen_Resolve (M : Integer) return Integer;

end Essence_Resolver;
