table 50301 "JGT Distribution Lines"
{
    Caption = 'JGT Distribution Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Year; Code[20])
        {
            Caption = 'Year';
            TableRelation = "Reference Data".Code where(Type = const(Year));
        }
        field(2; Month; Code[20])
        {
            Caption = 'Month';
            TableRelation = "Reference Data".Code where(Type = const(Month));
        }
        field(8; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            // Editable = false;

        }
        field(4; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            // Editable = false;
        }
        field(5; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = JGTDistributionCodeunit.GetFieldCaption(3, '');
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          Blocked = CONST(false));
            // Editable = false;
        }
        field(6; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = JGTDistributionCodeunit.GetFieldCaption(4, '');
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                          Blocked = CONST(false));
            // Editable = false;
        }
        field(7; "Square Feets"; Decimal)
        {
            Caption = 'Square Feets';
            // Editable = false;
        }
        field(9; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Year, Month, "Line No.", "Shortcut Dimension 1 Code")
        {
            Clustered = true;
        }
        key(PK1; "Shortcut Dimension 2 Code")
        {

        }
        key(PK2; "Shortcut Dimension 3 Code")
        {

        }
        key(PK3; "Shortcut Dimension 4 Code")
        {

        }
    }
    var
        JGTDistributionCodeunit: Codeunit "JGT Distribution Codeunit";
}