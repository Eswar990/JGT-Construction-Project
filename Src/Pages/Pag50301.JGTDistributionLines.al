page 50301 "JGT Distribution Lines"
{
    ApplicationArea = All;
    Caption = 'JGT Distribution Lines';
    PageType = ListPart;
    SourceTable = "JGT Distribution Lines";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(Year; Rec.Year)
                {
                    ToolTip = 'Specifies the value of the Year field.', Comment = '%';
                }
                field(Month; Rec.Month)
                {
                    ToolTip = 'Specifies the value of the Month field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field("Shortcut DImension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut DImension 2 Code field.', Comment = '%';
                }
                field("Shortcut DImension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut DImension 3 Code field.', Comment = '%';
                }
                field("Shortcut DImension 4Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut DImension 4 Code field.', Comment = '%';
                }
                field("Square Feets"; Rec."Square Feets")
                {
                    ToolTip = 'Specifies the value of the Square Feets field.', Comment = '%';
                }
            }
        }
    }
}
