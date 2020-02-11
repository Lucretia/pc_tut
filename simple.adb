--  https://fsharpforfunandprofit.com/posts/understanding-parser-combinators/
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Parsing;

procedure Simple is
   function "+" (Source : in Unbounded_String) return String renames To_String;
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;

   Input  : constant String := "ABC";
   -- Input  : constant String := "ZBC";
   Result : Parsing.Result  := Parsing.Parse_Char ('A', Input);

   procedure Print_Result (R : Parsing.Result) is
      Message   : constant String := +(R.Message);
      Remaining : constant String := +(R.Remaining);
   begin
      Put_Line ("(" & Message & ", """ & Remaining & """)");
   end Print_Result;
begin
   Print_Result (Result);
end Simple;
