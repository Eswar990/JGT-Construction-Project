table 50304 "JGT Distribution Project"
{
    Caption = 'JGT Distribution Project';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(3; "Project Amount"; Decimal)
        {
            Caption = 'Project Amount';
            // Editable = false;
        }
        field(4; "Project Line"; Boolean)
        {
            Caption = 'Project Line';
            Editable = false;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(7; "Emp. Count"; Integer)
        {
            Caption = 'Emp. Count';
            Editable = false;
        }
        field(8; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            Editable = false;
        }
        field(9; Year; Code[20])
        {
            Caption = 'Year';
            TableRelation = "Reference Data".Code where(Type = const(Year));
            Editable = false;
        }
        field(10; Month; Code[20])
        {
            Caption = 'Month';
            TableRelation = "Reference Data".Code where(Type = const(Month));
            Editable = false;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            Editable = false;

        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            Editable = false;
        }
        field(14; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = JGTDistributionCodeunit.GetFieldCaption(3, '');
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
            Editable = false;
        }
        field(15; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = JGTDistributionCodeunit.GetFieldCaption(4, '');
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
            Editable = false;
        }
        field(16; "Square Feets"; Decimal)
        {
            Caption = 'Square Feets';
            Editable = false;
        }
        field(17; "Project Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
        }
        field(18; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            Editable = false;
        }
        field(19; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(20; "Document No."; Text[100])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(21; "Account Category"; Enum "G/L Account Category")
        {
            Caption = 'Account Category';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Entry No.", "Line No.", "Company Name")
        {
            Clustered = true;
        }
        key(SourceCompany; "Company Name", "Entry No.", "Line No.")
        {
        }
    }
    var
        JGTDistributionCodeunit: Codeunit "JGT Distribution Codeunit";
}