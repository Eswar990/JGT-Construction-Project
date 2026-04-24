page 50305 "JGT Distribution Project"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'JGTDistribution Project';
    PageType = Listpart;
    SourceTable = "JGT Distribution Project";
    SourceTableView = sorting("Entry No.");
    DelayedInsert = true;
    AutoSplitKey = true;
    MultipleNewLines = true;
    LinksAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
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
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    Editable = false;
                }

                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                    Editable = false;
                }
                field("Shortcut DImension 4Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut DImension 4 Code field.', Comment = '%';
                }
                field("Emp. Count"; Rec."Emp. Count")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    Visible = false;
                }
                field("Square Feets"; Rec."Square Feets")
                {
                    ToolTip = 'Specifies the value of the Amount Allocated field.';
                }
                field("Project Amount"; Rec."Project Amount")
                {
                    ToolTip = 'Specifies the value of the Amount Allocated field.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.';
                }

                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the Line value of Distribution Project';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Account Category"; Rec."Account Category")
                {
                    ToolTip = 'Specifies the value of the Account Category field.';
                }
            }
            group("Allocation Details")
            {
                ShowCaption = false;
                field("Project Total Amount"; Rec."Project Total Amount")
                {
                    Caption = 'Project Total Amount';
                    ToolTip = 'Specifies the value of the Total Amount Field';
                    Style = Strong;
                    visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Branch Distributions")
            {
                ApplicationArea = All;
                Image = AmountByPeriod;
                Visible = IsVisibleBranchDistributions;
                ToolTip = 'Specifies the Value When you click Branch Distributions Action after Create the Project Lines';
                trigger OnAction()
                begin
                    UserCustomizeManage.DistributeAmountbasedOnBranch(Rec."Entry No.");
                end;
            }
            action("Allocation Employee Amount Upload")
            {
                ApplicationArea = All;
                Image = UpdateXML;
                trigger OnAction()
                var
                    DisRuleFilter: Record "JGT Distribution Rule Filter";
                    JGTDistributionProject: Record "JGT Distribution Project";
                    GLEntry: Record "G/L Entry";
                    UserCustManage: Codeunit "JGT Distribution Codeunit";
                begin
                    IsVisibleBranchDistributions := false;
                    JGTDistributionProject.Copy(Rec);
                    If (DisRuleFilter.Get(Rec."Entry No.") = false) then
                        exit;
                    if ((DisRuleFilter."Dimension Value One" <> '') and (DisRuleFilter."Distribution Amount One" = 0)) then
                        Error('Distribution Amount One %1 Must not be Zero Please add Value', DisRuleFilter."Distribution Amount One")
                    else
                        if ((DisRuleFilter."Dimension Value Two" <> '') and (DisRuleFilter."Distribution Amount Two" = 0)) then
                            Error('Distribution Amount Two %1 Must not be Zero Please add Value', DisRuleFilter."Distribution Amount Two")
                        else
                            if ((DisRuleFilter."Dimension Value Three" <> '') and (DisRuleFilter."Distribution Amount Three" = 0)) then
                                Error('Distribution Amount Three %1 Must not be Zero Please add Value', DisRuleFilter."Distribution Amount Three")
                            else
                                if ((DisRuleFilter."Dimension Value Four" <> '') and (DisRuleFilter."Distribution Amount Four" = 0)) then
                                    Error('Distribution Amount Four %1 Must not be Zero Please add Value', DisRuleFilter."Distribution Amount Four")
                                else
                                    if ((DisRuleFilter."Dimension Value Five" <> '') and (DisRuleFilter."Distribution Amount Five" = 0)) then
                                        Error('Distribution Amount Five %1 Must not be Zero Please add Value', DisRuleFilter."Distribution Amount Five")
                                    else
                                        UserCustManage.UploadDistributionProjectFromExcel(JGTDistributionProject);

                    GLEntry.Get(Rec."Entry No.");
                    CalRemAmount(GLEntry);
                    if RemAmount = 0 then
                        UserCustManage.TrueUpdateGLEntryDistributioRuleApplied(GLEntry."Entry No.", GLEntry."Document No.", DisRuleFilter."Dimension Value",
                             GLEntry."Global Dimension 1 Code", DisRuleFilter."G/L Account No.", GLEntry."VAT Bus. Posting Group", GLEntry."VAT Prod. Posting Group", GLEntry."Gen. Bus. Posting Group", GLEntry."Gen. Prod. Posting Group");
                    CurrPage.Update(true);
                end;

            }

            // action("Single Line Amount Updated")
            // {
            //     ApplicationArea = All;
            //     Image = Balance;

            //     trigger OnAction()
            //     var
            //         GLEntry: Record "G/L Entry";
            //         DistributionRuleFilter: Record "JGT Distribution Rule Filter";
            //     begin
            //         if (DistributionRuleFilter.Get(Rec."Entry No.") = true) then
            //             if (DistributionRuleFilter."Dist Single Line Amount" = true) then
            //                 UserCustomizeManage.InDistributionRuleAmountShouldBeUpdatedOnSingleLine(Rec)
            //             else
            //                 Error('Distribution Single Line Amount must be True');

            //         if (GLEntry.Get(Rec."Entry No.") = false) then
            //             exit;

            //         CalRemAmount(GLEntry);
            //     end;
            // }
        }
    }
    trigger OnOpenPage()
    begin
        IsVisibleBranchDistributions := true;
    end;

    local procedure CalRemAmount(GLEntry: Record "G/L Entry")
    var
        DistributionRule: Record "JGT Distribution Rule";
        JGTDistributionProject: Record "JGT Distribution Project";
    begin
        Clear(JGTDistributionProject);
        JGTDistributionProject.SetRange("Entry No.", GLEntry."Entry No.");
        JGTDistributionProject.CalcSums("Project Amount");
        Amount := JGTDistributionProject."Project Amount";
        Clear(DistributionRule);
        DistributionRule.SetRange("Entry No.", GLEntry."Entry No.");
        DistributionRule.CalcSums("Amount Allocated");
        RemAmount := Amount - DistributionRule."Amount Allocated";
    end;

    procedure DistributeAmountbasedOnBranch(GLEntryNo: Integer)
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        DistributionRuleFilter: Record "JGT Distribution Rule Filter";
        DistributionProjectAmount: Decimal;
        DistEmployee: Integer;
    begin
        // Amount should be Distributed based on Employee Count
        JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
        if (JGTDistributionProject.FindSet(false) = true) then begin
            Clear(EmployeeCount2);
            repeat
                EmployeeCount2 += JGTDistributionProject."Emp. Count";
            until JGTDistributionProject.Next() = 0;
        end;

        DistributionRuleFilter.Get(GLEntryNo);
        JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
        if (JGTDistributionProject.FindSet(false) = true) then
            repeat
                JGTDistributionProject."Project Amount" := Round(DistributionRuleFilter."Distribution Amount" / EmployeeCount2, 0.01);
                JGTDistributionProject.Modify(false);
            until JGTDistributionProject.Next() = 0;

        if ((DistributionRuleFilter."Distribution Amount One" = 0) and (DistributionRuleFilter."Dimension Value One" <> '')) then begin
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value One");
            Clear(DistributionProjectAmount);
            if (JGTDistributionProject.FindSet(false) = true) then
                repeat
                    DistributionProjectAmount += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            DistributionRuleFilter."Distribution Amount One" := DistributionProjectAmount;
            DistributionRuleFilter.Modify(false);
        end;

        if ((DistributionRuleFilter."Distribution Amount Two" = 0) and (DistributionRuleFilter."Dimension Value Two" <> '')) then begin
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Two");
            Clear(DistributionProjectAmount);
            if (JGTDistributionProject.FindSet(false) = true) then
                repeat
                    DistributionProjectAmount += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            DistributionRuleFilter."Distribution Amount Two" := DistributionProjectAmount;
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value One");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount One");
                repeat
                    DistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            DistributionRuleFilter.Modify(false);
        end;

        if ((DistributionRuleFilter."Distribution Amount Three" = 0) and (DistributionRuleFilter."Dimension Value Three" <> '')) then begin
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Three");
            Clear(DistributionProjectAmount);
            if (JGTDistributionProject.FindSet(false) = true) then
                repeat
                    DistributionProjectAmount += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            DistributionRuleFilter."Distribution Amount Three" := DistributionProjectAmount;
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value One");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount One");
                repeat
                    DistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            end;
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Two");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Two");
                repeat
                    DistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            DistributionRuleFilter.Modify(false);
        end;

        if ((DistributionRuleFilter."Distribution Amount Four" = 0) and (DistributionRuleFilter."Dimension Value Four" <> '')) then begin
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Four");
            Clear(DistributionProjectAmount);
            if (JGTDistributionProject.FindSet(false) = true) then
                repeat
                    DistributionProjectAmount += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            DistributionRuleFilter."Distribution Amount Four" := DistributionProjectAmount;
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value One");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount One");
                repeat
                    DistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Two");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Two");
                repeat
                    DistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Three");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Three");
                repeat
                    DistributionRuleFilter."Distribution Amount Three" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            DistributionRuleFilter.Modify(false);
        end;

        if ((DistributionRuleFilter."Distribution Amount Five" = 0) and (DistributionRuleFilter."Dimension Value Five" <> '')) then begin
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Five");
            Clear(DistributionProjectAmount);
            if (JGTDistributionProject.FindSet(false) = true) then
                repeat
                    DistributionProjectAmount += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;

            DistributionRuleFilter."Distribution Amount Five" := DistributionProjectAmount;
            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value One");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount One");
                repeat
                    DistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Two");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Two");
                repeat
                    DistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Three");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Three");
                repeat
                    DistributionRuleFilter."Distribution Amount Three" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DistributionRuleFilter."Dimension Value Four");
            if (JGTDistributionProject.FindSet(false) = true) then begin
                Clear(DistributionRuleFilter."Distribution Amount Four");
                repeat
                    DistributionRuleFilter."Distribution Amount Four" += JGTDistributionProject."Project Amount";
                until JGTDistributionProject.Next() = 0;
            end;

            DistributionRuleFilter.Modify(false);
        end;
    end;

    var
        UserCustomizeManage: Codeunit "JGT Distribution Codeunit";
        Amount: Decimal;
        RemAmount: Decimal;
        IsVisibleBranchDistributions: Boolean;
        EmployeeCount2: Decimal;
}