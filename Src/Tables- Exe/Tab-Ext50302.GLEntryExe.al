tableextension 50302 "G/L Entry Exe" extends "G/L Entry"
{
    fields
    {
        field(50300; "Distributio Rule Applied"; Boolean)
        {
            Caption = 'Distributio Rule Applied';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50301; "Dist. Entry No Applied"; Integer)
        {
            Caption = 'Dist. Entry No Applied';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50302; "Account Category"; Enum "G/L Account Category")
        {
            Caption = 'Account Category';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account"."Account Category" where("No." = field("G/L Account No.")));
            Editable = false;
        }
        field(50303; "Distribution Required"; Boolean)
        {
            Caption = 'Distribution Required';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account"."Distribution Required" where("No." = field("G/L Account No.")));
            Editable = false;
        }

        field(50304; "Is Asset Distribution"; Boolean)
        {
            Caption = 'Is Asset Distribution';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account"."Is Asset Distribution" where("No." = field("G/L Account No.")));
        }
    }
}
