with Ada.Strings.Unbounded;              use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;



package Parsing is
   package Char_List is new Ada.Containers.Doubly_Linked_Lists (Element_Type => Character);
   type Matches is interface;

   type Result is interface;

   type Failure is new Result with record
      Message   : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Success is new Result with record
      Matched   : Char_List.List;
      Remaining : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   function Parse_Char (Match : in Character; Input : in String) return Result'Class;
end Parsing;
