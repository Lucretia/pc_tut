package body Parsing is
   function Parse_Char (Match : in Character; Input : in String) return Result'Class is
   begin
      if Input = "" then
         return Failure'(Message => To_Unbounded_String ("No more input"));
      elsif Input (Input'First) = Match then
         declare
            L : Char_List.List;
         begin
            L.Append (Match);

            return Success'(Matched => L,
                           Remaining => To_Unbounded_String (Input (Input'First + 1 .. Input'Last)));
         end;
      else
         return Failure'(Message => To_Unbounded_String
                          ("Expecting '" & Match & "', got '" & Input (Input'First) & "'"));
      end if;
   end Parse_Char;
end Parsing;
