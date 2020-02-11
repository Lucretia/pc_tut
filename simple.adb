with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Parsing;

procedure Simple is
   function "+" (Source : in Unbounded_String) return String renames To_String;
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;

   -- Input  : constant String := "ABC";
   Input  : constant String := "ZBC";
   Result : Parsing.Result'Class  := Parsing.Parse_Char ('A', Input);

   procedure Print_Result (R : Parsing.Result'Class) is
   begin
      if R in Parsing.Success'Class then
         Put_Line ("Success ('" & Parsing.Success (R).Matched & "', """ & (+(Parsing.Success (R).Remaining)) & """)");
      elsif R in Parsing.Failure'Class then
         Put_Line ("Failure " & (+(Parsing.Failure (R).Message)));
      end if;
   end Print_Result;
begin
   Print_Result (Result);
end Simple;
