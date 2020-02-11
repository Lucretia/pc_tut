--  https://fsharpforfunandprofit.com/posts/understanding-parser-combinators/
with Ada.Text_IO; use Ada.Text_IO;
with Parsing;

procedure Simple is
   -- type A is array (1 .. 1000_000_000) of Boolean with Pack;

   Input  : constant String := "ABC";
   -- Input  : constant String := "ZBC";
   Result : Parsing.Result  := Parsing.Parse_A (Input);

   procedure Print_Result (R : Parsing.Result) is
   begin
      Put_Line ("(" & Boolean'Image (R.Success) & ", """ & R.Remaining & """)");
   end Print_Result;
begin
   Print_Result (Result);
end Simple;
