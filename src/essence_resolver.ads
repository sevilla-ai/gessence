--  essence_resolver.ads
--  Prime address system: resolves any M back to base address 1 .. 14.

package Essence_Resolver is

   --  Atom counter. 14 = (0,0)(2,7) closes the WebAssembly section loop.
   subtype Base_Address is Integer range 1 .. 14;

   --  System ceiling is 14**14, mirrored on the air (negative) side.
   Ceiling : constant Long_Long_Integer := 11_112_006_825_558_016;

   subtype Large_M is Long_Long_Integer range -Ceiling .. Ceiling;

   --  Square space: the 14 x 14 matrix.
   subtype Square_M is Integer range 1 .. 196;

   --  Seven direct primes in the base: 1, 2, 3, 5, 7, 11, 13.
   --  Unity counts as prime in this system; the seven composites are
   --  4, 6, 8, 9, 10, 12, 14.
   function Is_Prime (M : Base_Address) return Boolean;

   --  Atom classification follows GEv2 address precedence: direct/prime-like
   --  addresses, including Unity (1), are Prime_Atom; non-prime perfect
   --  squares are Square_Atom; other composites are Composite_Atom.
   type Atom_Kind is
     (Prime_Atom,
      Square_Atom,
      Composite_Atom);

   function Resolve_Atom (M : Base_Address) return Atom_Kind;

   --  Square-root pointer, for the 14 x 14 matrix.
   function Hydrogen (M : Square_M) return Base_Address;

   --  Self-power pointer, for the M**M space up to 14**14.
   function Oxygen (M : Large_M) return Base_Address;

   --  Direct/prime root-component band: maps prime base addresses to
   --  Helium bands. Unity (1) is direct by GEv2 convention.
   function Helium (M : Base_Address) return Natural;

   --  Composite band: maps non-prime base addresses to Gas bands.
   --  Helium and Gas partition Base_Address exactly: every address is
   --  prime (Helium's domain) XOR composite (Gas's domain), never both,
   --  never neither. {4,6,8} -> 1, {9,10} -> 2, {12,14} -> 3.
   function Gas (M : Base_Address) return Natural;

   --  Resolves any M back to base, regardless of which matrix it came from.
   function Water (M : Large_M) return Base_Address;

   --  For imaginary number boundary.
   function I_Cycle (Power : Integer) return Integer;

   --  Address lookup: always non-negative, on both sides of the origin.
   function Mod_Six (M : Integer) return Natural;

   --  Weight calculation: signed, preserves the air/water side.
   function Rem_Six (M : Integer) return Integer;

   function Hydrogen_Resolve (M : Integer) return Integer;

end Essence_Resolver;
