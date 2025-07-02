page 50300 "JGT Distribution Setup"
{
    ApplicationArea = All;
    Caption = 'JGT Distribution Setup';
    PageType = Card;
    SourceTable = "JGT Distribution Header";
    InsertAllowed = false;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                group(From)
                {
                    field("Previous Month"; Rec."Previous Month")
                    {
                        ToolTip = 'Specifies the value of the Previous Month field.', Comment = '%';
                    }
                    field("Previous Year"; Rec."Previous Year")
                    {
                        ToolTip = 'Specifies the value of the Previous Year field.', Comment = '%';
                    }
                }
                group(To)
                {
                    field(Year; Rec.Year)
                    {
                        ToolTip = 'Specifies the value of the Year field.', Comment = '%';
                    }
                    field(Month; Rec.Month)
                    {
                        ToolTip = 'Specifies the value of the Month field.', Comment = '%';
                    }
                }
            }
            part(Lines; "JGT Distribution Lines")
            {
                Caption = 'Lines';
                SubPageLink = Year = field(Year), Month = field(Month);
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}