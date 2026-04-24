report 50300 "JGT Distribution Analysis"
{
    ApplicationArea = All;
    Caption = 'JGT Distribution Analysis';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/50300.JGTDistributionAnalysis.rdl';
    dataset
    {
        dataitem(JGTDistributionProject; "JGT Distribution Project")
        {
            RequestFilterFields = "G/L Account No.", "Shortcut Dimension 1 Code", "Posting Date",
                 "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Document No.", "Company Name";
            trigger OnPreDataItem()
            begin
                CompInfo.Get();
                TxtFilter := GetFilters();
                Clear(GLEntry);
                GLEntry.SetFilter("G/L Account No.", GetFilter("G/L Account No."));
                GLEntry.SetFilter("Posting Date", GetFilter("Posting Date"));
                if GetFilter("Shortcut Dimension 1 Code") = '' then
                    GLEntry.SetRange("Global Dimension 1 Code", 'NA')
                else
                    GLEntry.SetFilter("Global Dimension 1 Code", GetFilter("Shortcut Dimension 1 Code"));
                if GLEntry.FindFirst() then
                    repeat
                        if GLEntry."Credit Amount" <> 0 then
                            InitGLEntryTemp();
                    until GLEntry.Next() = 0;
            end;

            trigger OnAfterGetRecord()
            begin
                if "G/L Account No." = '' then
                    CurrReport.Skip();
                if "Shortcut Dimension 1 Code" = '' then
                    CurrReport.Skip();
                InitDistributiomRuleTemp();
            end;

            trigger OnPostDataItem()
            begin
                Clear(TempJGTDistRule);
                TempJGTDistRule.SetCurrentKey("G/L Account No.", "Posting Date",
                    "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", "Document No.", "Entry No.", "Company Name");
            end;
        }
        dataitem(IntegerLoop; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(TxtFilter; TxtFilter)
            {

            }
            column(CompInfoName; CompInfo.Name)
            {

            }
            column(TempDistRuleGLAccNo; TempJGTDistRule."G/L Account No.")
            {

            }
            column(GLAccName; GLAccName)
            {

            }
            column(Posting_Date; TempJGTDistRule."Posting Date")
            {

            }
            column(TempDistRuleDoc; TempJGTDistRule."Document No.")
            {

            }
            column(TempDistBranchCode; TempJGTDistRule."Shortcut Dimension 1 Code")
            {

            }
            column(EmpName; EmpName)
            {

            }
            column(TempDistProjectCode; TempJGTDistRule."Shortcut Dimension 2 Code")
            {

            }
            column(TempDistPhase; TempJGTDistRule."Shortcut Dimension 3 Code")
            {

            }
            column(TempDistRuleDebit; DebitAmountAllocated)
            {

            }
            column(TempDistRuleCredit; CreditAmountAllocated)
            {

            }
            column(TempDistRuleEntryNo; TempJGTDistRule."Entry No.")
            {

            }
            column(TempDistUnitsCode; TempJGTDistRule."Shortcut Dimension 4 Code")
            {

            }
            column(SquareFeets; TempJGTDistRule."Square Feets")
            {

            }
            column(TempDistRuleManagerName; TempDistRuleManagerName)
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }
            column(DebitAmountAllocated2; DebitAmountAllocated2)
            {

            }
            column(CreditAmountAllocated2; CreditAmountAllocated2)
            {

            }
            column(CompanyName; TempJGTDistRule."Company Name")
            {

            }
            trigger OnAfterGetRecord()
            var
                DimValue: Record "Dimension Value";
                JGTDistributionRules: Record "JGT Distribution Project";
            begin
                Clear(GLAccName);
                Clear(EmpName);
                if Number = 1 then begin
                    if (TempJGTDistRule.FindSet(false) = false) then
                        CurrReport.Break();
                end else
                    if (TempJGTDistRule.Next() = 0) then
                        CurrReport.Break();

                Clear(GLEntry);
                Clear(GLAccName);
                Clear(DebitAmountAllocated);
                Clear(CreditAmountAllocated);

                GLAccount.Get(TempJGTDistRule."G/L Account No.");
                GLAccName := GLAccount.Name;
                DimValue.Get('BRANCH', TempJGTDistRule."Shortcut Dimension 1 Code");
                EmpName := DimValue.Name;
                JGTDistributionRules.SetRange("Entry No.", TempJGTDistRule."Entry No.");
                JGTDistributionRules.SetRange("Shortcut Dimension 1 Code", TempJGTDistRule."Shortcut Dimension 1 Code");
                JGTDistributionRules.SetRange("Shortcut Dimension 2 Code", TempJGTDistRule."Shortcut Dimension 2 Code");
                JGTDistributionRules.SetRange("Shortcut Dimension 3 Code", TempJGTDistRule."Shortcut Dimension 3 Code");
                JGTDistributionRules.SetRange("Shortcut Dimension 4 Code", TempJGTDistRule."Shortcut Dimension 4 Code");
                JGTDistributionRules.SetRange("Company Name", TempJGTDistRule."Company Name");
                JGTDistributionRules.FindFirst();
                // if (((JGTDistributionRules."Account Category"::Expense) = JGTDistributionRules."Account Category") or (JGTDistributionRules."Account Category"::Assets = JGTDistributionRules."Account Category")) then begin
                //     DebitAmountAllocated := JGTDistributionRules."Project Amount";
                // end;

                // if ((JGTDistributionRules."Account Category"::Income) = JGTDistributionRules."Account Category") then begin
                //     CreditAmountAllocated := JGTDistributionRules."Project Amount";
                // end;

                if (((JGTDistributionRules."Account Category"::Expense) = JGTDistributionRules."Account Category") or
                (JGTDistributionRules."Account Category"::Assets = JGTDistributionRules."Account Category")) then begin
                    DebitAmountAllocated := JGTDistributionRules."Project Amount";
                end;

                if ((JGTDistributionRules."Account Category"::Income) = JGTDistributionRules."Account Category") then begin
                    CreditAmountAllocated := JGTDistributionRules."Project Amount";
                end;

                TotalAmount += CreditAmountAllocated2 - DebitAmountAllocated2;
                // TotalAmount += CreditAmountAllocated - DebitAmountAllocated;
            end;
        }
    }

    local procedure InitGLEntryTemp()
    begin
        Inx += 1;
        Clear(TempJGTDistRule);
        TempJGTDistRule."Entry No." := GLEntry."Entry No.";
        TempJGTDistRule."Line No." := Inx;
        TempJGTDistRule."G/L Account No." := GLEntry."G/L Account No.";
        TempJGTDistRule."Posting Date" := GLEntry."Posting Date";
        TempJGTDistRule."Document No." := GLEntry."Document No.";
        TempJGTDistRule."Shortcut Dimension 1 Code" := GLEntry."Global Dimension 1 Code";
        TempJGTDistRule."Shortcut Dimension 2 Code" := GLEntry."Global Dimension 2 Code";
        TempJGTDistRule."Shortcut Dimension 3 Code" := GLEntry."Shortcut Dimension 3 Code";
        TempJGTDistRule."Project Amount" := GLEntry."Credit Amount";
        TempJGTDistRule.Insert(false);
    end;

    local procedure InitDistributiomRuleTemp()
    var
        DistributionLine: Record "JGT Distribution Lines";
        DimensionValue: Record "Dimension Value";
        TeamleaderNoAndNameInsStr, ManagerNoAndNameInsStr : Text;
        TeamleaderNoStrLen, TeamleaderNoStrLenInc, ManagerNoStrLen, ManagerNoStrLenInc : Integer;
    begin
        Inx += 1;
        Clear(TempJGTDistRule);
        Clear(CreditAmountAllocated);
        Clear(DebitAmountAllocated);
        Clear(TeamleaderNoAndNameInsStr);
        Clear(ManagerNoAndNameInsStr);
        Clear(TeamleaderNoStrLen);
        Clear(TeamleaderNoStrLenInc);
        Clear(ManagerNoStrLen);
        Clear(ManagerNoStrLenInc);
        TempJGTDistRule."Entry No." := JGTDistributionProject."Entry No.";
        TempJGTDistRule."Line No." := Inx;
        TempJGTDistRule."G/L Account No." := JGTDistributionProject."G/L Account No.";
        TempJGTDistRule."Posting Date" := JGTDistributionProject."Posting Date";
        TempJGTDistRule."Document No." := JGTDistributionProject."Document No.";
        TempJGTDistRule."Shortcut Dimension 1 Code" := JGTDistributionProject."Shortcut Dimension 1 Code";
        TempJGTDistRule."Shortcut Dimension 2 Code" := JGTDistributionProject."Shortcut Dimension 2 Code";
        TempJGTDistRule."Shortcut Dimension 3 Code" := JGTDistributionProject."Shortcut Dimension 3 Code";
        TempJGTDistRule."Shortcut Dimension 4 Code" := JGTDistributionProject."Shortcut Dimension 4 Code";
        TempJGTDistRule."Square Feets" := JGTDistributionProject."Square Feets";
        TempJGTDistRule."Company Name" := JGTDistributionProject."Company Name";
        TempJGTDistRule."Account Category" := JGTDistributionProject."Account Category";
        if ((TempJGTDistRule."Account Category"::Expense) = JGTDistributionProject."Account Category") or (TempJGTDistRule."Account Category"::Assets = JGTDistributionProject."Account Category") then begin
            DebitAmountAllocated2 += JGTDistributionProject."Project Amount"
        end else
            CreditAmountAllocated2 += JGTDistributionProject."Project Amount";

        TempJGTDistRule.Insert(false);
        Commit();
    end;

    var
        CompInfo: Record "Company Information";
        GLEntry: Record "G/L Entry";
        GLAccount: Record "G/L Account";
        TempJGTDistRule: Record "JGT Distribution Project" temporary;
        DebitAmountAllocated: Decimal;
        CreditAmountAllocated: Decimal;
        DebitAmountAllocated2: Decimal;
        CreditAmountAllocated2: Decimal;
        TxtFilter, DistributionYear, DistributionMonth : Text;
        EmpName: Text[100];
        GLAccName: Text[100];
        Inx: Integer;
        TotalAmount: Decimal;
        TempDistRuleteamleaderName: Text[100];
        TempDistRuleManagerName: Text[100];
}