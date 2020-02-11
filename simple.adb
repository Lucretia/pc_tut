--  https://fsharpforfunandprofit.com/posts/understanding-parser-combinators/
with Ada.Text_IO; use Ada.Text_IO;
with Parsing;

procedure Simple is
   -- type A is array (1 .. 1000_000_000) of Boolean with Pack;

   Input  : constant String := "ABC";
   Result : Parsing.Result  := Parsing.Parse_A (Input);
begin
   if Result.Success = True then
      Put_Line ("Success - Reamining input: '" & Result.Remaining & "'");
   else
      Put_Line ("Parsing Failed - Reamining input: '" & Result.Remaining & "'");
   end if;
end Simple;
