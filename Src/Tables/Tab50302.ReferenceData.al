table 50302 "Reference Data"
{
    Caption = 'Reference Data';
    DataClassification = ToBeClassified;
    LookupPageId = "Reference Data List";
    DrillDownPageId = "Reference Data List";

    fields
    {
        field(1; "Type"; Enum "Reference Type")
        {
            Caption = 'Type';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Sorting Value"; Code[20])
        {
            Caption = 'Sorting Value';
        }
    }
    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
        key(PK1; Description)
        {

        }
        key(PK2; "Sorting Value")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {

        }
    }
}
