package Parsing is
   type Result (Length : Natural) is record
      Success   : Boolean;
      Remaining : String (1 .. Length);
   end record;

   function Parse_A (Input : in String) return Result;
end Parsing;
