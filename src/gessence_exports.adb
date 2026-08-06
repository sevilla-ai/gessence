with Ada.Unchecked_Conversion;
with Interfaces;
with WASM.Console;
with Essence_Resolver;

use type Interfaces.Integer_32;
use type Interfaces.Unsigned_32;
use type Interfaces.Unsigned_64;

package body GEssence_Exports is

   function To_Unsigned_64 is new Ada.Unchecked_Conversion
     (Long_Long_Integer, Interfaces.Unsigned_64);

   function Bits_To_Signed_32 is new Ada.Unchecked_Conversion
     (Interfaces.Unsigned_32, Interfaces.Integer_32);

   --  Logs a full 64-bit value as two 32-bit words (high, then low) so the
   --  JS side can reconstruct it exactly as a BigInt instead of truncating.
   procedure Log_Wide (Value : Long_Long_Integer) is
      Bits : constant Interfaces.Unsigned_64 := To_Unsigned_64 (Value);
      High : constant Interfaces.Unsigned_32 :=
         Interfaces.Unsigned_32 (Interfaces.Shift_Right (Bits, 32));
      Low  : constant Interfaces.Unsigned_32 :=
         Interfaces.Unsigned_32 (Bits and 16#FFFF_FFFF#);
   begin
      WASM.Console.Log (Bits_To_Signed_32 (High));
      WASM.Console.Log (Bits_To_Signed_32 (Low));
   end Log_Wide;

   procedure Wasm_Water (M : Interfaces.Integer_32) is
      Result : Essence_Resolver.Base_Address;
   begin
      Result := Essence_Resolver.Water (Long_Long_Integer (M));
      WASM.Console.Log (Interfaces.Integer_32 (Result));
   end Wasm_Water;

   procedure Wasm_Is_Prime (M : Interfaces.Integer_32) is
   begin
      if M in 1 .. 14 then
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

   procedure Wasm_Add (A : Interfaces.Integer_32;
                       B : Interfaces.Integer_32) is
      Result : constant Long_Long_Integer :=
         Long_Long_Integer (A) + Long_Long_Integer (B);
      Addr   : constant Essence_Resolver.Base_Address :=
         Essence_Resolver.Water (Result);
   begin
      Log_Wide (Result);
      WASM.Console.Log (Interfaces.Integer_32 (Addr));
   end Wasm_Add;

   procedure Wasm_Subtract (A : Interfaces.Integer_32;
                            B : Interfaces.Integer_32) is
      Result : constant Long_Long_Integer :=
         Long_Long_Integer (A) - Long_Long_Integer (B);
      Addr   : constant Essence_Resolver.Base_Address :=
         Essence_Resolver.Water (Result);
   begin
      Log_Wide (Result);
      WASM.Console.Log (Interfaces.Integer_32 (Addr));
   end Wasm_Subtract;

   procedure Wasm_Multiply (A : Interfaces.Integer_32;
                            B : Interfaces.Integer_32) is
      Result : constant Long_Long_Integer :=
         Long_Long_Integer (A) * Long_Long_Integer (B);
      Addr   : Essence_Resolver.Base_Address;
   begin
      Log_Wide (Result);
      if abs Result > Essence_Resolver.Ceiling then
         WASM.Console.Log (Interfaces.Integer_32 (14));  --  ceiling-clamped
      else
         Addr := Essence_Resolver.Water (Result);
         WASM.Console.Log (Interfaces.Integer_32 (Addr));
      end if;
   end Wasm_Multiply;

   procedure Wasm_Divide (A : Interfaces.Integer_32;
                          B : Interfaces.Integer_32) is
      Result : Long_Long_Integer;
      Addr   : Essence_Resolver.Base_Address;
   begin
      if B = 0 then
         Log_Wide (0);
         WASM.Console.Log (Interfaces.Integer_32 (0));
      else
         Result := Long_Long_Integer (A) / Long_Long_Integer (B);
         Addr   := Essence_Resolver.Water (Result);
         Log_Wide (Result);
         WASM.Console.Log (Interfaces.Integer_32 (Addr));
      end if;
   end Wasm_Divide;

   procedure Wasm_Power (A : Interfaces.Integer_32;
                         B : Interfaces.Integer_32) is
      Result  : Long_Long_Integer := 1;
      Base    : constant Long_Long_Integer := Long_Long_Integer (A);
      Exp     : constant Integer           := Integer (B);
      Divisor : constant Long_Long_Integer :=
         (if abs Base < 1 then 1 else abs Base);
      Addr    : Essence_Resolver.Base_Address;
   begin
      if Exp < 0 then
         Log_Wide (0);
         WASM.Console.Log (Interfaces.Integer_32 (0));
      else
         for I in 1 .. Exp loop
            Result := Result * Base;
            exit when abs Result >= Long_Long_Integer'Last / Divisor;
         end loop;

         Log_Wide (Result);
         if abs Result > Essence_Resolver.Ceiling then
            WASM.Console.Log (Interfaces.Integer_32 (14));  --  ceiling-clamped
         else
            Addr := Essence_Resolver.Water (Result);
            WASM.Console.Log (Interfaces.Integer_32 (Addr));
         end if;
      end if;
   end Wasm_Power;

   procedure Wasm_Self_Power (M : Interfaces.Integer_32) is
      Base   : constant Long_Long_Integer := Long_Long_Integer (M);
      Result : Long_Long_Integer := 1;
      Addr   : Essence_Resolver.Base_Address;
   begin
      if M <= 0 then
         Log_Wide (0);
         WASM.Console.Log (Interfaces.Integer_32 (0));
      else
         for I in 1 .. Integer (M) loop
            Result := Result * Base;
            exit when abs Result >=
               Long_Long_Integer'Last / abs (Base + 1);
         end loop;

         Log_Wide (Result);
         if abs Result > Essence_Resolver.Ceiling then
            WASM.Console.Log (Interfaces.Integer_32 (14));  --  ceiling-clamped
         else
            Addr := Essence_Resolver.Water (Result);
            WASM.Console.Log (Interfaces.Integer_32 (Addr));
         end if;
      end if;
   end Wasm_Self_Power;

      procedure Wasm_Pythagorean (A : Interfaces.Integer_32;
                               B : Interfaces.Integer_32) is
      A2    : constant Long_Long_Integer :=
         Long_Long_Integer (A) * Long_Long_Integer (A);
      B2    : constant Long_Long_Integer :=
         Long_Long_Integer (B) * Long_Long_Integer (B);
      C2    : constant Long_Long_Integer := A2 + B2;
      Addr  : Essence_Resolver.Base_Address;
      Exact : Boolean;
   begin
      Log_Wide (C2);

      if C2 = 0 then
         Addr := 1;  --  grounds at Unity, same rule Water uses for M = 0
      elsif C2 <= 196 then
         Addr := Essence_Resolver.Hydrogen (Essence_Resolver.Square_M (C2));
      else
         Addr := 14;  --  clamped: past our sqrt-domain ceiling (14 = sqrt(196))
      end if;

      Exact := Long_Long_Integer (Addr) * Long_Long_Integer (Addr) = C2;

      WASM.Console.Log (Interfaces.Integer_32 (Addr));
      WASM.Console.Log (Interfaces.Integer_32 (if Exact then 1 else 0));
   end Wasm_Pythagorean;

end GEssence_Exports;
