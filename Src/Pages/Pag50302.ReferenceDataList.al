page 50302 "Reference Data List"
{
    ApplicationArea = All;
    Caption = 'JGT Reference Data List';
    PageType = List;
    SourceTable = "Reference Data";
    UsageCategory = None;
    SourceTableView = sorting("Sorting Value");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Sorting Value"; Rec."Sorting Value")
                {
                    ToolTip = 'Specifies the value of the Sorting Value field.', Comment = '%';
                }
            }
        }
    }
}
