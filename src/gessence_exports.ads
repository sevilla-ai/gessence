with Interfaces;

package GEssence_Exports is

   procedure Wasm_Water (M : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "water";

   procedure Wasm_Is_Prime (M : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "is_prime";

end GEssence_Exports;
