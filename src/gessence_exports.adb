with Interfaces;
with WASM.Console;
with Essence_Resolver;

package body GEssence_Exports is

   procedure Wasm_Water (M : Interfaces.Integer_32) is
      Result : Essence_Resolver.Base_Address;
   begin
      Result := Essence_Resolver.Water (Long_Long_Integer (M));
      WASM.Console.Log (Interfaces.Integer_32 (Result));
   end Wasm_Water;

   procedure Wasm_Is_Prime (M : Interfaces.Integer_32) is
   begin
      if M in 1 .. 13 then
         if Essence_Resolver.Is_Prime
           (Essence_Resolver.Base_Address (M))
         then
            WASM.Console.Log (Interfaces.Integer_32 (1));
         else
            WASM.Console.Log (Interfaces.Integer_32 (0));
         end if;
      else
         WASM.Console.Log (Interfaces.Integer_32 (0));
      end if;
   end Wasm_Is_Prime;

end GEssence_Exports;
