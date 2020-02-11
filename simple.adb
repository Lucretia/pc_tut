with Ada.Containers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Parsing;

procedure Simple is
   use type Ada.Containers.Count_Type;

   Input   : constant String := "ABC";
   -- Input   : constant String := "ZBC";
   -- Input   : constant String := "AZC";
   Parse_A : aliased Parsing.Parse_Character (Match => 'A');
   Parse_B : aliased Parsing.Parse_Character (Match => 'B');
   Parser  : Parsing.Parse_And_Then (Parse_A'Access, Parse_B'Access);
   Result  : Parsing.Result'Class := Parser.Parse (Input);

   procedure Print_Result (R : Parsing.Result'Class) is
      First : Boolean := True;
   begin
      if R in Parsing.Success'Class then
         Put ("Success (");

         for I of Parsing.Success (R).Matched loop
            if I.Length = 1 then
               Put ("'" & I.First_Element & "'");
            else
               Put ("(");

               for C of I loop
                  if First then
                     Put ("'" & C & "'");

                     First := not First;
                  else
                     Put (", '" & C & "'");
                  end if;
               end loop;

               Put (")");
            end if;
            -- Parsing.Single (Parsing.Success (R).Matched.First_Element).A
         end loop;

         Put_Line (", """ & To_String (Parsing.Success (R).Remaining) & """)");
      elsif R in Parsing.Failure'Class then
         Put_Line ("Failure " & To_String (Parsing.Failure (R).Message));
      end if;
   end Print_Result;
begin
   Print_Result (Result);
end Simple;
