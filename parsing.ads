with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Parsing is
   function "+" (Source : in Unbounded_String) return String renames To_String;
   function "+" (Source : in String) return Unbounded_String renames To_Unbounded_String;

   type Result is interface;

   type Failure is new Result with record
      Message   : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Success is new Result with record
      Matched   : Character;
      Remaining : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   function Parse_Char (Match : in Character; Input : in String) return Result'Class;
end Parsing;
