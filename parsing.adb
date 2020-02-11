package body Parsing is
   function Parse_A (Input : in String) return Result is
   begin
      if Input = "" then
         return Result'(Success   => False,
                        Length    => 0,
                        Remaining => "");
      elsif Input (Input'First) = 'A' then
         return Result'(Success   => True,
                        Length    => Input'Length - 1,
                        Remaining => Input (Input'First + 1 .. Input'Last));
      else
         return Result'(Success   => False,
                        Length    => Input'Length,
                        Remaining => Input);
      end if;
   end Parse_A;
end Parsing;
