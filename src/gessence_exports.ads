with Interfaces;

package GEssence_Exports is

   procedure Wasm_Water (M : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "water";

   procedure Wasm_Is_Prime (M : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "is_prime";

   procedure Wasm_Add (A : Interfaces.Integer_32;
                       B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_add";

   procedure Wasm_Subtract (A : Interfaces.Integer_32;
                            B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_subtract";

   procedure Wasm_Multiply (A : Interfaces.Integer_32;
                            B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_multiply";

   procedure Wasm_Divide (A : Interfaces.Integer_32;
                          B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_divide";

   procedure Wasm_Power (A : Interfaces.Integer_32;
                         B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_power";

   procedure Wasm_Self_Power (M : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_self_power";

   procedure Wasm_Pythagorean (A : Interfaces.Integer_32;
                               B : Interfaces.Integer_32)
     with Export, Convention => C, External_Name => "gessence_pythagorean";

end GEssence_Exports;
