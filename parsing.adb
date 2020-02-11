package body Parsing is
   function Parse_Char (Match : in Character; Input : in String) return Result'Class is
   begin
      if Input = "" then
         return Failure'(Message => +("No more input"));
      elsif Input (Input'First) = Match then
         return Success'(Matched => Match,
                                 Remaining => +(Input (Input'First + 1 .. Input'Last)));
      else
         return Failure'(Message => +("Expecting '" & Match & "', got '" & Input (Input'First) & "'"));
      end if;
   end Parse_Char;
end Parsing;
