with Ada.Containers;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;
with Parsing;

procedure Simple is
   use type Ada.Containers.Count_Type;

   -- Input   : constant String := "ABZ";
   -- Input   : constant String := "ACZ";
   -- Input   : constant String := "QBZ";
   Input   : constant String := "AQZ";
   Parse_A                  : aliased Parsing.Parse_Character (Match => 'A');
   Parse_B                  : aliased Parsing.Parse_Character (Match => 'B');
   Parse_C                  : aliased Parsing.Parse_Character (Match => 'C');
   Parse_B_Or_Else_C        : aliased Parsing.Parse_Or_Else (Parse_B'Access, Parse_C'Access);
   Parse_A_And_Then_B_Or_C  : Parsing.Parse_And_Then (Parse_A'Access, Parse_B_Or_Else_C'Access);
   Result  : Parsing.Result'Class := Parse_A_And_Then_B_Or_C.Parse (Input);

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
