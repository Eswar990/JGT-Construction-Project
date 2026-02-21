tableextension 50301 "GLAccount Exe" extends "G/L Account"
{
    fields
    {
        field(50200; "VAT Account"; Boolean)
        {
            Caption = 'VAT Account';
            DataClassification = ToBeClassified;
        }
        modify("Account Category")
        {
            trigger OnAfterValidate()
            begin
                if (Rec."Account Category" <> Rec."Account Category"::Income) or
                    (Rec."Account Category" <> Rec."Account Category"::Expense) then
                    Rec."Distribution Required" := true
                else
                    Rec."Distribution Required" := false;
            end;
        }
        field(50201; "Distribution Required"; Boolean)
        {
            Caption = 'Distribution Required';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId);
                if not UserSetup.Distribution then
                    Error('Your not allowed change the value. Please contact system administrator.');
            end;
        }
        field(50300; "Is Asset Distribution"; Boolean)
        {
            Caption = 'Is Asset Distribution';
            DataClassification = ToBeClassified;
        }
    }
}
