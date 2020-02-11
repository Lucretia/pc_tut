package body Parsing is
   function Parse_Char (Match : in Character; Input : in String) return Result is
   begin
      if Input = "" then
         return Result'(Message   => +("No more input"),
                        Remaining => +(""));
      elsif Input (Input'First) = Match then
         return Result'(Message   => +("Found " & Match),
                        Remaining => +(Input (Input'First + 1 .. Input'Last)));
      else
         return Result'(Message   => +("Expecting '" & Match & "', got '" & Input (Input'First) & "'"),
                        Remaining => +(Input));
      end if;
   end Parse_Char;
end Parsing;
