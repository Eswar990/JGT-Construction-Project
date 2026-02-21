page 50309 "JGT Distribution Project API"
{
    PageType = API;
    Caption = 'JGT Distribution Project API';
    APIPublisher = 'JGTProject';
    APIGroup = 'ConstructionProject';
    APIVersion = 'v1.0';
    EntityName = 'jgtDistributionProject';
    EntitySetName = 'jgtDistributionProjects';
    SourceTable = "JGT Distribution Project";
    DelayedInsert = true;
    // Using Entry No. and Line No. as composite key instead of SystemId
    ODataKeyFields = "Entry No.", "Line No.";
    Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;
    Extensible = false;
    Permissions = tabledata 50304 = RIMD;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    ApplicationArea = All;
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field(projectAmount; Rec."Project Amount")
                {
                    Caption = 'Project Amount';
                    ApplicationArea = All;
                }
                field(projectLine; Rec."Project Line")
                {
                    Caption = 'Project Line';
                    ApplicationArea = All;
                }
                field(empCount; Rec."Emp. Count")
                {
                    Caption = 'Emp. Count';
                    ApplicationArea = All;
                }
                field(gLAccountNo; Rec."G/L Account No.")
                {
                    Caption = 'G/L Account No.';
                    ApplicationArea = All;
                }
                field(year; Rec.Year)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                }
                field(month; Rec.Month)
                {
                    Caption = 'Month';
                    ApplicationArea = All;
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                    ApplicationArea = All;
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                    ApplicationArea = All;
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    Caption = 'Shortcut Dimension 3 Code';
                    ApplicationArea = All;
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    Caption = 'Shortcut Dimension 4 Code';
                    ApplicationArea = All;
                }
                field(squareFeets; Rec."Square Feets")
                {
                    Caption = 'Square Feets';
                    ApplicationArea = All;
                }
                field(projectTotalAmount; Rec."Project Total Amount")
                {
                    Caption = 'Project Total Amount';
                    ApplicationArea = All;
                }
                field(companyName; Rec."Company Name")
                {
                    Caption = 'Company Name';
                    ApplicationArea = All;
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = All;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field(accountCategory; Rec."Account Category")
                {
                    Caption = 'Account Category';
                    ApplicationArea = All;
                }
            }
        }
    }
}