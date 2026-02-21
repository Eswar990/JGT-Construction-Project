// page 50308 "JGT Distribution Project API"
// {
//     PageType = API;
//     Caption = 'JGT Distribution Project API';
//     APIPublisher = 'jgt';
//     APIGroup = 'project';
//     APIVersion = 'v1.0';
//     EntityName = 'distributionProject';
//     EntitySetName = 'distributionProjects';
//     SourceTable = "JGT Distribution Project";
//     DelayedInsert = true;
//     ODataKeyFields = "Entry No.", "Line No.";

//     layout
//     {
//         area(Content)
//         {
//             field(entryNo; Rec."Entry No.")
//             {
//                 Caption = 'Entry No.';
//             }
//             field(projectAmount; Rec."Project Amount")
//             {
//                 Caption = 'Project Amount';
//             }
//             field(projectLine; Rec."Project Line")
//             {
//                 Caption = 'Project Line';
//             }
//             field(lineNo; Rec."Line No.")
//             {
//                 Caption = 'Line No.';
//             }
//             field(empCount; Rec."Emp. Count")
//             {
//                 Caption = 'Employee Count';
//             }
//             field(glAccountNo; Rec."G/L Account No.")
//             {
//                 Caption = 'G/L Account No.';
//             }
//             field(year; Rec.Year)
//             {
//                 Caption = 'Year';
//             }
//             field(month; Rec.Month)
//             {
//                 Caption = 'Month';
//             }
//             field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
//             {
//                 Caption = 'Shortcut Dimension 1 Code';
//             }
//             field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
//             {
//                 Caption = 'Shortcut Dimension 2 Code';
//             }
//             field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
//             {
//                 Caption = 'Shortcut Dimension 3 Code';
//             }
//             field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
//             {
//                 Caption = 'Shortcut Dimension 4 Code';
//             }
//             field(squareFeets; Rec."Square Feets")
//             {
//                 Caption = 'Square Feets';
//             }
//             field(projectTotalAmount; Rec."Project Total Amount")
//             {
//                 Caption = 'Project Total Amount';
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec.Insert(true);
//         exit(false);
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         Rec.Modify(true);
//         exit(false);
//     end;
// }