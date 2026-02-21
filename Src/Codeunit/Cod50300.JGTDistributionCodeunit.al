codeunit 50300 "JGT Distribution Codeunit"
{
    Permissions = tabledata "G/L Entry" = IMD;
    procedure GetFieldCaption(Inx: Integer; FieldNoTxt: Text): Text[100]

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dim: Record Dimension;
    begin
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("Shortcut Dimension 3 Code");
        if (Inx = 3) then
            if Dim.Get(GeneralLedgerSetup."Shortcut Dimension 3 Code") then
                if FieldNoTxt = '' then
                    exit(Dim.Name)
                else
                    exit(Dim.Name + ' ' + FieldNoTxt);

        if (Inx = 4) then
            if Dim.Get(GeneralLedgerSetup."Shortcut Dimension 4 Code") then
                exit(Dim.Name);

        if (Inx = 5) then
            if Dim.Get(GeneralLedgerSetup."Shortcut Dimension 5 Code") then
                exit(Dim.Name);
    end;

    // procedure CopyFromPreviousDetails(Year: Code[20]; Month: Code[20]; PreYear: Code[20]; PreMonth: Code[20])
    // var
    //     FromJGTDistributionLine: Record "JGT Distribution Lines";
    //     ToJGTDistributionLine: Record "JGT Distribution Lines";
    //     DimensionValue: Record "Dimension Value";
    //     TotalPercentage: Decimal;
    //     DimensionError: Boolean;
    // begin
    //     if not Confirm('Do you want to copy employee details from previous year and month?', false) then
    //         exit;

    //     // Check source records exist
    //     FromJGTDistributionLine.SetRange(Year, PreYear);
    //     FromJGTDistributionLine.SetRange(Month, PreMonth);
    //     if not FromJGTDistributionLine.FindSet() then
    //         Error('Employee details not found for previous year %1 and month %2', PreYear, PreMonth);

    //     // Clear destination records
    //     ToJGTDistributionLine.SetRange(Year, Year);
    //     ToJGTDistributionLine.SetRange(Month, Month);
    //     if ToJGTDistributionLine.FindSet() then
    //         ToJGTDistributionLine.DeleteAll();

    //     // Copy records with validation
    //     repeat
    //         // Validate dimension values exist before copying
    //         DimensionError := false;

    //         if FromJGTDistributionLine."Shortcut Dimension 1 Code" <> '' then
    //             if not DimensionValue.Get(GetDimensionCode(1), FromJGTDistributionLine."Shortcut Dimension 1 Code") then
    //                 DimensionError := true;

    //         if FromJGTDistributionLine."Shortcut Dimension 2 Code" <> '' then
    //             if not DimensionValue.Get(GetDimensionCode(2), FromJGTDistributionLine."Shortcut Dimension 2 Code") then
    //                 DimensionError := true;

    //         if FromJGTDistributionLine."Shortcut Dimension 3 Code" <> '' then
    //             if not DimensionValue.Get(GetDimensionCode(3), FromJGTDistributionLine."Shortcut Dimension 3 Code") then
    //                 DimensionError := true;
    //         if FromJGTDistributionLine."Shortcut Dimension 4 Code" <> '' then
    //             if not DimensionValue.Get(GetDimensionCode(4), FromJGTDistributionLine."Shortcut Dimension 4 Code") then
    //                 DimensionError := true;

    //         if DimensionError then
    //             Error('One or more dimension values for employee %1 do not exist in the Dimension Value table',
    //                   FromJGTDistributionLine."Shortcut Dimension 1 Code");

    //         // Initialize new record
    //         Clear(ToJGTDistributionLine);
    //         ToJGTDistributionLine.Init();
    //         ToJGTDistributionLine.Validate(Year, Year);
    //         ToJGTDistributionLine.Validate(Month, Month);

    //         // Copy and validate fields
    //         ToJGTDistributionLine.Validate("Line No.", FromJGTDistributionLine."Line No.");
    //         CopyDimensionWithValidation(ToJGTDistributionLine."Shortcut Dimension 1 Code", FromJGTDistributionLine."Shortcut Dimension 1 Code", 1);
    //         CopyDimensionWithValidation(ToJGTDistributionLine."Shortcut Dimension 2 Code", FromJGTDistributionLine."Shortcut Dimension 2 Code", 2);
    //         CopyDimensionWithValidation(ToJGTDistributionLine."Shortcut Dimension 3 Code", FromJGTDistributionLine."Shortcut Dimension 3 Code", 3);
    //         CopyDimensionWithValidation(ToJGTDistributionLine."Shortcut Dimension 4 Code", FromJGTDistributionLine."Shortcut Dimension 4 Code", 4);
    //         ToJGTDistributionLine.Validate("Square Feets", FromJGTDistributionLine."Square Feets");
    //         ToJGTDistributionLine.Insert(true);
    //     until FromJGTDistributionLine.Next() = 0;

    //     Message('Copy from employee details completed.');
    // end;
    // procedure CopyFromPreviousDetails(Year: Code[20]; Month: Code[20]; PreYear: Code[20]; PreMonth: Code[20])
    // var
    //     FromJGTDistributionLine: Record "JGT Distribution Lines";
    //     ToJGTDistributionLine: Record "JGT Distribution Lines";
    //     DimensionValue: Record "Dimension Value";
    //     GLSetup: Record "General Ledger Setup";
    //     TotalPercentage: Decimal;
    //     DimensionError: Boolean;
    //     DimCode1: Code[20];
    //     DimCode2: Code[20];
    //     DimCode3: Code[20];
    //     DimCode4: Code[20];
    // begin
    //     if not Confirm('Do you want to copy employee details from previous year and month?', false) then
    //         exit;

    //     // Get dimension codes from GL Setup
    //     if not GLSetup.Get() then
    //         Error('General Ledger Setup not found.');

    //     DimCode1 := GLSetup."Shortcut Dimension 1 Code";
    //     DimCode2 := GLSetup."Shortcut Dimension 2 Code";
    //     DimCode3 := GLSetup."Shortcut Dimension 3 Code";
    //     DimCode4 := GLSetup."Shortcut Dimension 4 Code";

    //     // Check source records exist
    //     FromJGTDistributionLine.SetRange(Year, PreYear);
    //     FromJGTDistributionLine.SetRange(Month, PreMonth);
    //     if not FromJGTDistributionLine.FindSet() then
    //         Error('Employee details not found for previous year %1 and month %2', PreYear, PreMonth);

    //     // Clear destination records
    //     ToJGTDistributionLine.SetRange(Year, Year);
    //     ToJGTDistributionLine.SetRange(Month, Month);
    //     if ToJGTDistributionLine.FindSet() then
    //         ToJGTDistributionLine.DeleteAll();

    //     // Copy records with validation
    //     repeat
    //         // Validate dimension values exist before copying
    //         DimensionError := false;

    //         if FromJGTDistributionLine."Shortcut Dimension 1 Code" <> '' then
    //             if not DimensionValue.Get(DimCode1, FromJGTDistributionLine."Shortcut Dimension 1 Code") then
    //                 DimensionError := true;

    //         if FromJGTDistributionLine."Shortcut Dimension 2 Code" <> '' then
    //             if not DimensionValue.Get(DimCode2, FromJGTDistributionLine."Shortcut Dimension 2 Code") then
    //                 DimensionError := true;

    //         if FromJGTDistributionLine."Shortcut Dimension 3 Code" <> '' then
    //             if not DimensionValue.Get(DimCode3, FromJGTDistributionLine."Shortcut Dimension 3 Code") then
    //                 DimensionError := true;

    //         if FromJGTDistributionLine."Shortcut Dimension 4 Code" <> '' then
    //             if not DimensionValue.Get(DimCode4, FromJGTDistributionLine."Shortcut Dimension 4 Code") then
    //                 DimensionError := true;

    //         if DimensionError then
    //             Error('One or more dimension values for employee %1 do not exist in the Dimension Value table.\\' +
    //                   'Dim1: %2 (%3)\\Dim2: %4 (%5)\\Dim3: %6 (%7)\\Dim4: %8 (%9)',
    //                   FromJGTDistributionLine."Shortcut Dimension 1 Code",
    //                   FromJGTDistributionLine."Shortcut Dimension 1 Code", DimCode1,
    //                   FromJGTDistributionLine."Shortcut Dimension 2 Code", DimCode2,
    //                   FromJGTDistributionLine."Shortcut Dimension 3 Code", DimCode3,
    //                   FromJGTDistributionLine."Shortcut Dimension 4 Code", DimCode4);

    //         // Initialize new record
    //         Clear(ToJGTDistributionLine);
    //         ToJGTDistributionLine.Init();
    //         ToJGTDistributionLine.Validate(Year, Year);
    //         ToJGTDistributionLine.Validate(Month, Month);
    //         ToJGTDistributionLine."Line No." := FromJGTDistributionLine."Line No.";

    //         // Copy dimension values directly (no validation to avoid errors)
    //         ToJGTDistributionLine."Shortcut Dimension 1 Code" := FromJGTDistributionLine."Shortcut Dimension 1 Code";
    //         ToJGTDistributionLine."Shortcut Dimension 2 Code" := FromJGTDistributionLine."Shortcut Dimension 2 Code";
    //         ToJGTDistributionLine."Shortcut Dimension 3 Code" := FromJGTDistributionLine."Shortcut Dimension 3 Code";
    //         ToJGTDistributionLine."Shortcut Dimension 4 Code" := FromJGTDistributionLine."Shortcut Dimension 4 Code";
    //         ToJGTDistributionLine."Square Feets" := FromJGTDistributionLine."Square Feets";

    //         if not ToJGTDistributionLine.Insert(true) then
    //             Error('Error inserting record: %1', GetLastErrorText());
    //     until FromJGTDistributionLine.Next() = 0;

    //     Message('Copy from employee details completed. Copied %1 records.', FromJGTDistributionLine.Count);
    // end;

    // local procedure CopyDimensionWithValidation(var ToField: Code[20]; FromField: Code[20]; DimensionNo: Integer)
    // var
    //     DimensionValue: Record "Dimension Value";
    // begin
    //     if FromField = '' then begin
    //         ToField := '';
    //         exit;
    //     end;

    //     if not DimensionValue.Get(GetDimensionCode(DimensionNo), FromField) then
    //         Error('Dimension value %1 does not exist for dimension %2', FromField, GetDimensionCode(DimensionNo));

    //     ToField := FromField;
    // end;

    // local procedure GetDimensionCode(DimensionNo: Integer): Code[20]
    // var
    //     GLSetup: Record "General Ledger Setup";
    // begin
    //     GLSetup.Get();
    //     case DimensionNo of
    //         1:
    //             exit(GLSetup."Shortcut Dimension 1 Code");
    //         2:
    //             exit(GLSetup."Shortcut Dimension 2 Code");
    //         3:
    //             exit(GLSetup."Shortcut Dimension 3 Code");
    //         4:
    //             exit(GLSetup."Shortcut Dimension 4 Code");
    //     end;
    // end;

    procedure CopyFromPreviousMonth(Year: Code[20]; Month: Code[20]; PreYear: Code[20]; PreMonth: Code[20])
    var
        FromJGTDistributionLine: Record "JGT Distribution Lines";
        ToJGTDistributionLine: Record "JGT Distribution Lines";
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        LineNo: Integer;
    begin
        if not Confirm('Do you want to copy data from %1 %2 to %3 %4?', false, PreMonth, PreYear, Month, Year) then
            exit;

        // Get dimension codes from GL Setup
        if not GLSetup.Get() then
            Error('General Ledger Setup not found.');

        // Check if source data exists
        FromJGTDistributionLine.SetRange(Year, PreYear);
        FromJGTDistributionLine.SetRange(Month, PreMonth);
        if not FromJGTDistributionLine.FindSet() then
            Error('No data found for %1 %2', PreMonth, PreYear);

        // Delete existing data for target period
        ToJGTDistributionLine.SetRange(Year, Year);
        ToJGTDistributionLine.SetRange(Month, Month);
        if not ToJGTDistributionLine.IsEmpty() then
            if not Confirm('Delete existing data for %1 %2?', false, Month, Year) then
                exit
            else
                ToJGTDistributionLine.DeleteAll();

        // Get the next available Line No.
        if ToJGTDistributionLine.FindLast() then
            LineNo := ToJGTDistributionLine."Line No." + 10000
        else
            LineNo := 10000;

        // Copy records
        repeat
            Clear(ToJGTDistributionLine);
            ToJGTDistributionLine.Init();

            // Set primary key fields
            ToJGTDistributionLine.Year := Year;
            ToJGTDistributionLine.Month := Month;
            ToJGTDistributionLine."Line No." := LineNo;
            LineNo := LineNo + 10000;

            // // Copy dimension values
            // ToJGTDistributionLine."Shortcut Dimension 1 Code" := FromJGTDistributionLine."Shortcut Dimension 1 Code";
            // ToJGTDistributionLine."Shortcut Dimension 2 Code" := FromJGTDistributionLine."Shortcut Dimension 2 Code";
            // ToJGTDistributionLine."Shortcut Dimension 3 Code" := FromJGTDistributionLine."Shortcut Dimension 3 Code";
            // ToJGTDistributionLine."Shortcut Dimension 4 Code" := FromJGTDistributionLine."Shortcut Dimension 4 Code";

            // Copy dimension values with validation
            ValidateDimensionValue(FromJGTDistributionLine."Shortcut Dimension 1 Code", GetDimensionCode(1), 1);
            ValidateDimensionValue(FromJGTDistributionLine."Shortcut Dimension 2 Code", GetDimensionCode(2), 2);
            ValidateDimensionValue(FromJGTDistributionLine."Shortcut Dimension 3 Code", GetDimensionCode(3), 3);
            ValidateDimensionValue(FromJGTDistributionLine."Shortcut Dimension 4 Code", GetDimensionCode(4), 4);

            ToJGTDistributionLine."Shortcut Dimension 1 Code" := FromJGTDistributionLine."Shortcut Dimension 1 Code";
            ToJGTDistributionLine."Shortcut Dimension 2 Code" := FromJGTDistributionLine."Shortcut Dimension 2 Code";
            ToJGTDistributionLine."Shortcut Dimension 3 Code" := FromJGTDistributionLine."Shortcut Dimension 3 Code";
            ToJGTDistributionLine."Shortcut Dimension 4 Code" := FromJGTDistributionLine."Shortcut Dimension 4 Code";


            // Copy other fields
            ToJGTDistributionLine."Square Feets" := FromJGTDistributionLine."Square Feets";
            ToJGTDistributionLine."Company Name" := FromJGTDistributionLine."Company Name";

            // Insert the record
            if not ToJGTDistributionLine.Insert(true) then
                Error('Error copying record: %1', GetLastErrorText());

        until FromJGTDistributionLine.Next() = 0;

        Message('Successfully copied %1 records from %2 %3 to %4 %5',
                FromJGTDistributionLine.Count, PreMonth, PreYear, Month, Year);
    end;

    local procedure ValidateDimensionValue(DimValueCode: Code[20]; DimCode: Code[20]; DimNo: Integer)
    var
        DimValue: Record "Dimension Value";
    begin
        if DimValueCode = '' then
            exit; // nothing to check

        DimValue.SetRange("Dimension Code", DimCode);
        DimValue.SetRange(Code, DimValueCode);
        if (DimValue.FindFirst() = false) then
            Error('Dimension Value %1 not found for Dimension %2 (Shortcut Dimension %3).',
                  DimValueCode, DimCode, DimNo);

        if not DimValue.Blocked then
            exit;

        Error('Dimension Value %1 for Dimension %2 is blocked and cannot be used (Shortcut Dimension %3).',
              DimValueCode, DimCode, DimNo);
    end;

    local procedure GetDimensionCode(ShortcutNo: Integer): Code[20]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not GLSetup.Get() then
            Error('General Ledger Setup is missing.');

        case ShortcutNo of
            1:
                exit(GLSetup."Shortcut Dimension 1 Code");
            2:
                exit(GLSetup."Shortcut Dimension 2 Code");
            3:
                exit(GLSetup."Shortcut Dimension 3 Code");
            4:
                exit(GLSetup."Shortcut Dimension 4 Code");
            else
                Error('Invalid shortcut dimension number: %1. Only 1–4 allowed.', ShortcutNo);
        end;
    end;

    procedure UploadFromExcelInDistributionSetup(Year: Code[20]; Month: Code[20])
    var
        JGTDistributionLines: Record "JGT Distribution Lines";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        DimensionValue: Record "Dimension Value";
        FileManage: Codeunit "File Management";
        InStm: InStream;
        FromFile: Text[250];
        FileName: Text[250];
        UploadExcelMsg: Text[100];
        SheetName: Text[100];
        SheetVal: Decimal;
        LineNo: Integer;
        MaxRowCount: Integer;
        RowCount: Integer;
    begin
        // File upload handling
        UploadExcelMsg := 'Please select the excel file.';
        if not UploadIntoStream(UploadExcelMsg, '', '', FromFile, InStm) then
            Error('No excel file selected.');

        FileName := FileManage.GetFileName(FromFile);
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStm);

        // Excel data processing
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(InStm, SheetName);
        TempExcelBuffer.ReadSheet();

        // Get max row count
        if TempExcelBuffer.FindLast() then
            MaxRowCount := TempExcelBuffer."Row No."
        else
            Error('No data found in Excel file');

        // Clear existing data for this year/month
        JGTDistributionLines.SetRange(Year, Year);
        JGTDistributionLines.SetRange(Month, Month);
        if not JGTDistributionLines.IsEmpty() then
            JGTDistributionLines.DeleteAll(false);

        // Initialize line number
        if JGTDistributionLines.FindLast() then
            LineNo := JGTDistributionLines."Line No." + 10000  // Large increment to avoid conflicts
        else
            LineNo := 10000;  // Starting line number

        // Process each row
        for RowCount := 2 to MaxRowCount do begin
            // Validate year and month consistency
            if Year <> GetValueAtCell(TempExcelBuffer, RowCount, 1) then
                Error('Year must be same in all rows. Conflict in row %1', RowCount);

            if Month <> GetValueAtCell(TempExcelBuffer, RowCount, 2) then
                Error('Month must be same in all rows. Conflict in row %1', RowCount);

            // Validate branch dimension
            DimensionValue.Reset();
            DimensionValue.SetRange("Dimension Code", 'BRANCH');
            DimensionValue.SetRange(Code, GetValueAtCell(TempExcelBuffer, RowCount, 3));
            if not DimensionValue.FindFirst() then
                Error('Branch Code %1 is not available in Dimensions (Row %2)',
                      GetValueAtCell(TempExcelBuffer, RowCount, 3), RowCount);

            // Prepare new record
            Clear(JGTDistributionLines);
            JGTDistributionLines.Init();
            JGTDistributionLines.Year := Year;
            JGTDistributionLines.Month := Month;
            JGTDistributionLines."Line No." := LineNo;
            JGTDistributionLines."Shortcut Dimension 1 Code" := GetValueAtCell(TempExcelBuffer, RowCount, 3);
            JGTDistributionLines."Shortcut Dimension 2 Code" := GetValueAtCell(TempExcelBuffer, RowCount, 4);
            JGTDistributionLines."Shortcut Dimension 3 Code" := GetValueAtCell(TempExcelBuffer, RowCount, 5);
            JGTDistributionLines."Shortcut Dimension 4 Code" := GetValueAtCell(TempExcelBuffer, RowCount, 6);
            JGTDistributionLines."Company Name" := GetValueAtCell(TempExcelBuffer, RowCount, 9);

            // Handle square feet value
            if Evaluate(SheetVal, GetValueAtCell(TempExcelBuffer, RowCount, 7)) then
                JGTDistributionLines."Square Feets" := SheetVal
            else
                JGTDistributionLines."Square Feets" := 0;

            // Insert record with error handling
            if not JGTDistributionLines.Insert(true) then
                Error('Failed to insert record for row %1: %2', RowCount, GetLastErrorText());

            // Increment line number
            LineNo := LineNo + 10000;
        end;

        Message('Excel import completed successfully. Imported %1 records.', MaxRowCount - 1);
    end;

    local procedure GetValueAtCell(var TempExcelBuffer: Record "Excel Buffer" temporary; RowNo: Integer; ColNo: Integer): Text
    begin
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    procedure CheckSalesInvoice(DocNo: Code[20]): Boolean
    var
        SalesInvHead: Record "Sales Invoice Header";
    begin
        if SalesInvHead.Get(DocNo) then
            exit(true);
    end;

    procedure GetGLCreditAmount(DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20]): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.SetFilter("Account Category", '%1|%2', GLEntry."Account Category"::Income, GLEntry."Account Category"::Expense);
        GLEntry.CalcSums("Credit Amount");
        exit(GLEntry."Credit Amount");
    end;

    procedure GetDeferGLDebitAmount(EntryNo: Integer; DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20]): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetRange("Entry No.", EntryNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.CalcSums("Debit Amount");
        exit(GLEntry."Debit Amount");
    end;

    procedure GetGLDebitAmount(DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20]): Decimal
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.CalcSums("Debit Amount");
        exit(GLEntry."Debit Amount");
    end;

    procedure UpdateGLEntryDistEntryNoApplied(EntryNo: Integer; DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20]; VATBusPostingGroup: code[20]; VATProPostingGroup: code[20]; GenBuspostingGroup: Code[20]; GenProPostingGroup: code[20]; SourceCode: Code[20])
    var
        GLEntry: Record "G/L Entry";
    begin
        Clear(GLEntry);
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Entry No.", EntryNo);
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.SetFilter("VAT Bus. Posting Group", VATBusPostingGroup);
        GLEntry.SetFilter("VAT Prod. Posting Group", VATProPostingGroup);
        GLEntry.SetFilter("Gen. Bus. Posting Group", GenBuspostingGroup);
        GLEntry.SetFilter("Gen. Prod. Posting Group", GenProPostingGroup);
        if (GLEntry.FindFirst() = true) then begin
            GLEntry."Dist. Entry No Applied" := EntryNo;
            GLEntry.Modify();
        end;
    end;

    procedure InitDistributionProjectLine(EntryNo: Integer; DocNo: code[20]; NegValue: Boolean; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20])
    var
        GLEntry: Record "G/L Entry";
        GLAcc: Record "G/L Account";
        JGTDistributionProject: Record "JGT Distribution Project";
        DimValue: Record "Dimension Value";
        DimValueTwoCode: Code[20];
        OldDimValueTwoCode: Code[20];
        DimValueThreeCode: Code[20];
        Inx: Integer;
        LineCraeted: Boolean;
    begin
        Clear(JGTDistributionProject);
        JGTDistributionProject.SetRange("Entry No.", EntryNo);
        if (JGTDistributionProject.FindSet(false) = true) then
            exit;

        Clear(GLEntry);
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetRange("Entry No.", EntryNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.SetFilter("Account Category", '%1|%2', GLEntry."Account Category"::Income, GLEntry."Account Category"::Expense);
        if not GLEntry.FindSet() then
            exit;
        repeat
            Clear(GLAcc);
            GLAcc.Get(GLEntry."G/L Account No.");
            if not GLAcc."VAT Account" then
                if GLEntry."Dimension Set ID" <> 0 then begin
                    Inx += 1;
                    Clear(DimValueTwoCode);
                    DimValueTwoCode := GetDimValueCode(GLEntry, 2);
                    if Inx = 1 then
                        OldDimValueTwoCode := DimValueTwoCode;

                    if OldDimValueTwoCode <> DimValueTwoCode then
                        Error('Branch code must be same.');

                    Clear(DimValueThreeCode);
                    DimValueThreeCode := GetDimValueCode(GLEntry, 3);
                    if DimValueThreeCode <> '' then begin
                        LineCraeted := true;
                        if JGTDistributionProject.Get(EntryNo, DimValueThreeCode, DimValueTwoCode) then begin
                            JGTDistributionProject."Project Amount" += GLEntry."Credit Amount";
                            JGTDistributionProject.Modify();
                        end
                        else begin
                            // Inx += 1;
                            // Clear(DistProject);
                            // DistProject."Entry No." := EntryNo;
                            // DistProject."Shortcut Dimension 2 Code" := DimValueTwoCode;
                            // DistProject."Shortcut Dimension 3 Code" := DimValueThreeCode;
                            // DistProject."Project Amount" += GLEntry."Credit Amount";
                            // DistProject."Project Line" := true;
                            // DistProject."Line No." := Inx;
                            // DistProject."G/L Account No." := GLEntry."G/L Account No.";
                            // DistProject.Insert();
                        end;
                    end;
                end;
        until GLEntry.Next() = 0;
        if LineCraeted then
            exit;

        Clear(Inx);
        Clear(OldDimValueTwoCode);
        GLEntry.FindSet();
        repeat
            if GLEntry."Dimension Set ID" <> 0 then
                if not ProceedDimProjectType(GLEntry) then begin
                    Clear(DimValueTwoCode);

                    DimValueTwoCode := GetDimValueCode(GLEntry, 2);
                    Inx += 1;
                    if Inx = 1 then
                        OldDimValueTwoCode := DimValueTwoCode;

                    if OldDimValueTwoCode <> DimValueTwoCode then
                        Error('Branch code must be same.');

                    // DimValue.SetRange("Shortcut Dimension 2 Code", DimValueTwoCode);
                    // if DimValue.FindSet() then
                    //     repeat
                    //         if DimValue."Shortcut Dimension 3 Code" <> '' then
                    //             CreateDistProjectValue(EntryNo, DimValueTwoCode, DimValue."Shortcut Dimension 3 Code", GLEntry."G/L Account No.");
                    //         if DimValue."Shortcut Dimension 3 Two" <> '' then
                    //             CreateDistProjectValue(EntryNo, DimValueTwoCode, DimValue."Shortcut Dimension 3 Two", GLEntry."G/L Account No.");
                    //         if DimValue."Shortcut Dimension 3 Three" <> '' then
                    //             CreateDistProjectValue(EntryNo, DimValueTwoCode, DimValue."Shortcut Dimension 3 Three", GLEntry."G/L Account No.");
                    //     until DimValue.Next() = 0;
                end;
        until GLEntry.Next() = 0;
        Commit();
    end;

    // procedure UploadDistributionProjectFromExcel(DistributionProject: Record "JGT Distribution Project")
    // var
    //     DistRuleFilter: Record "JGT Distribution Rule Filter";
    //     TempExcelBuffer: Record "Excel Buffer" temporary;
    //     GeneralLedgerSetup: Record "General Ledger Setup";
    //     FileManage: Codeunit "File Management";
    //     InStm: InStream;
    //     FromFile: Text[250];
    //     FileName: Text[250];
    //     UploadExcelMsg: Text[100];
    //     SheetName: Text[100];
    //     SheetVal: Decimal;
    //     DimensionAmountOne: Decimal;
    //     DimensionAmountTwo: Decimal;
    //     DimensionAmountThree: Decimal;
    //     DimensionAmountFour: Decimal;
    //     DimensionAmountFive: Decimal;
    //     DimensionTotalAmount: Decimal;
    //     DistributionTotalProjectAmount: Decimal;
    //     AddDimensionValue: Decimal;
    //     SubDimensionValue: Decimal;
    //     BranchCode: Code[20];
    //     EmployeeCodeTxt: Text;
    //     EntryNo: Integer;
    //     LineNo: Integer;
    //     MaxRowCount: Integer;
    //     RowCount: Integer;
    //     LoopInx: Integer;
    //     Year: Code[20];
    //     Month: Code[20];
    //     ProjectCode: Code[20];
    //     Phase: Code[20];
    //     Units: Code[20];
    //     SquareFeets: Code[20];
    //     GLAccountNo: Code[20];
    // begin
    //     Clear(Month);
    //     Clear(Year);
    //     Clear(BranchCode);
    //     Clear(ProjectCode);
    //     Clear(Phase);
    //     Clear(Units);
    //     Clear(SquareFeets);
    //     Clear(GLAccountNo);
    //     UploadExcelMsg := 'Please select the excel file.';
    //     UploadIntoStream(UploadExcelMsg, '', '', FromFile, InStm);
    //     if FromFile <> '' then begin
    //         FileName := FileManage.GetFileName(FromFile);
    //         SheetName := TempExcelBuffer.SelectSheetsNameStream(InStm);
    //     end
    //     else
    //         Error('No excel file selected.');

    //     Clear(TempExcelBuffer);
    //     TempExcelBuffer.DeleteAll();
    //     TempExcelBuffer.OpenBookStream(InStm, SheetName);
    //     TempExcelBuffer.ReadSheet();
    //     Clear(TempExcelBuffer);
    //     if TempExcelBuffer.FindLast() then
    //         MaxRowCount := TempExcelBuffer."Row No.";

    //     Clear(TempExcelBuffer);
    //     for RowCount := 2 to MaxRowCount do begin
    //         LoopInx += 1;
    //         Clear(EntryNo);
    //         Evaluate(EntryNo, GetValueAtCell(TempExcelBuffer, RowCount, 1));
    //         if LoopInx = 1 then
    //             DistRuleFilter.Get(EntryNo);

    //         DistributionProject.Reset();
    //         DistributionProject.SetRange("Entry No.", EntryNo);
    //         Clear(LineNo);
    //         Evaluate(LineNo, GetValueAtCell(TempExcelBuffer, RowCount, 11));
    //         DistributionProject.SetRange("Line No.", LineNo);
    //         Evaluate(Year, GetValueAtCell(TempExcelBuffer, RowCount, 2));
    //         Evaluate(Month, GetValueAtCell(TempExcelBuffer, RowCount, 3));
    //         Evaluate(BranchCode, GetValueAtCell(TempExcelBuffer, RowCount, 4));
    //         Evaluate(ProjectCode, GetValueAtCell(TempExcelBuffer, RowCount, 5));
    //         Evaluate(Phase, GetValueAtCell(TempExcelBuffer, RowCount, 6));
    //         Evaluate(Units, GetValueAtCell(TempExcelBuffer, RowCount, 7));
    //         Evaluate(SquareFeets, GetValueAtCell(TempExcelBuffer, RowCount, 8));
    //         DistributionProject.SetRange("Shortcut Dimension 1 Code", BranchCode);
    //         if (DistributionProject.FindFirst() = false) then
    //             Error('Line entry not found entry no %1 line no %2.', EntryNo, LineNo);

    //         Clear(SheetVal);
    //         Evaluate(SheetVal, GetValueAtCell(TempExcelBuffer, RowCount, 9));
    //         if DistRuleFilter."Negative Allocation" then
    //             DistributionProject.Validate("Project Amount", -SheetVal)
    //         else
    //             DistributionProject.Validate("Project Amount", SheetVal);
    //         Evaluate(GLAccountNo, GetValueAtCell(TempExcelBuffer, RowCount, 10));
    //         DistributionProject.Modify(false);
    //     end;

    //     DimensionTotalAmount := ((DistRuleFilter."Distribution Amount One") + (DistRuleFilter."Distribution Amount Two") + (DistRuleFilter."Distribution Amount Three") + (DistRuleFilter."Distribution Amount Four") + (DistRuleFilter."Distribution Amount Five"));
    //     if (DimensionTotalAmount <> DistRuleFilter."Distribution Amount") then begin
    //         Error('Dimensions Total Amount Must be equal to Distribution Amount');
    //     end;
    //     if (GeneralLedgerSetup.Get() = false) then
    //         Error('General Ledger Setup not found');

    //     if (DistRuleFilter."Dimension Filter" = GeneralLedgerSetup."Shortcut Dimension 1 Code") then begin
    //         if (DistRuleFilter."Dimension Value One" <> '') then begin
    //             DistributionProject.Reset();
    //             DistributionProject.SetRange("Entry No.", EntryNo);
    //             DistributionProject.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value One");
    //             if (DistributionProject.FindSet(false) = true) then
    //                 repeat
    //                     DimensionAmountOne += DistributionProject."Project Amount";
    //                 until DistributionProject.Next() = 0;

    //             if (DimensionAmountOne <> DistRuleFilter."Distribution Amount One") then begin
    //                 Clear(AddDimensionValue);
    //                 Clear(SubDimensionValue);
    //                 AddDimensionValue := DimensionAmountOne + 10;
    //                 SubDimensionValue := DimensionAmountOne - 10;
    //                 if ((AddDimensionValue < DistRuleFilter."Distribution Amount One") or (DistRuleFilter."Distribution Amount One" < SubDimensionValue)) then
    //                     Error('In Employee tab Project Amount Must be equal to Distribution Amount One');
    //             end;
    //         end;
    //     end;

    //     if (DistRuleFilter."Dimension Filter" = GeneralLedgerSetup."Shortcut Dimension 2 Code") then begin
    //         if (DistRuleFilter."Dimension Value Two" <> '') then begin
    //             DistributionProject.SetRange("Entry No.", EntryNo);
    //             DistributionProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Two");
    //             if (DistributionProject.FindSet(false) = true) then
    //                 repeat
    //                     DimensionAmountTwo += DistributionProject."Project Amount";
    //                 until DistributionProject.Next() = 0;

    //             if (DimensionAmountTwo <> DistRuleFilter."Distribution Amount Two") then begin
    //                 Clear(AddDimensionValue);
    //                 Clear(SubDimensionValue);
    //                 AddDimensionValue := DimensionAmountTwo + 10;
    //                 SubDimensionValue := DimensionAmountTwo - 10;
    //                 if ((AddDimensionValue < DistRuleFilter."Distribution Amount Two") or (DistRuleFilter."Distribution Amount Two" < SubDimensionValue)) then
    //                     Error('In Employee tab Project Amount Must be equal to Distribution Amount Two');
    //             end;
    //         end;
    //     end;

    //     if (DistRuleFilter."Dimension Filter" = GeneralLedgerSetup."Shortcut Dimension 3 Code") then begin
    //         if (DistRuleFilter."Dimension Value Three" <> '') then begin
    //             DistributionProject.SetRange("Entry No.", EntryNo);
    //             DistributionProject.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value Three");
    //             if (DistributionProject.FindSet(false) = true) then
    //                 repeat
    //                     DimensionAmountThree += DistributionProject."Project Amount";
    //                 until DistributionProject.Next() = 0;

    //             if (DimensionAmountThree <> DistRuleFilter."Distribution Amount Three") then begin
    //                 Clear(AddDimensionValue);
    //                 Clear(SubDimensionValue);
    //                 AddDimensionValue := DimensionAmountThree + 10;
    //                 SubDimensionValue := DimensionAmountThree - 10;
    //                 if ((AddDimensionValue < DistRuleFilter."Distribution Amount Three") or (DistRuleFilter."Distribution Amount Three" < SubDimensionValue)) then
    //                     Error('In Employee tab Project Amount Must be equal to Distribution Amount Three');
    //             end;
    //         end;
    //     end;
    //     if (DistRuleFilter."Dimension Filter" = GeneralLedgerSetup."Shortcut Dimension 4 Code") then begin
    //         if (DistRuleFilter."Dimension Value Four" <> '') then begin
    //             DistributionProject.SetRange("Entry No.", EntryNo);
    //             DistributionProject.SetRange("Shortcut Dimension 4 Code", DistRuleFilter."Dimension Value Four");
    //             if (DistributionProject.FindSet(false) = true) then
    //                 repeat
    //                     DimensionAmountFour += DistributionProject."Project Amount";
    //                 until DistributionProject.Next() = 0;

    //             if (DimensionAmountFour <> DistRuleFilter."Distribution Amount Four") then begin
    //                 Clear(AddDimensionValue);
    //                 Clear(SubDimensionValue);
    //                 AddDimensionValue := DimensionAmountFour + 10;
    //                 SubDimensionValue := DimensionAmountFour - 10;
    //                 if ((AddDimensionValue < DistRuleFilter."Distribution Amount Four") or (DistRuleFilter."Distribution Amount Four" < SubDimensionValue)) then
    //                     Error('In Employee tab Project Amount Must be equal to Distribution Amount Four');
    //             end;
    //         end;
    //     end;

    //     if (DistRuleFilter."Dimension Value Five" <> '') then begin
    //         DistributionProject.SetRange("Entry No.", EntryNo);
    //         DistributionProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Five");
    //         if (DistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DimensionAmountFive += DistributionProject."Project Amount";
    //             until DistributionProject.Next() = 0;

    //         if (DimensionAmountFive <> DistRuleFilter."Distribution Amount Five") then begin
    //             Clear(AddDimensionValue);
    //             Clear(SubDimensionValue);
    //             AddDimensionValue := DimensionAmountFive + 10;
    //             SubDimensionValue := DimensionAmountFive - 10;
    //             if ((AddDimensionValue < DistRuleFilter."Distribution Amount Five") or (DistRuleFilter."Distribution Amount Five" < SubDimensionValue)) then
    //                 Error('In Employee tab Project Amount Must be equal to Distribution Amount Five');
    //         end;
    //     end;
    //     Message('Allocation amount update process completed.');

    //     DistributionProject.Reset();
    //     DistributionProject.SetRange("Entry No.", EntryNo);
    //     if (DistributionProject.FindSet(false) = true) then
    //         repeat
    //             DistributionTotalProjectAmount += DistributionProject."Project Amount";
    //         until DistributionProject.Next() = 0;
    //     DeleteDistributionProjectLinesWhichAmountIsEqualToZero(DistributionProject."Entry No.", DistributionProject, 0);

    //     if (DistributionTotalProjectAmount <> DistRuleFilter."Distribution Amount") then begin
    //         Clear(AddDimensionValue);
    //         Clear(SubDimensionValue);
    //         AddDimensionValue := DistributionTotalProjectAmount + 10;
    //         SubDimensionValue := DistributionTotalProjectAmount - 10;
    //         if ((AddDimensionValue < DistRuleFilter."Distribution Amount") or (DistRuleFilter."Distribution Amount" < SubDimensionValue)) then
    //             Error('Distribution Total Project Amount Must be equal to Distribution Amount');
    //     end;
    //     Commit();
    // end;


    procedure UploadDistributionProjectFromExcel(DistributionProject: Record "JGT Distribution Project")
    var
        DistRuleFilter: Record "JGT Distribution Rule Filter";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        DistributionProjectTwo: Record "JGT Distribution Project";
        DistributionProjectThree: Record "JGT Distribution Project";
        GeneralLedgerSetup: Record "General Ledger Setup";
        FileManage: Codeunit "File Management";
        InStm: InStream;
        FromFile: Text[250];
        FileName: Text[250];
        UploadExcelMsg: Text[100];
        SheetName: Text[100];

        SheetVal: Decimal;
        DimensionAmountOne: Decimal;
        DimensionAmountTwo: Decimal;
        DimensionAmountThree: Decimal;
        DimensionAmountFour: Decimal;
        DimensionAmountFive: Decimal;
        DimensionTotalAmount: Decimal;
        DistributionTotalProjectAmount: Decimal;

        AddDimensionValue: Decimal;
        SubDimensionValue: Decimal;

        BranchCode: Code[20];
        EntryNo: Integer;
        LineNo: Integer;
        MaxRowCount: Integer;
        RowCount: Integer;
        LoopInx: Integer;

        DimensionOne: Boolean;
        DimensionTwo: Boolean;
        DimensionThree: Boolean;

        Year: Code[20];
        Month: Code[20];
        ProjectCode: Code[20];
        Phase: Code[20];
        Units: Code[20];
        SquareFeets: Code[20];
        GLAccountNo: Code[20];
    begin
        // =========================
        // Excel Upload
        // =========================
        UploadExcelMsg := 'Please select the excel file.';
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, InStm);
        if FromFile = '' then
            Error('No excel file selected.');

        FileName := FileManage.GetFileName(FromFile);
        SheetName := TempExcelBuffer.SelectSheetsNameStream(InStm);

        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(InStm, SheetName);
        TempExcelBuffer.ReadSheet();

        if TempExcelBuffer.FindLast() then
            MaxRowCount := TempExcelBuffer."Row No.";

        // =========================
        // Read Excel Rows
        // =========================
        for RowCount := 2 to MaxRowCount do begin
            LoopInx += 1;

            Evaluate(EntryNo, GetValueAtCell(TempExcelBuffer, RowCount, 1));
            if LoopInx = 1 then
                DistRuleFilter.Get(EntryNo);

            Evaluate(LineNo, GetValueAtCell(TempExcelBuffer, RowCount, 11));

            DistributionProject.Reset();
            DistributionProject.SetRange("Entry No.", EntryNo);
            DistributionProject.SetRange("Line No.", LineNo);

            if not DistributionProject.FindFirst() then
                Error('Line entry not found. Entry No %1 Line No %2', EntryNo, LineNo);

            Evaluate(BranchCode, GetValueAtCell(TempExcelBuffer, RowCount, 4));
            DistributionProject.SetRange("Shortcut Dimension 1 Code", BranchCode);

            Evaluate(SheetVal, GetValueAtCell(TempExcelBuffer, RowCount, 9));

            if DistRuleFilter."Negative Allocation" then
                DistributionProject.Validate("Project Amount", -SheetVal)
            else
                DistributionProject.Validate("Project Amount", SheetVal);

            DistributionProject.Modify(false);
        end;

        // =========================
        // NEW LOGIC ADDED 🔴
        // CLEAR ALL DIMENSION TOTALS
        // =========================
        Clear(DimensionAmountOne);
        Clear(DimensionAmountTwo);
        Clear(DimensionAmountThree);
        Clear(DimensionAmountFour);
        Clear(DimensionAmountFive);
        Clear(DistributionTotalProjectAmount);

        if not GeneralLedgerSetup.Get() then
            Error('General Ledger Setup not found');

        if GeneralLedgerSetup."Shortcut Dimension 1 Code" = DistRuleFilter."Dimension Filter" then
            DimensionOne := true;
        if GeneralLedgerSetup."Shortcut Dimension 2 Code" = DistRuleFilter."Dimension Filter" then
            DimensionTwo := true;
        if GeneralLedgerSetup."Shortcut Dimension 3 Code" = DistRuleFilter."Dimension Filter" then
            DimensionThree := true;

        // =========================
        // DIMENSION-WISE VALIDATION
        // =========================

        DistributionProjectTwo.Reset();
        DistributionProjectTwo.SetRange("Entry No.", EntryNo);
        if (DistributionProjectTwo.FindSet() = false) then
            exit;

        // Dimension 1
        if DimensionOne = true then begin
            if DistRuleFilter."Dimension Value One" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value One");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountOne += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountOne - DistRuleFilter."Distribution Amount One") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Two" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value Two");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountTwo += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountTwo - DistRuleFilter."Distribution Amount Two") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Three" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value Three");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountThree += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountThree - DistRuleFilter."Distribution Amount three") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value four" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value four");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFour += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFour - DistRuleFilter."Distribution Amount four") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Five" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 1 Code", DistRuleFilter."Dimension Value Five");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFive += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFive - DistRuleFilter."Distribution Amount Five") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;
        end;

        // Dimension 2
        if (DimensionTwo = true) then begin
            if DistRuleFilter."Dimension Value One" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value One");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountOne += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountOne - DistRuleFilter."Distribution Amount One") > 10 then
                    Error('Dimension 1 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Two" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Two");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountTwo += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountTwo - DistRuleFilter."Distribution Amount Two") > 10 then
                    Error('Dimension 2 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Three" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Three");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountThree += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountThree - DistRuleFilter."Distribution Amount three") > 10 then
                    Error('Dimension 2 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value four" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value four");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFour += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFour - DistRuleFilter."Distribution Amount four") > 10 then
                    Error('Dimension 2 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Five" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Five");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFive += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFive - DistRuleFilter."Distribution Amount Five") > 10 then
                    Error('Dimension 2 total mismatch.');
            end;
        end;

        // Dimension 3
        if (DimensionThree = true) then begin
            if DistRuleFilter."Dimension Value One" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value One");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountOne += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountOne - DistRuleFilter."Distribution Amount One") > 10 then
                    Error('Dimension 3 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Two" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value Two");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountTwo += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountTwo - DistRuleFilter."Distribution Amount Two") > 10 then
                    Error('Dimension 3 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Three" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value Three");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountThree += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountThree - DistRuleFilter."Distribution Amount three") > 10 then
                    Error('Dimension 3 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value four" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value four");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFour += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFour - DistRuleFilter."Distribution Amount four") > 10 then
                    Error('Dimension 3 total mismatch.');
            end;

            if DistRuleFilter."Dimension Value Five" <> '' then begin
                DistributionProjectThree.Reset();
                DistributionProjectThree.SetRange("Entry No.", EntryNo);
                DistributionProjectThree.SetRange("Shortcut Dimension 3 Code", DistRuleFilter."Dimension Value Five");
                if DistributionProjectThree.FindSet() then
                    repeat
                        DimensionAmountFive += DistributionProjectThree."Project Amount";
                    until DistributionProjectThree.Next() = 0;

                if Abs(DimensionAmountFive - DistRuleFilter."Distribution Amount Five") > 10 then
                    Error('Dimension 3 total mismatch.');
            end;
        end;


        // =========================
        // FINAL TOTAL VALIDATION
        // =========================
        DistributionProjectTwo.Reset();
        DistributionProjectTwo.SetRange("Entry No.", EntryNo);
        if DistributionProjectTwo.FindSet() then
            repeat
                DistributionTotalProjectAmount += DistributionProjectTwo."Project Amount";
            until DistributionProjectTwo.Next() = 0;

        if Abs(DistributionTotalProjectAmount - DistRuleFilter."Distribution Amount") > 10 then
            Error('Distribution total amount mismatch.');

        Message('Allocation amount update process completed.');
        Commit();
    end;

    // procedure UpdateDistAmountManually(var DistRuleFilter: Record "JGT Distribution Rule Filter"; FilterVal: Integer)
    // var
    //     JSTDistProject: Record "JGT Distribution Project";
    //     DistAmount: Decimal;
    //     DistAmountEquly: Decimal;
    //     TotEmpCount: Integer;
    //     Inx: Integer;
    // begin
    //     DistRuleFilter.TestField("Distribution Amount");
    //     JSTDistProject.SetRange("Entry No.", DistRuleFilter."Entry No.");
    //     if FilterVal = 1 then
    //         JSTDistProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value One");
    //     if FilterVal = 2 then
    //         JSTDistProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Two");
    //     if FilterVal = 3 then
    //         JSTDistProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Three");
    //     if FilterVal = 4 then
    //         JSTDistProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Four");
    //     if FilterVal = 5 then
    //         JSTDistProject.SetRange("Shortcut Dimension 2 Code", DistRuleFilter."Dimension Value Five");
    //     JSTDistProject.CalcSums("Emp. Count");
    //     TotEmpCount := JSTDistProject."Emp. Count";
    //     Inx := JSTDistProject.Count();
    //     if not JSTDistProject.FindSet() then
    //         exit;
    //     if TotEmpCount = 0 then
    //         exit;
    //     if FilterVal = 0 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     if FilterVal = 1 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount One";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     if FilterVal = 2 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount Two";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     if FilterVal = 3 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount Three";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     if FilterVal = 4 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount Four";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     if FilterVal = 5 then begin
    //         DistAmount := DistRuleFilter."Distribution Amount Five";
    //         DistAmountEquly := Round(DistAmount / TotEmpCount, 0.01);
    //     end;
    //     repeat
    //         if Inx <> 1 then
    //             JSTDistProject."Project Amount" := DistAmountEquly * JSTDistProject."Emp. Count"
    //         else
    //             JSTDistProject."Project Amount" := DistAmount;
    //         JSTDistProject.Modify();
    //         DistAmount := DistAmount - JSTDistProject."Project Amount";
    //         Inx -= 1;
    //     until JSTDistProject.Next() = 0;

    // end;

    procedure FalseUpdateGLEntryDistributioRuleApplied(GlEntryNo: Integer; DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20]; GLAccNo: code[20]; VATBusPostingGroup: Code[20]; VATProPostingGroup: code[20]; GenBuspostingGroup: Code[20]; GenProPostingGroup: code[20])
    var
        GLEntry: Record "G/L Entry";
    begin
        Clear(GLEntry);
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetRange("Entry No.", GlEntryNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.SetFilter("VAT Bus. Posting Group", VATBusPostingGroup);
        GLEntry.SetFilter("VAT Prod. Posting Group", VATProPostingGroup);
        GLEntry.SetFilter("Gen. Bus. Posting Group", GenBuspostingGroup);
        GLEntry.SetFilter("Gen. Prod. Posting Group", GenProPostingGroup);
        if (GLEntry.FindFirst() = true) then begin
            GLEntry."Distributio Rule Applied" := false;
            GLEntry.Modify();
        end;
    end;

    procedure CreateProjectDistFromDistributionLine(EntryNo: Integer; RecDimensionValue: Code[20]; xRecDimensionValue: Code[20]; GLAccountNo: Code[20]; Integers: Integer; DimensionCode: Code[20]);
    var
        JGTDistProject: Record "JGT Distribution Project";
        JGTDistributionRule: Record "JGT Distribution Rule";
        GLEntry: Record "G/L Entry";
        IsAvaliable: Boolean;
    begin
        Clear(JGTDistProject);
        Clear(JGTDistributionRule);
        JGTDistProject.SetRange("Entry No.", EntryNo);
        if RecDimensionValue <> xRecDimensionValue then begin
            JGTDistProject.SetRange("Shortcut Dimension 2 Code", xRecDimensionValue);
            if (JGTDistProject.FindSet(false) = true) then begin
                JGTDistProject.DeleteAll(true);
                IsAvaliable := true;
                if RecDimensionValue = '' then
                    exit;
            end;
            if (IsAvaliable = true) then begin
                JGTDistributionRule.Reset();
                JGTDistributionRule.SetRange("Entry No.", EntryNo);
                JGTDistributionRule.SetRange("Shortcut Dimension 2 Code", xRecDimensionValue);
                if (JGTDistributionRule.FindSet(false) = true) then begin
                    JGTDistributionRule.DeleteAll(true);
                    if RecDimensionValue = '' then
                        exit;
                end;
            end;
        end;

        JGTDistProject.SetRange("Shortcut Dimension 2 Code", RecDimensionValue);
        if JGTDistProject.FindSet() then
            Error('Distribution projects lines exists, please delete projects lines.');

        if (GLEntry.Get(EntryNo) = false) then
            exit
        else
            DistributionProjectLinesArePopulatedFromDistributionSetup(GLEntry, DimensionCode, RecDimensionValue, GLAccountNo, Integers);
    end;

    // procedure DistributionProjectLinesArePopulatedFromDistributionSetup(GLEntry: Record "G/L Entry"; RecDimensionValue: Code[20]; GLAccNo: code[20]; Integer: Integer)
    // var
    //     JGTDistributionLine: Record "JGT Distribution Lines";
    //     JGTDistributionRuleFilter: Record "JGT Distribution Rule Filter";
    //     DimensionValue: Record "Dimension Value";
    //     Dimension: Record Dimension;
    //     GLAccount: Record "G/L Account";
    //     BranchCodeList: List of [Text];
    //     BranchCodeList2: List of [Text];
    //     IntegerOfList: Integer;
    //     IntegerOfList2: Integer;
    //     ValueOfText: Text;
    //     BranchCode: Text;
    //     EmployeeCount: Integer;
    //     DimensionValueCode: Code[20];
    //     ProjectCode: Boolean;
    //     SquareFeets: Decimal;
    // begin
    //     DistributionYear := GetDistributionYear(GLEntry."Entry No.");
    //     DistributionMonth := GetDistributionMonth(GLEntry."Entry No.");

    //     // Apply filters
    //     JGTDistributionLine.Reset();
    //     JGTDistributionLine.SetRange("Shortcut Dimension 2 Code", RecDimensionValue);
    //     JGTDistributionLine.SetRange(Year, DistributionYear);
    //     JGTDistributionLine.SetRange(Month, DistributionMonth);

    //     // Debug check
    //     Message(
    //         'Filters applied:\n Dim2 = %1 \n Year = %2 \n Month = %3',
    //         RecDimensionValue, DistributionYear, DistributionMonth);

    //     // Find records
    //     if JGTDistributionLine.FindSet(false) then begin
    //         repeat
    //             BranchCodeList.Add(JGTDistributionLine."Shortcut Dimension 2 Code");
    //             EmployeeCount += 1;
    //         until JGTDistributionLine.Next() = 0;
    //     end else
    //         Error(
    //             'No Distribution Lines found for Dim2=%1, Year=%2, Month=%3',
    //             RecDimensionValue, DistributionYear, DistributionMonth);

    //     // Remove duplicates
    //     for IntegerOfList := 1 to BranchCodeList.Count do begin
    //         ValueOfText := BranchCodeList.Get(IntegerOfList);
    //         if BranchCodeList2.IndexOf(ValueOfText) = 0 then
    //             BranchCodeList2.Add(ValueOfText);
    //     end;

    //     // Build BranchCode string
    //     for IntegerOfList2 := 1 to BranchCodeList2.Count do begin
    //         if BranchCode = '' then
    //             BranchCode := BranchCodeList2.Get(IntegerOfList2)
    //         else
    //             BranchCode += '|' + BranchCodeList2.Get(IntegerOfList2);
    //     end;

    //     if (JGTDistributionRuleFilter.Get(GLEntry."Entry No.") = false) then
    //         exit;

    //     if (JGTDistributionRuleFilter."Sales Invoice" = true) then begin
    //         if (JGTDistributionRuleFilter."Distribution Options" = JGTDistributionRuleFilter."Distribution Options"::"Single Project") then begin
    //             if ((GLEntry."Document Type"::Invoice = GLEntry."Document Type") and (GLEntry."Credit Amount" <> 0)) then begin
    //                 if (GLAccount.Get(GLEntry."G/L Account No.") = true) then begin
    //                     if (Dimension.Get('PROJECT') = true) then begin
    //                         DimensionValue.SetRange("Dimension Code", Dimension.Code);
    //                         // DimensionValue.SetRange(Name, GLAccount.Name);
    //                         if (DimensionValue.FindSet() = true) then begin
    //                             repeat
    //                                 if (DimensionValue.Code = RecDimensionValue) then
    //                                     DimensionValueCode := DimensionValue.Code
    //                             until DimensionValue.Next() = 0;
    //                         end
    //                         else
    //                             Error('There is no Dimension With the Name of %1', GLAccount.Name);
    //                     end;
    //                 end;

    //                 JGTDistributionLine.SetRange("Shortcut Dimension 2 Code", RecDimensionValue);
    //                 JGTDistributionLine.SetRange(Year, DistributionYear);
    //                 JGTDistributionLine.SetRange(Month, DistributionMonth);
    //                 if (JGTDistributionLine.FindSet(false) = true) then begin
    //                     repeat
    //                         if (JGTDistributionLine."Shortcut Dimension 1 Code" = DimensionValueCode) then begin
    //                             ProjectCode := true;
    //                             DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, DimensionValueCode)
    //                         end;

    //                         if (JGTDistributionLine."Shortcut Dimension 2 Code" = DimensionValueCode) then begin
    //                             ProjectCode := true;
    //                             DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, DimensionValueCode)
    //                         end;

    //                         if (JGTDistributionLine."Shortcut Dimension 3 Code" = DimensionValueCode) then begin
    //                             ProjectCode := true;
    //                             DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, DimensionValueCode)
    //                         end;

    //                         if (JGTDistributionLine."Shortcut Dimension 4 Code" = DimensionValueCode) then begin
    //                             ProjectCode := true;
    //                             DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, DimensionValueCode)
    //                         end;

    //                     // if (JGTDistributionLine."Shortcut Dimension 3 Code" = DimensionValueCode) then begin
    //                     //     ProjectCode := true;
    //                     //     DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, DimensionValueCode)
    //                     // end;

    //                     until JGTDistributionLine.Next() = 0
    //                 end;
    //             end;
    //         end else
    //             if (JGTDistributionRuleFilter."Distribution Options" = JGTDistributionRuleFilter."Distribution Options"::"Multiple Project") then
    //                 DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, '');
    //     end else
    //         DistributionProjectAndDistributionLinesAreUpdated(GLEntry, JGTDistributionLine, Integer, GLAccNo, EmployeeCount, BranchCode, RecDimensionValue, ProjectCode, '');
    // end;

    procedure DistributionProjectLinesArePopulatedFromDistributionSetup(
        GLEntry: Record "G/L Entry"; DimensionCode: Code[20];
        RecDimensionValue: Code[20];
        GLAccNo: Code[20];
        Integers: Integer)
    var
        JGTDistributionLine: Record "JGT Distribution Lines";
        JGTDistributionRuleFilter: Record "JGT Distribution Rule Filter";
        DimensionValue: Record "Dimension Value";
        GLAccount: Record "G/L Account";
        BranchCodeList: List of [Text];
        BranchCodeList2: List of [Text];
        IntegerOfList: Integer;
        IntegerOfList2: Integer;
        ValueOfText: Text;
        BranchCode: Text;
        EmployeeCount: Integer;
        DimensionValueCode: Code[20];
        ProjectCode: Boolean;
        DimNo: Integer;
    begin
        DistributionYear := GetDistributionYear(GLEntry."Entry No.");
        DistributionMonth := GetDistributionMonth(GLEntry."Entry No.");

        // 🔎 Detect which dimension this value belongs to
        if DimensionValue.Get(DimensionCode, RecDimensionValue) then
            DimNo := DimensionValue."Global Dimension No."
        else
            Error('Dimension Value %1 not found in Dimension Value table', RecDimensionValue);

        // Apply filters
        JGTDistributionLine.Reset();
        case DimNo of
            1:
                JGTDistributionLine.SetRange("Shortcut Dimension 1 Code", RecDimensionValue);
            2:
                JGTDistributionLine.SetRange("Shortcut Dimension 2 Code", RecDimensionValue);
            3:
                JGTDistributionLine.SetRange("Shortcut Dimension 3 Code", RecDimensionValue);
            4:
                JGTDistributionLine.SetRange("Shortcut Dimension 4 Code", RecDimensionValue);
        end;

        JGTDistributionLine.SetRange(Year, DistributionYear);
        JGTDistributionLine.SetRange(Month, DistributionMonth);

        // Debug check
        Message(
            'Filters applied:\n Dimension = %1 (Dim%2)\n Year = %3 \n Month = %4',
            RecDimensionValue, DimNo, DistributionYear, DistributionMonth);

        if not JGTDistributionLine.FindSet(false) then
            Error(
                'No Distribution Lines found for %1 in Year=%2, Month=%3',
                RecDimensionValue, DistributionYear, DistributionMonth);

        // Collect branch codes
        repeat
            BranchCodeList.Add(JGTDistributionLine."Shortcut Dimension 2 Code");
            EmployeeCount += 1;
        until JGTDistributionLine.Next() = 0;

        // Remove duplicates
        for IntegerOfList := 1 to BranchCodeList.Count do begin
            ValueOfText := BranchCodeList.Get(IntegerOfList);
            if BranchCodeList2.IndexOf(ValueOfText) = 0 then
                BranchCodeList2.Add(ValueOfText);
        end;

        // Build BranchCode string
        for IntegerOfList2 := 1 to BranchCodeList2.Count do begin
            if BranchCode = '' then
                BranchCode := BranchCodeList2.Get(IntegerOfList2)
            else
                BranchCode += '|' + BranchCodeList2.Get(IntegerOfList2);
        end;

        // 🔎 Rule Filter
        if not JGTDistributionRuleFilter.Get(GLEntry."Entry No.") then
            exit;

        if JGTDistributionRuleFilter."Sales Invoice" then begin
            if JGTDistributionRuleFilter."Distribution Options" =
               JGTDistributionRuleFilter."Distribution Options"::"Single Project" then begin

                if ((GLEntry."Document Type" = GLEntry."Document Type"::Invoice) and
                    (GLEntry."Credit Amount" <> 0)) then begin

                    if GLAccount.Get(GLEntry."G/L Account No.") then begin
                        DimensionValueCode := RecDimensionValue; // assign detected code
                    end;

                    // Loop again with correct filter already applied
                    if JGTDistributionLine.FindSet(false) then
                        repeat
                            ProjectCode := true;
                            DistributionProjectAndDistributionLinesAreUpdated(
                                GLEntry, JGTDistributionLine, Integers, GLAccNo,
                                EmployeeCount, BranchCode, RecDimensionValue,
                                ProjectCode, DimensionValueCode);
                        until JGTDistributionLine.Next() = 0;
                end;
            end else
                if JGTDistributionRuleFilter."Distribution Options" =
                   JGTDistributionRuleFilter."Distribution Options"::"Multiple Project" then
                    DistributionProjectAndDistributionLinesAreUpdated(
                        GLEntry, JGTDistributionLine, Integers, GLAccNo,
                        EmployeeCount, BranchCode, RecDimensionValue,
                        ProjectCode, '');
        end else
            DistributionProjectAndDistributionLinesAreUpdated(
                GLEntry, JGTDistributionLine, Integers, GLAccNo,
                EmployeeCount, BranchCode, RecDimensionValue,
                ProjectCode, '');
    end;

    local procedure DistributionProjectAndDistributionLinesAreUpdated(GLEntry: Record "G/L Entry"; var DistributionLine: Record "JGT Distribution Lines"; Integer: Integer; GLAccNo: code[20]; EmployeeCount: Integer; BranchCode: Text; RecDimensionValue: Code[20]; ProjectCode: Boolean; DimensionValueCode: Code[20])
    var
        DistributionRule: Record "JGT Distribution Rule";
        DistributionProject: Record "JGT Distribution Project";
        DistributionRuleFilter: Record "JGT Distribution Rule Filter";
        LclJGTDistributionLine: Record "JGT Distribution Lines";
        CompanyInformation: Record "Company Information";
        DistributionProjectLineNo: Integer;
        ProjectIncrementValue: Integer;
        DistRuleIncrementValue: Integer;
        DistributionRuleLineNo: Integer;
        IsHandle: Boolean;
        SquFeets: Decimal;
    begin
        if (ProjectCode = true) then begin
            Clear(IsHandle);
            IsHandle := true;
            Clear(DistributionProject);
            DistributionRuleFilter.Get(GLEntry."Entry No.");
            DistributionProject.Init();
            DistributionProject."Entry No." := GLEntry."Entry No.";
            DistributionProject."Shortcut Dimension 1 Code" := DistributionLine."Shortcut Dimension 1 Code";
            DistributionProject."Shortcut Dimension 2 Code" := DistributionLine."Shortcut Dimension 2 Code";
            DistributionProject."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 Code";
            DistributionProject."Shortcut Dimension 4 Code" := DistributionLine."Shortcut Dimension 4 Code";
            // DistributionProject."Line No." := DistributionProject."Line No." + 1000;
            DistributionProject."Line No." := DistributionLine."Line No.";
            DistributionProject.Year := DistributionLine.Year;
            DistributionProject.Month := DistributionLine.Month;
            DistributionProject."Square Feets" := DistributionLine."Square Feets";
            if (DistributionLine."Company Name" = '') then
                if (CompanyInformation.Get() = true) then
                    DistributionProject."Company Name" := CompanyInformation.Name;

            if (DistributionLine."Company Name" <> '') then
                DistributionProject."Company Name" := DistributionLine."Company Name";

            GLEntry.CalcFields("Account Category");
            DistributionProject."Account Category" := GLEntry."Account Category";
            DistributionProject."Document No." := GLEntry."Document No.";
            DistributionProject."Posting Date" := GLEntry."Posting Date";
            if (IsHandle = true) then begin
                LclJGTDistributionLine.Reset();
                LclJGTDistributionLine.SetRange(Year, DistributionLine.Year);
                LclJGTDistributionLine.SetRange(Month, DistributionLine.Month);
                LclJGTDistributionLine.SetRange("Shortcut Dimension 1 Code", DistributionLine."Shortcut Dimension 1 Code");
                LclJGTDistributionLine.SetRange("Shortcut Dimension 2 Code", DistributionLine."Shortcut Dimension 2 Code");
                if LclJGTDistributionLine.FindSet() then begin
                    repeat
                        SquFeets += LclJGTDistributionLine."Square Feets";
                    until LclJGTDistributionLine.Next() = 0;
                end;
            end;

            // if (Integer = 0) then
            // DistributionProject."Project Amount" := Round(DistributionRuleFilter."Distribution Amount" / EmployeeCount, 0.01);
            // DistributionProject."Project Amount" := Round(DistributionRuleFilter."Distribution Amount" / (SquFeets) * DistributionLine."Square Feets", 0.01);

            DistributionProject."Project Line" := true;
            DistributionProject."Emp. Count" := GetEmployeeCountFromDistributionSetup(DistributionYear, DistributionMonth, DistributionLine."Shortcut Dimension 1 Code", BranchCode);
            EmployeeCount2 += DistributionProject."Emp. Count";
            DistributionProject."G/L Account No." := GLAccNo;
            DistributionProject.Insert(false);

            ProjectIncrementValue := 1;
            /* Distribution Rule tab is populating values*/
            Clear(DistributionRule);
            DistributionRule.SetRange("Entry No.", GLEntry."Entry No.");
            if (DistributionLine."Shortcut Dimension 3 Code" = DimensionValueCode) then begin
                DistRuleIncrementValue += 1;
                DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                DistributionRule."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 Code";
                // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage One";
                DistributionRule."Posting Date" := GLEntry."Posting Date";
                DistributionRule."Document No." := GLEntry."Document No.";
                GLEntry.CalcFields("Account Category");
                if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    DistributionRule."Account Category" := GLEntry."Account Category";
                end else
                    DistributionRule."Account Category" := GLEntry."Account Category";

                // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                // DistributionRule."Manager No." := DistributionLine."Manager No.";
                // DistributionRule.Manager := DistributionLine.Manager;
                DistributionRule.Modify(false);
            end;

            if (DistributionLine."Shortcut Dimension 1 Code" = DimensionValueCode) then begin
                DistRuleIncrementValue += 1;
                DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                DistributionRule."Shortcut Dimension 1 Code" := DistributionLine."Shortcut Dimension 1 Code";
                // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Two";
                DistributionRule."Posting Date" := GLEntry."Posting Date";
                DistributionRule."Document No." := GLEntry."Document No.";
                GLEntry.CalcFields("Account Category");
                if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    DistributionRule."Account Category" := GLEntry."Account Category";
                end else
                    DistributionRule."Account Category" := GLEntry."Account Category";

                // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                // DistributionRule."Manager No." := DistributionLine."Manager No.";
                // DistributionRule.Manager := DistributionLine.Manager;
                DistributionRule.Modify(false);
            end;

            if (DistributionLine."Shortcut Dimension 2 Code" = DimensionValueCode) then begin
                DistRuleIncrementValue += 1;
                DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                DistributionRule."Shortcut Dimension 2 Code" := DistributionLine."Shortcut Dimension 2 Code";
                // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Three";
                DistributionRule."Posting Date" := GLEntry."Posting Date";
                DistributionRule."Document No." := GLEntry."Document No.";
                GLEntry.CalcFields("Account Category");
                if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    DistributionRule."Account Category" := GLEntry."Account Category";
                end else
                    DistributionRule."Account Category" := GLEntry."Account Category";

                // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                // DistributionRule."Manager No." := DistributionLine."Manager No.";
                // DistributionRule.Manager := DistributionLine.Manager;
                DistributionRule.Modify(false);
            end;

            if (DistributionLine."Shortcut Dimension 3 Code" = DimensionValueCode) then begin
                DistRuleIncrementValue += 1;
                DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                DistributionRule."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 Code";
                // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Four";
                DistributionRule."Posting Date" := GLEntry."Posting Date";
                DistributionRule."Document No." := GLEntry."Document No.";
                GLEntry.CalcFields("Account Category");
                if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    DistributionRule."Account Category" := GLEntry."Account Category";
                end else
                    DistributionRule."Account Category" := GLEntry."Account Category";

                // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                // DistributionRule."Manager No." := DistributionLine."Manager No.";
                // DistributionRule.Manager := DistributionLine.Manager;
                DistributionRule.Modify(false);
            end;

            if (DistributionLine."Shortcut Dimension 4 Code" = DimensionValueCode) then begin
                DistRuleIncrementValue += 1;
                DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                DistributionRule."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 4 Code";
                // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Five";
                DistributionRule."Posting Date" := GLEntry."Posting Date";
                DistributionRule."Document No." := GLEntry."Document No.";
                GLEntry.CalcFields("Account Category");
                if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    DistributionRule."Account Category" := GLEntry."Account Category";
                end else
                    DistributionRule."Account Category" := GLEntry."Account Category";

                // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                // DistributionRule."Manager No." := DistributionLine."Manager No.";
                // DistributionRule.Manager := DistributionLine.Manager;
                DistributionRule.Modify(false);
            end;

            Clear(ProjectIncrementValue);
            Clear(DistRuleIncrementValue);
        end else begin
            DistributionRuleFilter.Get(GLEntry."Entry No.");
            if (DistributionLine.FindSet(false) = true) then begin
                repeat
                    Clear(DistributionProject);
                    DistributionProject.Init();
                    DistributionProject."Entry No." := GLEntry."Entry No.";
                    DistributionProject.Year := DistributionLine.Year;
                    DistributionProject.Month := DistributionLine.Month;
                    DistributionProject."Line No." := DistributionLine."Line No.";
                    DistributionProject."Shortcut Dimension 1 Code" := DistributionLine."Shortcut Dimension 1 Code";
                    DistributionProject."Shortcut Dimension 2 Code" := DistributionLine."Shortcut Dimension 2 Code";
                    DistributionProject."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 Code";
                    DistributionProject."Shortcut Dimension 4 Code" := DistributionLine."Shortcut Dimension 4 Code";
                    DistributionProject."Square Feets" := DistributionLine."Square Feets";
                    if (DistributionLine."Company Name" = '') then
                        if (CompanyInformation.Get() = true) then
                            DistributionProject."Company Name" := CompanyInformation.Name;
                    if (DistributionLine."Company Name" <> '') then
                        DistributionProject."Company Name" := DistributionLine."Company Name";

                    if (Integer = 0) then
                        DistributionProject."Project Amount" := Round(DistributionRuleFilter."Distribution Amount" / EmployeeCount, 0.01);

                    DistributionProject."Project Line" := true;
                    // DistributionProject."Line No." := DistributionProjectLineNo + 1000;
                    // DistributionProject."Emp. Count" := GetEmployeeCountFromDistributionSetup(DistributionYear, DistributionMonth, DistributionLine."Shortcut Dimension 1 Code", BranchCode);
                    // EmployeeCount2 += DistributionProject."Emp. Count";
                    DistributionProject."G/L Account No." := GLAccNo;
                    DistributionProject."Posting Date" := GLEntry."Posting Date";
                    DistributionProject."Document No." := GLEntry."Document No.";
                    GLEntry.CalcFields("Account Category");
                    DistributionProject."Account Category" := GLEntry."Account Category";
                    DistributionProject.Insert(true);
                    ProjectIncrementValue := 1;

                    /* Distribution Rule tab is populating values*/

                    Clear(DistributionRule);
                    DistributionRule.SetRange("Entry No.", GLEntry."Entry No.");
                    if (DistributionLine."Shortcut Dimension 1 Code" <> '') then begin
                        DistRuleIncrementValue += 1;
                        DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                        DistributionRule."Shortcut Dimension 1 Code" := DistributionLine."Shortcut Dimension 1 Code";
                        // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage One";
                        DistributionRule."Posting Date" := GLEntry."Posting Date";
                        DistributionRule."Document No." := GLEntry."Document No.";
                        GLEntry.CalcFields("Account Category");
                        if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                            DistributionRule."Account Category" := GLEntry."Account Category";
                        end else
                            DistributionRule."Account Category" := GLEntry."Account Category";

                        // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                        // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                        // DistributionRule."Manager No." := DistributionLine."Manager No.";
                        // DistributionRule.Manager := DistributionLine.Manager;
                        DistributionRule.Modify(false);
                    end;

                    if (DistributionLine."Shortcut Dimension 2 Code" <> '') then begin
                        DistRuleIncrementValue += 1;
                        DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                        DistributionRule."Shortcut Dimension 2 Code" := DistributionLine."Shortcut Dimension 2 Code";
                        // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Two";
                        DistributionRule."Posting Date" := GLEntry."Posting Date";
                        DistributionRule."Document No." := GLEntry."Document No.";
                        GLEntry.CalcFields("Account Category");
                        if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                            DistributionRule."Account Category" := GLEntry."Account Category";
                        end else
                            DistributionRule."Account Category" := GLEntry."Account Category";

                        // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                        // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                        // DistributionRule."Manager No." := DistributionLine."Manager No.";
                        // DistributionRule.Manager := DistributionLine.Manager;
                        DistributionRule.Modify(false);
                    end;

                    if (DistributionLine."Shortcut Dimension 3 Code" <> '') then begin
                        DistRuleIncrementValue += 1;
                        DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                        DistributionRule."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 code";
                        // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Three";
                        DistributionRule."Posting Date" := GLEntry."Posting Date";
                        DistributionRule."Document No." := GLEntry."Document No.";
                        GLEntry.CalcFields("Account Category");
                        if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                            DistributionRule."Account Category" := GLEntry."Account Category";
                        end else
                            DistributionRule."Account Category" := GLEntry."Account Category";

                        // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                        // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                        // DistributionRule."Manager No." := DistributionLine."Manager No.";
                        // DistributionRule.Manager := DistributionLine.Manager;
                        DistributionRule.Modify(false);
                    end;

                    if (DistributionLine."Shortcut Dimension 4 Code" <> '') then begin
                        DistRuleIncrementValue += 1;
                        DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                        // DistributionRule."Shortcut Dimension 4 Code" := DistributionLine."Shortcut Dimension 4 Code";
                        // DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage Four";
                        DistributionRule."Posting Date" := GLEntry."Posting Date";
                        DistributionRule."Document No." := GLEntry."Document No.";
                        GLEntry.CalcFields("Account Category");
                        if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                            DistributionRule."Account Category" := GLEntry."Account Category";
                        end else
                            DistributionRule."Account Category" := GLEntry."Account Category";

                        // DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                        // DistributionRule."Team Leader" := DistributionLine."Team Leader";
                        // DistributionRule."Manager No." := DistributionLine."Manager No.";
                        // DistributionRule.Manager := DistributionLine.Manager;
                        DistributionRule.Modify(false);
                    end;

                    // if (DistributionLine."Shortcut Dimension 3 Five" <> '') then begin
                    //     DistRuleIncrementValue += 1;
                    //     DistributionRuleLineNo := InsertDistributionRuleLineFromDistributionSetup(DistributionRuleFilter, DistributionRule, DistributionLine, DistributionRuleLineNo);
                    //     DistributionRule."Shortcut Dimension 3 Code" := DistributionLine."Shortcut Dimension 3 Five";
                    //     DistributionRule."Emp. Project Percentage" := DistributionLine."Percentage five";
                    //     DistributionRule."Posting Date" := GLEntry."Posting Date";
                    //     DistributionRule."Document No." := GLEntry."Document No.";
                    //     GLEntry.CalcFields("Account Category");
                    //     if ((GLEntry."Account Category"::Expense) = GLEntry."Account Category") then begin
                    //         DistributionRule."Account Category" := GLEntry."Account Category";
                    //     end else
                    //         DistributionRule."Account Category" := GLEntry."Account Category";

                    //     DistributionRule."Team Leader No." := DistributionLine."Team leader No.";
                    //     DistributionRule."Team Leader" := DistributionLine."Team Leader";
                    //     DistributionRule."Manager No." := DistributionLine."Manager No.";
                    //     DistributionRule.Manager := DistributionLine.Manager;
                    //     DistributionRule.Modify(false);
                    // end;

                    Clear(ProjectIncrementValue);
                    Clear(DistRuleIncrementValue);
                until DistributionLine.Next() = 0;
            end;
        end;
    end;

    procedure InsertDistributionRuleLineFromDistributionSetup(var DistributionruleFilter: Record "JGT Distribution Rule Filter"; var DistributionRule: Record "JGT Distribution Rule"; var DistributionLines: Record "JGT Distribution Lines"; DistributionRuleLineNo: Integer): Integer
    var
        RuleIncrement: Integer;
        LastLineNo: Integer;
    begin
        DistributionRule.Init();
        DistributionRule."Entry No." := DistributionruleFilter."Entry No.";
        if (DistributionRule.FindLast() = true) then
            DistributionRule."Line No." := DistributionRule."Line No." + 1000
        else
            DistributionRule."Line No." := DistributionRuleLineNo + 1000;

        DistributionRule."Shortcut Dimension 1 Code" := DistributionLines."Shortcut Dimension 1 Code";
        DistributionRule."Shortcut Dimension 2 Code" := DistributionLines."Shortcut Dimension 2 Code";
        DistributionRule."G/L Account No." := DistributionruleFilter."G/L Account No.";
        DistributionRule."Company Name" := CompanyName;
        DistributionRule.Insert();
        exit(DistributionRule."Line No.");
    end;

    /* Getting Employee Count From Distribution Line*/
    procedure GetEmployeeCountFromDistributionSetup(Year: Text; Month: Text; EmployeeCode: Code[20]; BranchCode: Text): Integer
    var
        Distributionline: Record "JGT Distribution Lines";
        EmpCount: Integer;
    begin
        Distributionline.SetRange(Year, Year);
        Distributionline.SetRange(Month, Month);
        Distributionline.SetRange("Shortcut Dimension 1 Code", EmployeeCode);
        Distributionline.SetFilter("Shortcut Dimension 2 Code", BranchCode);
        if (Distributionline.FindSet() = true) then
            repeat
                Clear(EmpCount);
                EmpCount += 1
            until Distributionline.Next() = 0;
        exit(EmpCount);
    end;

    procedure GetDistributionYear(GlEntryNo: Integer): Text
    var
        GlEntry: Record "G/L Entry";
        DistributionPostingDate: Date;
        PostingDate: Text;
        Month: Text;
        Year: Text;
    begin
        if (GlEntry.Get(GlEntryNo) = true) then begin
            DistributionPostingDate := GLEntry."Posting Date";
            PostingDate := Format(DistributionPostingDate); // 01/10/23
            Year := CopyStr(PostingDate, 7, 8);
            DistributionYear := InsStr(Year, '20', 1);
        end;

        exit(DistributionYear)
    end;

    // procedure GetDistributionMonth(GlEntryNo: Integer): Text
    // var
    //     GlEntry: Record "G/L Entry";
    //     UserPersonalization: Record "User Personalization";
    //     ID: Text;
    //     DistributionPostingDate: Date;
    //     PostingDate: Text;
    //     Month: Text;
    //     Year: Text;
    // begin
    //     ID := UserSecurityId();
    //     if (GlEntry.Get(GlEntryNo) = true) then begin
    //         DistributionPostingDate := GLEntry."Posting Date";
    //         if (UserPersonalization.Get(ID) = true) then
    //             if (UserPersonalization."Locale ID" = 1033) then begin
    //                 PostingDate := Format(DistributionPostingDate); // 11/27/2024(M/D/Y)
    //                 Month := CopyStr(PostingDate, 1, 2);
    //                 DistributionMonth := ConvertingMonthAndYear(Month);
    //             end else begin
    //                 if (UserPersonalization."Locale ID" = 2057) then begin
    //                     PostingDate := Format(DistributionPostingDate); // 27/11/2024(D/M/Y)
    //                     Month := CopyStr(PostingDate, 4, 2);
    //                     DistributionMonth := ConvertingMonthAndYear(Month);
    //                 end;
    //             end;
    //     end;
    //     exit(DistributionMonth);
    // end;

    procedure GetDistributionMonth(GlEntryNo: Integer): Text
    var
        GlEntry: Record "G/L Entry";
        MonthNumber: Integer;
        MonthText: Text;
    begin
        if GlEntry.Get(GlEntryNo) then begin
            MonthNumber := Date2DMY(GlEntry."Posting Date", 2); // 2 = Month

            // Add leading zero if single digit
            if MonthNumber < 10 then
                MonthText := '0' + Format(MonthNumber)
            else
                MonthText := Format(MonthNumber);

            exit(ConvertingMonthAndYear(MonthText));
        end;
        exit('');
    end;

    procedure CreateProjectDistRuleFilter(EntryNo: Integer; DimValueCode: Code[20]; xDimValueCode: Code[20]; GLAccNo: code[20])
    var
        JGTDistProject: Record "JGT Distribution Project";
        DimValue: Record "Dimension Value";
        GLEntry: Record "G/L Entry";
        GenJrnlDebitedAmount: Boolean;
    begin
        Clear(JGTDistProject);
        JGTDistProject.SetRange("Entry No.", EntryNo);
        if DimValueCode <> xDimValueCode then begin
            JGTDistProject.SetRange("Shortcut Dimension 2 Code", xDimValueCode);
            if JGTDistProject.FindSet() then begin
                JGTDistProject.DeleteAll(true);
                if DimValueCode = '' then
                    exit;
            end;
        end;
        JGTDistProject.SetRange("Shortcut Dimension 2 Code", DimValueCode);
        if JGTDistProject.FindSet() then
            Error('Distribution projects lines exists, please delete projects lines.');

        if (GLEntry.Get(EntryNo) = false) then
            exit
        else
            if (GLEntry."Debit Amount" <> 0) then begin
                GenJrnlDebitedAmount := true;
                // DistributionProjectLineInGeneralJournal(EntryNo, DimValueCode, DimValue."Shortcut Dimension 3 Code", GLAccNo, GenJrnlDebitedAmount);
            end;
        // else begin
        //     DimValue.SetRange("Shortcut Dimension 2 Code", DimValueCode);
        //     DimValue.SetRange("Distribute Enable", true);
        //     if DimValue.FindSet() then
        //         repeat
        //             if DimValue."Shortcut Dimension 3 Code" <> '' then
        //                 CreateDistProjectValue(EntryNo, DimValueCode, DimValue."Shortcut Dimension 3 Code", GLAccNo);
        //             if DimValue."Shortcut Dimension 3 Two" <> '' then
        //                 CreateDistProjectValue(EntryNo, DimValueCode, DimValue."Shortcut Dimension 3 Two", GLAccNo);
        //             if DimValue."Shortcut Dimension 3 Three" <> '' then
        //                 CreateDistProjectValue(EntryNo, DimValueCode, DimValue."Shortcut Dimension 3 Three", GLAccNo);
        //         until DimValue.Next() = 0;

        // end;
    end;

    procedure ConvertingMonthAndYear(Month: Text): Text
    var
        MonthDataTxt: Text;
    begin
        case Month of
            '01':
                MonthDataTxt := 'JAN';
            '02':
                MonthDataTxt := 'FEB';
            '03':
                MonthDataTxt := 'MAR';
            '04':
                MonthDataTxt := 'APR';
            '05':
                MonthDataTxt := 'MAY';
            '06':
                MonthDataTxt := 'JUN';
            '07':
                MonthDataTxt := 'JUL';
            '08':
                MonthDataTxt := 'AUG';
            '09':
                MonthDataTxt := 'SEP';
            '10':
                MonthDataTxt := 'OCT';
            '11':
                MonthDataTxt := 'NOV';
            '12':
                MonthDataTxt := 'DEC';
        end;
        exit(MonthDataTxt);
    end;

    procedure DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(EntryNo: Integer; xRecDimensionValue: Code[20]; IntegerValue: Integer): Boolean
    var
        JGTDistributionRule: Record "JGT Distribution Rule";
        JGTDistributionProject: Record "JGT Distribution Project";
    begin
        JGTDistributionProject.SetRange("Entry No.", EntryNo);
        JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", xRecDimensionValue);
        if (JGTDistributionProject.FindSet(false) = true) then
            JGTDistributionProject.DeleteAll()
        else
            exit(true);

        if (IntegerValue = 1) then begin
            JGTDistributionRule.SetRange("Entry No.", EntryNo);
            JGTDistributionRule.SetRange("Shortcut Dimension 2 Code", xRecDimensionValue);
            if (JGTDistributionRule.FindSet(false) = true) then begin
                JGTDistributionRule.DeleteAll();
            end;
        end;
    end;

    procedure GetDimValueAssigned(ShortDimCodeOne: Code[20]; var ShortDimCodeTwo: Code[20]; var ShortDimCodeThree: Code[20])
    var
        GenLedSetup: Record "General Ledger Setup";
        DimValue: Record "Dimension Value";
    begin
        GenLedSetup.Get();
        Clear(ShortDimCodeTwo);
        Clear(ShortDimCodeThree);
        if (DimValue.Get(GenLedSetup."Global Dimension 1 Code", ShortDimCodeOne) = false) then
            exit;

        // ShortDimCodeTwo := DimValue."Shortcut Dimension 2 Code";
        // ShortDimCodeThree := DimValue."Shortcut Dimension 3 Code";
    end;

    procedure UploadDistributionRuleFromExcel(var JGTDistributionRule: Record "JGT Distribution Rule")
    var
        DistRuleFilter: Record "JGT Distribution Rule Filter";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        FileManage: Codeunit "File Management";
        InStm: InStream;
        FromFile: Text[250];
        FileName: Text[250];
        UploadExcelMsg: Text[100];
        SheetName: Text[100];
        SheetVal: Decimal;
        EmployeeCode: Code[20];
        EntryNo: Integer;
        LineNo: Integer;
        MaxRowCount: Integer;
        RowCount: Integer;
        LoopInx: Integer;
    begin
        UploadExcelMsg := 'Please select the excel file.';
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, InStm);
        if FromFile <> '' then begin
            FileName := FileManage.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(InStm);
        end
        else
            Error('No excel file selected.');

        Clear(TempExcelBuffer);
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(InStm, SheetName);
        TempExcelBuffer.ReadSheet();
        Clear(TempExcelBuffer);
        if TempExcelBuffer.FindLast() then
            MaxRowCount := TempExcelBuffer."Row No.";

        Clear(TempExcelBuffer);
        for RowCount := 2 to MaxRowCount do begin
            LoopInx += 1;
            Clear(EntryNo);
            Evaluate(EntryNo, GetValueAtCell(TempExcelBuffer, RowCount, 5));
            if LoopInx = 1 then
                DistRuleFilter.Get(EntryNo);

            JGTDistributionRule.Reset();
            JGTDistributionRule.SetRange("Entry No.", EntryNo);
            Clear(EmployeeCode);
            Evaluate(EmployeeCode, GetValueAtCell(TempExcelBuffer, RowCount, 1));
            JGTDistributionRule.SetRange("Shortcut Dimension 1 Code", EmployeeCode);
            if (JGTDistributionRule.FindFirst() = false) then
                Error('Line entry not found entry no %1 line no %2.', EntryNo, LineNo);

            Clear(SheetVal);
            Evaluate(SheetVal, GetValueAtCell(TempExcelBuffer, RowCount, 4));
            if DistRuleFilter."Negative Allocation" then
                JGTDistributionRule.Validate("Amount Allocated", -SheetVal)
            else
                JGTDistributionRule.Validate("Amount Allocated", SheetVal);

            JGTDistributionRule.Modify(false);
        end;

        if (DistRuleFilter."Dist Single Line Amount" <> true) then
            CombineProjectCodeAndAmountThroughAlocationActionFromExcel(JGTDistributionRule);

        Message('Allocation amount update process completed.');
    end;

    procedure CombineProjectCodeAndAmountThroughAlocationActionFromExcel(JGTDistributionRule: Record "JGT Distribution Rule")
    var
        JGTDistributionProjectLine: Record "JGT Distribution Project Line";
        JGTDistributionProject: Record "JGT Distribution Project";
        BranchCodeList: List of [Text];
        BranchCodeListTwo: List of [Text];
        IntegerOfList: Integer;
        IntegerOfListTwo: Integer;
        CombinedAllcAmount: Decimal;
        DistributionTotalAmount: Decimal;
        ValueOfText: Text;
        BranchCode: Text;
    begin
        JGTDistributionProject.SetRange("Entry No.", JGTDistributionRule."Entry No.");
        JGTDistributionProject.FindFirst();
        JGTDistributionRule.Reset();
        JGTDistributionRule.SetRange("Entry No.", JGTDistributionProject."Entry No.");
        if (JGTDistributionRule.FindSet(false) = true) then
            repeat
                BranchCodeList.Add(JGTDistributionRule."Shortcut Dimension 3 Code");
            until JGTDistributionRule.Next() = 0;

        for IntegerOfList := 1 to BranchCodeList.Count do begin
            ValueOfText := BranchCodeList.Get(IntegerOfList);
            if (BranchCodeListTwo.IndexOf(ValueOfText) = 0) then begin
                BranchCodeListTwo.Add(ValueOfText);
            end;
        end;

        for IntegerOfListTwo := 1 to BranchCodeListTwo.Count do begin
            JGTDistributionProjectLine.Init();
            JGTDistributionProjectLine."Entry No." := JGTDistributionRule."Entry No.";
            JGTDistributionProjectLine."Line No." := JGTDistributionProjectLine."Line No." + 1000;
            JGTDistributionProjectLine."Shortcut Dimension 3 Code" := BranchCodeListTwo.Get(IntegerOfListTwo);

            JGTDistributionRule.Reset();
            JGTDistributionRule.SetRange("Entry No.", JGTDistributionProject."Entry No.");
            JGTDistributionRule.SetRange("Shortcut Dimension 3 Code", JGTDistributionProjectLine."Shortcut Dimension 3 Code");
            if (JGTDistributionRule.FindSet(false) = true) then
                repeat
                    CombinedAllcAmount += JGTDistributionRule."Amount Allocated";
                until JGTDistributionRule.Next() = 0;
            JGTDistributionProjectLine."Amount Allocated" := CombinedAllcAmount;
            DistributionTotalAmount += JGTDistributionProjectLine."Amount Allocated";
            JGTDistributionProjectLine.Insert(false);
            Clear(CombinedAllcAmount);
        end;
    end;

    procedure InDistributionRuleAmountShouldBeUpdatedOnSingleLine("JGT DistributionProject": Record "JGT Distribution Project")
    var
        DistributionRule: Record "JGT Distribution Rule";
        DistributionRulefilter: Record "JGT Distribution Rule Filter";
        DistributionLine: Record "JGT Distribution Lines";
        DistributionProjectLine: Record "JGT Distribution Project line";
        BranchCodeList: List of [Text];
        BranchCodeList2: List of [Text];
        ProjectCodeList: List of [Text];
        ProjectCodeList2: List of [Text];
        ProjectIntegerList: Integer;
        IntegerOfList: Integer;
        IntegerOfListTwo: Integer;
        LineNo: Integer;
        ProjectText: Text;
        ValueOfText: Text;
        BranchCodeTxt: Text;
    begin
        DistributionProjectLine.DeleteAll();
        if (DistributionRulefilter.Get("JGT DistributionProject"."Entry No.") = false) then
            exit;

        DistributionRule.Reset();
        DistributionRule.SetRange("Entry No.", "JGT DistributionProject"."Entry No.");
        if (DistributionRule.FindSet(false) = true) then
            repeat
                BranchCodeList.Add(DistributionRule."Shortcut Dimension 2 Code");
            until DistributionRule.Next() = 0;

        for IntegerOfList := 1 to BranchCodeList.Count do begin
            ValueOfText := BranchCodeList.Get(IntegerOfList);
            if (BranchCodeList2.IndexOf(ValueOfText) = 0) then
                BranchCodeList2.Add(ValueOfText);
        end;

        for IntegerOfListTwo := 1 to BranchCodeList2.count do begin
            BranchCodeTxt := BranchCodeList2.Get(IntegerOfListTwo);

            DistributionRule.Reset();
            DistributionRule.SetRange("Entry No.", "JGT DistributionProject"."Entry No.");
            DistributionRule.SetRange("Shortcut Dimension 2 Code", BranchCodeTxt);
            if (DistributionRule.FindSet(false) = true) then
                repeat
                    ProjectCodeList.Add(DistributionRule."Shortcut Dimension 3 Code");
                until DistributionRule.Next() = 0;

            for ProjectIntegerList := 1 to ProjectCodeList.Count do begin
                ProjectText := ProjectCodeList.Get(ProjectIntegerList);
                if ((ProjectCodeList2.IndexOf(ProjectText) = 0) or (DistributionProjectLine."Shortcut Dimension 2 Code" <> BranchCodeTxt)) then begin
                    ProjectCodeList2.Add(ProjectText);

                    if (DistributionProjectLine.FindLast() = true) then
                        LineNo := DistributionProjectLine."Line No." + 1000
                    else
                        LineNo := 1000;

                    DistributionProjectLine.Init();
                    DistributionProjectLine."Line No." := LineNo;
                    DistributionProjectLine."Entry No." := "JGT DistributionProject"."Entry No.";
                    DistributionProjectLine."Shortcut Dimension 3 Code" := ProjectText;
                    DistributionRule.Reset();
                    DistributionRule.SetRange("Entry No.", "JGT DistributionProject"."Entry No.");
                    DistributionRule.SetRange("Shortcut Dimension 3 Code", ProjectText);
                    DistributionRule.SetRange("Shortcut Dimension 2 Code", BranchCodeTxt);
                    if (DistributionRule.FindSet(false) = true) then
                        repeat
                            DistributionProjectLine."Amount Allocated" += DistributionRule."Amount Allocated";
                        until DistributionRule.Next() = 0;

                    DistributionProjectLine."Shortcut Dimension 2 Code" := BranchCodeTxt;
                    DistributionProjectLine.Insert(false);
                end;
            end;
            Clear(ProjectCodeList2);
            Clear(ProjectCodeList);
        end;
    end;

    procedure DeleteDistributionProjectLinesWhichAmountIsEqualToZero(GLEntryNo: Integer; DistributionProject: Record "JGT Distribution Project"; Integer: Integer)
    var
        DistributionRuleFilter: Record "JGT Distribution Rule Filter";
        Amount: Decimal;
        AddDistAmount: Decimal;
        SubDistAmount: Decimal;
    begin
        if (Integer = 0) then begin
            DistributionProject.SetRange("Entry No.", GLEntryNo);
            if (DistributionProject.FindSet(false) = true) then
                repeat
                    if (DistributionProject."Project Amount" = 0) then
                        DistributionProject.Delete(false);
                until DistributionProject.Next() = 0;
        end else begin
            DistributionProject.SetRange("Entry No.", GLEntryNo);
            if (DistributionProject.FindSet(false) = true) then
                repeat
                    Amount += DistributionProject."Project Amount";
                until DistributionProject.Next() = 0;

            if (DistributionRuleFilter.Get(GLEntryNo) = false) then
                exit;

            if (Amount = 0) then
                exit;

            if (DistributionRuleFilter."Distribution Amount" <> Amount) then
                AddDistAmount := DistributionRuleFilter."Distribution Amount" + 10;
            SubDistAmount := DistributionRuleFilter."Distribution Amount" - 10;
            if ((AddDistAmount >= Amount) or (Amount >= SubDistAmount)) then begin
                if (DistributionProject.FindSet(false) = true) then
                    repeat
                        if (DistributionProject."Project Amount" = 0) then
                            DistributionProject.Delete(false);
                    until DistributionProject.Next() = 0;
            end;
        end;
    end;

    local procedure GetDimValueCode(GLEntry: Record "G/L Entry"; ValNo: Integer): Code[20]
    var
        GenLedSetup: Record "General Ledger Setup";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        GenLedSetup.Get();
        if ValNo = 2 then
            if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 2 Code") then
                exit(DimSetEntry."Dimension Value Code");
        if ValNo = 3 then
            if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 3 Code") then
                exit(DimSetEntry."Dimension Value Code");
    end;

    // procedure DistributeAmountbasedOnBranch(GLEntryNo: Integer)
    // var
    //     JGTDistributionProject: Record "JGT Distribution Project";
    //     JGTDistributionRuleFilter: Record "JGT Distribution Rule Filter";
    //     JGTDistributionProjectTWo: Record "JGT Distribution Project";
    //     DistributionProjectAmount: Decimal;
    //     // DistEmployee: Integer;
    //     TotalSquareFeet: Decimal;
    //     DistAmount: Decimal;
    // begin
    //     // Get Total Sq.Feet for this Entry No.
    //     JGTDistributionProject.Reset();
    //     JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
    //     if JGTDistributionProject.FindSet(false) then begin
    //         Clear(TotalSquareFeet);
    //         repeat
    //             TotalSquareFeet += JGTDistributionProject."Square Feets";
    //         until JGTDistributionProject.Next() = 0;
    //     end;

    //     // Get correct Distribution Amount (only for this Entry No.)
    //     if JGTDistributionRuleFilter.Get(GLEntryNo) then
    //         DistAmount := JGTDistributionRuleFilter."Distribution Amount"
    //     else
    //         Error('No distribution rule found for Entry No. %1', GLEntryNo);

    //     // Calculate Project Amounts
    //     JGTDistributionProject.Reset();
    //     JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
    //     if JGTDistributionProject.FindSet(false) then
    //         repeat
    //             JGTDistributionProject."Project Amount" :=
    //                 Round((DistAmount / TotalSquareFeet) *
    //                       JGTDistributionProject."Square Feets", 0.01);
    //             JGTDistributionProject.Modify(false);
    //         until JGTDistributionProject.Next() = 0;

    //     if ((JGTDistributionRuleFilter."Distribution Amount One" = 0) and (JGTDistributionRuleFilter."Dimension Value One" <> '')) then begin
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value One");
    //         Clear(DistributionProjectAmount);
    //         if (JGTDistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DistributionProjectAmount += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         JGTDistributionRuleFilter."Distribution Amount One" := DistributionProjectAmount;
    //         JGTDistributionRuleFilter.Modify(false);
    //     end;

    //     if ((JGTDistributionRuleFilter."Distribution Amount Two" = 0) and (JGTDistributionRuleFilter."Dimension Value Two" <> '')) then begin
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Two");
    //         Clear(DistributionProjectAmount);
    //         if (JGTDistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DistributionProjectAmount += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         JGTDistributionRuleFilter."Distribution Amount Two" := DistributionProjectAmount;
    //         JGTDistributionRuleFilter.Modify(false);
    //     end;

    //     if ((JGTDistributionRuleFilter."Distribution Amount Three" = 0) and (JGTDistributionRuleFilter."Dimension Value Three" <> '')) then begin
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Three");
    //         Clear(DistributionProjectAmount);
    //         if (JGTDistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DistributionProjectAmount += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         JGTDistributionRuleFilter."Distribution Amount Three" := DistributionProjectAmount;
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value One");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount One");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         end;
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Two");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Two");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionRuleFilter.Modify(false);
    //     end;

    //     if ((JGTDistributionRuleFilter."Distribution Amount Four" = 0) and (JGTDistributionRuleFilter."Dimension Value Four" <> '')) then begin
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Four");
    //         Clear(DistributionProjectAmount);
    //         if (JGTDistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DistributionProjectAmount += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         JGTDistributionRuleFilter."Distribution Amount Four" := DistributionProjectAmount;
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value One");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount One");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Two");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Two");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Three");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Three");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Three" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionRuleFilter.Modify(false);
    //     end;

    //     if ((JGTDistributionRuleFilter."Distribution Amount Five" = 0) and (JGTDistributionRuleFilter."Dimension Value Five" <> '')) then begin
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Five");
    //         Clear(DistributionProjectAmount);
    //         if (JGTDistributionProject.FindSet(false) = true) then
    //             repeat
    //                 DistributionProjectAmount += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;

    //         JGTDistributionRuleFilter."Distribution Amount Five" := DistributionProjectAmount;
    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value One");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount One");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount One" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Two");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Two");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Two" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Three");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Three");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Three" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;

    //         JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", JGTDistributionRuleFilter."Dimension Value Four");
    //         if (JGTDistributionProject.FindSet(false) = true) then begin
    //             Clear(JGTDistributionRuleFilter."Distribution Amount Four");
    //             repeat
    //                 JGTDistributionRuleFilter."Distribution Amount Four" += JGTDistributionProject."Project Amount";
    //             until JGTDistributionProject.Next() = 0;
    //         end;
    //         JGTDistributionRuleFilter.Modify(false);
    //     end;

    //     JGTDistributionProjectTWo.Reset();
    //     JGTDistributionProjectTWo.SetRange("Entry No.", GLEntryNo);
    //     if (JGTDistributionProjectTWo.FindSet(false) = true) then begin
    //         JGTDistributionProjectTWo.CalcSums("Project Amount");
    //         JGTDistributionProjectTWo."Project Total Amount" := JGTDistributionProjectTWo."Project Amount";
    //         JGTDistributionProjectTWo.Modify(false);
    //     end;
    // end;
    procedure DistributeAmountBasedOnBranch(GLEntryNo: Integer)
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        JGTDistributionRuleFilter: Record "JGT Distribution Rule Filter";
        CompanyInformation: Record "Company Information";
        GLEntry: Record "G/L Entry";
        DistAmount: Decimal;
        TotalSquareFeet: Decimal;
        DimValues: array[5] of Code[20];
        DistAmounts: array[5] of Decimal;
        i: Integer;
    begin
        // Get Total Sq.Feet
        TotalSquareFeet := 0;
        JGTDistributionProject.Reset();
        JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
        if JGTDistributionProject.FindSet(false) then
            repeat
                TotalSquareFeet += JGTDistributionProject."Square Feets";
            until JGTDistributionProject.Next() = 0;

        if TotalSquareFeet = 0 then
            Error('No Square Feet found for Entry No. %1', GLEntryNo);

        // Get Distribution Amount
        if not JGTDistributionRuleFilter.Get(GLEntryNo) then
            Error('No distribution rule found for Entry No. %1', GLEntryNo);

        DistAmount := JGTDistributionRuleFilter."Distribution Amount";

        // Calculate per-line Project Amount
        JGTDistributionProject.Reset();
        JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
        if JGTDistributionProject.FindSet(false) then
            repeat
                JGTDistributionProject."Project Amount" :=
                    Round((DistAmount / TotalSquareFeet) * JGTDistributionProject."Square Feets", 0.01);
                if (GlEntry.Get(GLEntryNo) = true) then begin
                    JGTDistributionProject."Posting Date" := GlEntry."Posting Date";
                    JGTDistributionProject."Document No." := GlEntry."Document No.";
                    GlEntry.CalcFields("Account Category");
                    JGTDistributionProject."Account Category" := GlEntry."Account Category";
                end;

                if (CompanyInformation.Get() = true) then
                    JGTDistributionProject."Company Name" := CompanyInformation.Name;

                JGTDistributionProject.Modify(false);
            until JGTDistributionProject.Next() = 0;

        // Collect dimension values from rule filter
        DimValues[1] := JGTDistributionRuleFilter."Dimension Value One";
        DimValues[2] := JGTDistributionRuleFilter."Dimension Value Two";
        DimValues[3] := JGTDistributionRuleFilter."Dimension Value Three";
        DimValues[4] := JGTDistributionRuleFilter."Dimension Value Four";
        DimValues[5] := JGTDistributionRuleFilter."Dimension Value Five";

        // Calculate distribution amounts per dimension
        for i := 1 to ArrayLen(DimValues) do begin
            if DimValues[i] <> '' then begin
                Clear(DistAmounts[i]);
                JGTDistributionProject.Reset();
                JGTDistributionProject.SetRange("Entry No.", GLEntryNo);
                JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", DimValues[i]);
                if JGTDistributionProject.FindSet(false) then
                    repeat
                        DistAmounts[i] += JGTDistributionProject."Project Amount";
                    until JGTDistributionProject.Next() = 0;
            end;
        end;

        // Assign back to rule filter
        JGTDistributionRuleFilter."Distribution Amount One" := DistAmounts[1];
        JGTDistributionRuleFilter."Distribution Amount Two" := DistAmounts[2];
        JGTDistributionRuleFilter."Distribution Amount Three" := DistAmounts[3];
        JGTDistributionRuleFilter."Distribution Amount Four" := DistAmounts[4];
        JGTDistributionRuleFilter."Distribution Amount Five" := DistAmounts[5];
        JGTDistributionRuleFilter.Modify(false);
    end;

    procedure TrueUpdateGLEntryDistributioRuleApplied(GlEntryNo: Integer; DocNo: Code[20]; DimTwoCode: Code[20]; DimOneCode: Code[20];
        GLAccNo: code[20]; VATBusPostingGroup: Code[20]; VATProPostingGroup: code[20];
        GenBuspostingGroup: Code[20]; GenProPostingGroup: code[20])
    var
        GLEntry: Record "G/L Entry";
    begin
        Clear(GLEntry);
        GLEntry.SetCurrentKey("Document No.");
        GLEntry.SetRange("Document No.", DocNo);
        GLEntry.SetRange("Entry No.", GlEntryNo);
        GLEntry.SetFilter("Global Dimension 1 Code", DimOneCode);
        GLEntry.SetFilter("Global Dimension 2 Code", DimTwoCode);
        GLEntry.SetFilter("G/L Account No.", GLAccNo);
        GLEntry.SetFilter("VAT Bus. Posting Group", VATBusPostingGroup);
        GLEntry.SetFilter("VAT Prod. Posting Group", VATProPostingGroup);
        GLEntry.SetFilter("Gen. Bus. Posting Group", GenBuspostingGroup);
        GLEntry.SetFilter("Gen. Prod. Posting Group", GenProPostingGroup);
        if (GLEntry.FindFirst() = true) then begin
            GLEntry."Distributio Rule Applied" := true;
            GLEntry.Modify();
        end;
    end;

    local procedure ProceedDimProjectType(GLEntry: Record "G/L Entry"): Boolean
    var
        GenLedSetup: Record "General Ledger Setup";
        DimSetEntry: Record "Dimension Set Entry";
    begin
        GenLedSetup.Get();
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 8 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 7 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 6 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 5 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 4 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 3 Code") then
            exit(true);
        if DimSetEntry.Get(GLEntry."Dimension Set ID", GenLedSetup."Shortcut Dimension 2 Code") then
            exit(false);
    end;

    var
        DistributionYear: Text;
        DistributionMonth: Text;
        EmployeeCount2: Integer;
}