with Interfaces;
with WASM.Console;

procedure Hello_Wasm is
begin
   WASM.Console.Log (Interfaces.Integer_32 (13));
end Hello_Wasm;
