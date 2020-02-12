with Ada.Strings.Unbounded;              use Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;

package Parsing is
   package Char_List is new Ada.Containers.Indefinite_Doubly_Linked_Lists (Element_Type => Character);
   package List_Of_Char_Lists is new Ada.Containers.Doubly_Linked_Lists (Element_Type => Char_List.List, "=" => Char_List."=");

   type Result is interface;

   type Failure is new Result with record
      Message   : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Success is new Result with record
      Matched   : List_Of_Char_Lists.List;
      Remaining : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   type Root_Parser is interface;

   function Parse (Parser : in Root_Parser; Input : in String) return Result'Class is abstract;

   type Parse_Character (Match : Character) is new Root_Parser with null record;

   function Parse (Parser : in Parse_Character; Input : in String) return Result'Class;

   type Parse_And_Then (Parser_A, Parser_B : access Root_Parser'Class) is new Root_Parser with null record;

   function Parse (Parser : in Parse_And_Then; Input : in String) return Result'Class;

   type Parse_Or_Else (Parser_A, Parser_B : access Root_Parser'Class) is new Root_Parser with null record;

   function Parse (Parser : in Parse_Or_Else; Input : in String) return Result'Class;
end Parsing;
