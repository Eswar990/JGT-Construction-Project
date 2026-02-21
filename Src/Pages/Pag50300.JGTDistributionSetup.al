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
                    field("Previous Year"; Rec."Previous Year")
                    {
                        ToolTip = 'Specifies the value of the Previous Year field.', Comment = '%';
                    }
                    field("Previous Month"; Rec."Previous Month")
                    {
                        ToolTip = 'Specifies the value of the Previous Month field.', Comment = '%';
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
    actions
    {
        area(Processing)
        {
            // action("Copy From Previous Data")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     Image = CopyBudget;
            //     trigger OnAction()
            //     begin
            //         JGTDistributionCodeunit.CopyFromPreviousDetails(Rec.Year, Rec.Month, Rec."Previous Year", rec."Previous Month");
            //     end;
            // }
            action("Copy Previous Month Data")
            {
                ApplicationArea = All;
                Caption = 'Copy Previous Month Data';
                Image = Copy;
                ToolTip = 'Copy distribution data from previous month';

                trigger OnAction()
                var
                begin
                    // Call the copy procedure
                    JGTDistributionCodeunit.CopyFromPreviousMonth(Rec.Year, Rec.Month, Rec."Previous Year", Rec."Previous Month");
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.Year := '';
        Rec.Month := '';
        Rec."Previous Year" := '';
        Rec."Previous Month" := '';
        Rec.Modify();
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    var
        JGTDistributionCodeunit: Codeunit "JGT Distribution Codeunit";
}