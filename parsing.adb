package body Parsing is
   function Parse (Parser : in Parse_Character; Input : in String) return Result'Class is
   begin
      if Input = "" then
         return Failure'(Message => To_Unbounded_String ("No more input"));
      elsif Input (Input'First) = Parser.Match then
         declare
            Chars : Char_List.List;
            L     : List_Of_Char_Lists.List;
         begin
            Chars.Append (Parser.Match);
            L.Append (Chars);

            return Success'(Matched => L,
                           Remaining => To_Unbounded_String (Input (Input'First + 1 .. Input'Last)));
         end;
      else
         return Failure'(Message => To_Unbounded_String
                          ("Expecting '" & Parser.Match & "', got '" & Input (Input'First) & "'"));
      end if;
   end Parse;

   function Parse (Parser : in Parse_And_Then; Input : in String) return Result'Class is
      Result_1 : Result'Class := Parser.Parser_A.Parse (Input);
   begin
      if Result_1 in Failure'Class then
         return Result_1;
      end if;

      declare
         Result_2 : Result'Class := Parser.Parser_B.Parse (To_String (Success (Result_1).Remaining));
         Chars    : Char_List.List;
         L        : List_Of_Char_Lists.List;
      begin
         if Result_2 in Failure'Class then
            return Result_2;
         end if;

         for I of Success (Result_1).Matched loop
            for C of I loop
               Chars.Append (C);
            end loop;
         end loop;

         for I of Success (Result_2).Matched loop
            for C of I loop
               Chars.Append (C);
            end loop;
         end loop;

         L.Append (Chars);

         return Success'(Matched   => L,
                         Remaining => Success (Result_2).Remaining);
      end;
   end Parse;

   function Parse (Parser : in Parse_Or_Else; Input : in String) return Result'Class is
      function Build_Result (R : in Success) return Result'Class is
         Chars  : Char_List.List;
         L      : List_Of_Char_Lists.List;
      begin
         for I of R.Matched loop
            for C of I loop
               Chars.Append (C);
            end loop;
         end loop;

         L.Append (Chars);

         return Success'(Matched   => L,
                         Remaining => R.Remaining);
      end Build_Result;

      Result_1 : Result'Class := Parser.Parser_A.Parse (Input);
   begin
      --  Do this...
      if Result_1 in Success'Class then
         return Build_Result (Success (Result_1));
      end if;

      --  Or this...
      return Parser.Parser_B.Parse (Input);
      -- declare
      --    Result_2 : Result'Class := Parser.Parser_B.Parse (Input);
      -- begin
      --    if Result_2 in Success'Class then
      --       return Build_Result (Success (Result_2));
      --    end if;

      --    --  Or fail.
      --    return Result_2;
      -- end;
   end Parse;
end Parsing;
