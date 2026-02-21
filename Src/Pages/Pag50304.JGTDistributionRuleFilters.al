page 50304 "JGT Distribution Rule Filters"
{
    ApplicationArea = All;
    Caption = 'JGT Distribution Rule Filters';
    PageType = Card;
    SourceTable = "JGT Distribution Rule Filter";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No"; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No field.', Comment = '%';
                }
                field("Dimension FIlter"; Rec."Dimension FIlter")
                {
                    ToolTip = 'Specifies the value of the Dimension FIlter field.', Comment = '%';
                }
                field("Dimension  Value"; Rec."Dimension Value")
                {
                    ToolTip = 'Specifies the value of the Dimension  Value field.', Comment = '%';
                    Visible = false;
                }
                field("Distribution Method"; Rec."Distribution Method")
                {
                    ToolTip = 'Specifies the value of the Distribution Method field.', Comment = '%';
                }
                field("Distribution Amount"; Rec."Distribution Amount")
                {
                    ToolTip = 'Specifies the value of the Distribution Amount field.', Comment = '%';
                }
                field("Distribution Setup"; Rec."Distribution Setup")
                {
                    ToolTip = 'Specifies the value of the Distribution Setup field.', Comment = '%';
                }
                field("Dist Single Line Amount"; Rec."Dist Single Line Amount")
                {
                    ToolTip = 'Specifies the value of the Dist Single Line Amount field.', Comment = '%';
                }
                field("Distribution Options"; Rec."Distribution Options")
                {
                    ToolTip = 'Specifies the value of the Distribution Options field.', Comment = '%';
                }
            }
            group("Branch Distribution")
            {
                field("Dimension Value One"; Rec."Dimension Value One")
                {

                }
                field("Distribution Amount One"; Rec."Distribution Amount One")
                {

                }
                field("Dimension Value Two"; Rec."Dimension Value Two")
                {

                }
                field("Distribution Amount Two"; Rec."Distribution Amount Two")
                {

                }
                field("Dimension Value Three"; Rec."Dimension Value Three")
                {

                }
                field("Distribution Amount Three"; Rec."Distribution Amount Three")
                {

                }
                field("Dimension Value Four"; Rec."Dimension Value Four")
                {

                }
                field("Distribution Amount Four"; Rec."Distribution Amount Four")
                {

                }
                field("Dimension Value Five"; Rec."Dimension Value Five")
                {

                }
                field("Distribution Amount Five"; Rec."Distribution Amount Five")
                {

                }
            }
            part(DistributionProject; "JGT Distribution Project")
            {
                Caption = 'Project Line';
                SubPageLink = "Entry No." = field("Entry No.");
                Editable = IsEditableDistributionLinkParts;
            }
            part(DistributionRule; "JGT Distribution Rule")
            {
                Caption = 'Project Line';
                SubPageLink = "Entry No." = field("Entry No.");
                Editable = IsEditableDistributionLinkParts;
                Visible = false;
            }

            // part(DistributionProjectLine; "JGT Distribution Project Lines")
            // {
            //     Caption = 'Combined Project Line';
            //     SubPageLink = "Entry No." = field("Entry No.");
            //     Editable = IsEditableDistributionLinkParts;
            // }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Edit Project Line")
            {
                ApplicationArea = All;
                Image = Edit;
                trigger OnAction()
                begin
                    Clear(IsEditableAction);
                    IsEditableAction := true;
                    CurrPage.Update(false);
                end;
            }


            action("Equal Square Feet Distribution")
            {
                ApplicationArea = All;
                Caption = 'Equal Square Feet Distribution';
                Promoted = true;
                PromotedCategory = Process;
                Image = Calculate;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    JGTDistributionLines: Record "JGT Distribution Lines";
                    JGTDistributionProject: Record "JGT Distribution Project";
                    UserCustomizedmanage: Codeunit "JGT Distribution Codeunit";
                    DistributionYear: Code[20];
                    DistributionMonth: Code[20];
                    SelectedDimension: Text;
                    // SelectedDimensionValue: Text;
                    selectedDimensionValue: List of [Text];
                    TotalSquareFeets: Decimal;
                    DistributionAmount: Decimal;
                begin
                    EmployeeDistributionAction := true;
                    VisibilityOfDistributionRuleFilterFileds();

                    // Get G/L Entry
                    if not GLEntry.Get(Rec."Entry No.") then
                        Error('G/L Entry not found');

                    CalRemAmount(GLEntry);
                    CurrPage.DistributionRule.Page.UpdateAmount(Amount, RemAmount);

                    // Get selected dimension from the filter page
                    SelectedDimension := GetSelectedDimension();
                    SelectedDimensionValue := GetSelectedDimensionValues();

                    // Get Distribution Year and Month
                    DistributionYear := UserCustomizedmanage.GetDistributionYear(GLEntry."Entry No.");
                    DistributionMonth := UserCustomizedmanage.GetDistributionMonth(GLEntry."Entry No.");

                    DistributionAmount := Rec."Distribution Amount";

                    // STEP 1: Check if Distribution Project already has lines for this Entry No.
                    JGTDistributionProject.SetRange("Entry No.", Rec."Entry No.");

                    if not JGTDistributionProject.IsEmpty() then begin
                        // Scenario 1: Project lines exist - recalculate amounts based on square feet proportion
                        HandleExistingProjectLinesBySquareFeet(Rec."Entry No.", DistributionYear, DistributionMonth, DistributionAmount);
                    end else begin
                        // Scenario 2: No project lines exist - create new ones based on square feet proportion
                        HandleNewProjectLinesBySquareFeet(GLEntry, SelectedDimension, SelectedDimensionValue, DistributionAmount);
                    end;

                    // Update the main record with distribution amounts
                    UpdateDistributionRuleWithAmounts(Rec."Entry No.", SelectedDimension, SelectedDimensionValue);

                    Message('Equal square feet distribution completed successfully.');
                end;
            }
            action("Equal Unit Distribution")
            {
                ApplicationArea = All;
                Caption = 'Equal Unit Distributions';
                Promoted = true;
                PromotedCategory = Process;
                Image = Line;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    JGTDistributionLines: Record "JGT Distribution Lines";
                    JGTDistributionProject: Record "JGT Distribution Project";
                    DimensionValue: Record "Dimension Value";
                    BranchCodeList: List of [Text];
                    IntegerOfList: Integer;
                    NoOfUnits: Integer;
                    EqualAmount: Decimal;
                    DistributionYear: Code[20];
                    DistributionMonth: Code[20];
                    SelectedDimension: Text;
                    SelectedDimensionValue: List of [Text];
                begin
                    EmployeeDistributionAction := true;
                    VisibilityOfDistributionRuleFilterFileds();

                    GLEntry.Get(Rec."Entry No.");
                    CalRemAmount(GLEntry);
                    CurrPage.DistributionRule.Page.UpdateAmount(Amount, RemAmount);

                    // Get selected dimension from the filter page
                    SelectedDimension := GetSelectedDimension(); // You need to implement this based on your UI
                    SelectedDimensionValue := GetSelectedDimensionValues(); // You need to implement this based on your UI

                    // STEP 1: Check if Distribution Project already has lines for this Entry No.
                    JGTDistributionProject.SetRange("Entry No.", Rec."Entry No.");

                    if not JGTDistributionProject.IsEmpty() then begin
                        // Scenario 1: Project lines exist - recalculate amounts equally
                        HandleExistingProjectLines(JGTDistributionProject, Rec."Distribution Amount");
                    end else begin
                        // Scenario 2: No project lines exist - create new ones based on selected dimension
                        HandleNewProjectLines(GLEntry, SelectedDimension, Format(SelectedDimensionValue), Rec."Distribution Amount");
                    end;

                    // Update the main record with distribution amounts
                    UpdateDistributionRuleWithAmounts(Rec."Entry No.", SelectedDimension, SelectedDimensionValue);

                    Message('Equal unit distribution completed successfully.');
                end;
            }

        }
    }

    procedure InitPageDetails(var GLEntry: Record "G/L Entry")
    begin
        DocNo := GLEntry."Document No.";
        Description := GLEntry.Description;
    end;

    local procedure VisibilityOfDistributionRuleFilterFileds()
    begin
        if (EmployeeDistributionAction = true) then begin
            IsEditableDistributionLinkParts := false;
            IsFieldEditableDistributionMethod := false;
            FieldDimVEdit := false;
        end else
            IsEditableDistributionLinkParts := true;
    end;

    local procedure CalculateRemainingAmount(var GLEntry: Record "G/L Entry"): Boolean
    var
        JGTDistributionRule: Record "JGT Distribution Project";
        DistributionProject: Record "JGT Distribution Project";
        IsBoolean: Boolean;
    begin
        Clear(IsBoolean);
        Clear(DistributionProject);
        DistributionProject.SetRange("Entry No.", GLEntry."Entry No.");
        if (DistributionProject.FindSet(false) = true) then begin
            DistributionProject.CalcSums("Project Amount");
            Amount := DistributionProject."Project Amount";
        end;

        Clear(JGTDistributionRule);
        JGTDistributionRule.SetRange("Entry No.", GLEntry."Entry No.");
        if (JGTDistributionRule.FindSet(false) = true) then begin
            JGTDistributionRule.CalcSums("Project Amount");
            RemAmount := Amount - JGTDistributionRule."Project Amount";
            if ((Amount <> 0) and (JGTDistributionRule."Project Amount" <> 0)) then
                IsBoolean := true;
        end;
        if (IsBoolean = true) then
            IsBoolean := CalculationForMaketrue(Amount, JGTDistributionRule."Project Amount");
        Commit();
        exit(IsBoolean);
    end;

    local procedure CalculationForMaketrue(var ProjectAmount: Decimal; var AmountAllocated: Decimal): Boolean
    var
        IIsBoolean: Boolean;
    begin
        Clear(IIsBoolean);
        if ((Rec."Distribution Amount" = ProjectAmount) and (Rec."Distribution Amount" = AmountAllocated) = true) then begin
            IIsBoolean := true;
        end else begin
            if (((ProjectAmount + 10) > Rec."Distribution Amount") or ((ProjectAmount - 10) > Rec."Distribution Amount") = true) then
                IIsBoolean := true
            else
                IIsBoolean := false;
        end;
        Commit();
        exit(IIsBoolean);
    end;

    local procedure CalRemAmount(GLEntry: Record "G/L Entry")
    var
        JGTDistributionRule: Record "JGT Distribution Rule";
        JGTDistributionProject: Record "JGT Distribution Project";
    begin
        Clear(JGTDistributionProject);
        JGTDistributionProject.SetRange("Entry No.", GLEntry."Entry No.");
        JGTDistributionProject.CalcSums("Project Total Amount");
        Amount := JGTDistributionProject."Project Total Amount";
    end;

    local procedure HandleNewProjectLinesBySquareFeet(GLEntry: Record "G/L Entry"; SelectedDimension: Text; SelectedDimensionValue: List of [Text]; DistributionAmount: Decimal)
    var
        JGTDistributionLines: Record "JGT Distribution Lines";
        JGTDistributionProject: Record "JGT Distribution Project";
        DimensionValue: Record "Dimension Value";
        CompanyInformation: Record "Company Information";
        DistributionYear: Code[20];
        DistributionMonth: Code[20];
        TotalSquareFeets: Decimal;
        LineNo: Integer;
    begin
        // Only proceed if Distribution Setup is enabled
        if not Rec."Distribution Setup" then
            Error('Please enable Distribution Setup as TRUE in Distribution Rule Filter Page.');

        // Get distribution period
        DistributionYear := UserCustomizedmanage.GetDistributionYear(GLEntry."Entry No.");
        DistributionMonth := UserCustomizedmanage.GetDistributionMonth(GLEntry."Entry No.");

        // Set up filter based on selected dimension
        JGTDistributionLines.SetRange(Year, DistributionYear);
        JGTDistributionLines.SetRange(Month, DistributionMonth);

        case SelectedDimension of
            'BRANCH':
                // if SelectedDimensionValue <> '' then
                //     JGTDistributionLines.SetRange("Shortcut Dimension 1 Code", SelectedDimensionValue);
                JGTDistributionLines.SetFilter("Shortcut Dimension 1 Code", Format(SelectedDimensionValue));
            'PROJECT':
                // if SelectedDimensionValue <> '' then
                //     JGTDistributionLines.SetRange("Shortcut Dimension 2 Code", SelectedDimensionValue);
                JGTDistributionLines.SetFilter("Shortcut Dimension 2 Code", Format(SelectedDimensionValue));
            'PHASE':
                // if SelectedDimensionValue <> '' then
                JGTDistributionLines.SetFilter("Shortcut Dimension 3 Code", Format(SelectedDimensionValue));
        //     JGTDistributionLines.SetRange("Shortcut Dimension 3 Code", SelectedDimensionValue);
        end;

        // Calculate total square feet for all matching distribution lines
        if JGTDistributionLines.FindSet() then
            repeat
                TotalSquareFeets += JGTDistributionLines."Square Feets";
            until JGTDistributionLines.Next() = 0;

        if TotalSquareFeets = 0 then
            Error('No distribution lines with square feet found for the selected dimension filter.');

        // Get starting line number
        JGTDistributionProject.SetRange("Entry No.", Rec."Entry No.");
        if JGTDistributionProject.FindLast() then
            LineNo := JGTDistributionProject."Line No." + 10000
        else
            LineNo := 10000;

        // Create project lines with amounts proportional to square feet
        if JGTDistributionLines.FindSet() then
            repeat
                Clear(JGTDistributionProject);
                JGTDistributionProject.Init();
                JGTDistributionProject."Entry No." := Rec."Entry No.";
                JGTDistributionProject.Year := DistributionYear;
                JGTDistributionProject.Month := DistributionMonth;
                JGTDistributionProject."Shortcut Dimension 1 Code" := JGTDistributionLines."Shortcut Dimension 1 Code";
                JGTDistributionProject."Shortcut Dimension 2 Code" := JGTDistributionLines."Shortcut Dimension 2 Code";
                JGTDistributionProject."Shortcut Dimension 3 Code" := JGTDistributionLines."Shortcut Dimension 3 Code";
                JGTDistributionProject."Shortcut Dimension 4 Code" := JGTDistributionLines."Shortcut Dimension 4 Code";
                JGTDistributionProject."Square Feets" := JGTDistributionLines."Square Feets";
                JGTDistributionProject."Posting Date" := GLEntry."Posting Date";
                GLEntry.CalcFields("Account Category");
                JGTDistributionProject."Account Category" := GLEntry."Account Category";
                JGTDistributionProject."Document No." := GLEntry."Document No.";

                if (JGTDistributionProject."Company Name" = '') then begin
                    if (CompanyInformation.Get() = true) then
                        JGTDistributionProject."Company Name" := CompanyInformation.Name
                    else
                        Error('Company Name not found');
                end;
                // Calculate amount based on square feet proportion
                if JGTDistributionLines."Square Feets" > 0 then
                    JGTDistributionProject."Project Amount" := Round(
                        (JGTDistributionLines."Square Feets" / TotalSquareFeets) * DistributionAmount,
                        0.01, '=')
                else
                    JGTDistributionProject."Project Amount" := 0;

                JGTDistributionProject."Project Line" := true;
                JGTDistributionProject."Line No." := LineNo;
                JGTDistributionProject."G/L Account No." := GLEntry."G/L Account No.";

                if not JGTDistributionProject.Insert(true) then
                    Error('Error creating project line: %1', GetLastErrorText());

                LineNo += 10000;
            until JGTDistributionLines.Next() = 0;
    end;

    local procedure HandleExistingProjectLinesBySquareFeet(EntryNo: Integer; DistributionYear: Code[20]; DistributionMonth: Code[20]; DistributionAmount: Decimal)
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        GlEntry: Record "G/L Entry";
        companyinfo: Record "Company Information";
        TotalSquareFeets: Decimal;
    begin
        // Calculate total square feet for all projects with this Entry No.
        JGTDistributionProject.SetRange("Entry No.", EntryNo);
        if JGTDistributionProject.FindSet() then begin
            repeat
                TotalSquareFeets += JGTDistributionProject."Square Feets";
            until JGTDistributionProject.Next() = 0;

            if TotalSquareFeets = 0 then
                Error('No square feet data found for existing project lines.');

            // Update each project amount based on square feet proportion
            JGTDistributionProject.FindSet();
            repeat
                if JGTDistributionProject."Square Feets" > 0 then
                    JGTDistributionProject."Project Amount" := Round(
                        (JGTDistributionProject."Square Feets" / TotalSquareFeets) * DistributionAmount,
                        0.01, '=')
                else
                    JGTDistributionProject."Project Amount" := 0;

                if (GlEntry.Get(EntryNo) = true) then begin
                    JGTDistributionProject."Posting Date" := GlEntry."Posting Date";
                    JGTDistributionProject."Document No." := GlEntry."Document No.";
                    GlEntry.CalcFields("Account Category");
                    JGTDistributionProject."Account Category" := GlEntry."Account Category";
                end;
                if (companyinfo.Get() = true) then
                    JGTDistributionProject."Company Name" := companyinfo.Name;

                JGTDistributionProject.Modify();
            until JGTDistributionProject.Next() = 0;
        end else begin
            Error('No existing project lines found for Entry No. %1', EntryNo);
        end;
    end;

    local procedure HandleExistingProjectLines(var JGTDistributionProject: Record "JGT Distribution Project"; DistributionAmount: Decimal)
    var
        NoOfUnits: Integer;
        EqualAmount: Decimal;
        Glentry: Record "G/L Entry";
        companyinfo: Record "Company Information";
    begin
        // Count existing project lines
        NoOfUnits := JGTDistributionProject.Count();

        if NoOfUnits = 0 then
            exit;

        // Calculate equal amount per unit
        EqualAmount := Round(DistributionAmount / NoOfUnits, 0.01, '=');

        // Update all project lines with equal amount
        if JGTDistributionProject.FindSet(true) then
            repeat
                JGTDistributionProject."Project Amount" := EqualAmount;
                if (GlEntry.Get(JGTDistributionProject."Entry No.") = true) then begin
                    JGTDistributionProject."Posting Date" := GlEntry."Posting Date";
                    JGTDistributionProject."Document No." := GlEntry."Document No.";
                    GlEntry.CalcFields("Account Category");
                    JGTDistributionProject."Account Category" := GlEntry."Account Category";
                end;
                if (companyinfo.Get() = true) then
                    JGTDistributionProject."Company Name" := companyinfo.Name;

                JGTDistributionProject.Modify(true);
            until JGTDistributionProject.Next() = 0;
    end;

    local procedure HandleNewProjectLines(GLEntry: Record "G/L Entry"; SelectedDimension: Text; SelectedDimensionValue: Text; DistributionAmount: Decimal)
    var
        JGTDistributionLines: Record "JGT Distribution Lines";
        JGTDistributionProject: Record "JGT Distribution Project";
        CompanyInformation: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        DistributionYear: Code[20];
        DistributionMonth: Code[20];
        NoOfUnits: Integer;
        EqualAmount: Decimal;
        LineNo: Integer;
    begin
        // Only proceed if Distribution Setup is enabled
        if not Rec."Distribution Setup" then
            Error('Please enable Distribution Setup as TRUE in Distribution Rule Filter Page.');

        // Get distribution period
        DistributionYear := UserCustomizedmanage.GetDistributionYear(GLEntry."Entry No.");
        DistributionMonth := UserCustomizedmanage.GetDistributionMonth(GLEntry."Entry No.");

        // Set up filter based on selected dimension
        JGTDistributionLines.SetRange(Year, DistributionYear);
        JGTDistributionLines.SetRange(Month, DistributionMonth);

        case SelectedDimension of
            'BRANCH':
                if SelectedDimensionValue <> '' then
                    JGTDistributionLines.SetRange("Shortcut Dimension 1 Code", SelectedDimensionValue);
            'PROJECT':
                if SelectedDimensionValue <> '' then
                    JGTDistributionLines.SetRange("Shortcut Dimension 2 Code", SelectedDimensionValue);
            'PHASE':
                if SelectedDimensionValue <> '' then
                    JGTDistributionLines.SetRange("Shortcut Dimension 3 Code", SelectedDimensionValue);
        end;

        // Count units that match the filter
        if JGTDistributionLines.FindSet() then
            repeat
                NoOfUnits += 1;
            until JGTDistributionLines.Next() = 0;

        if NoOfUnits = 0 then
            Error('No distribution lines found for the selected dimension filter.');

        // Calculate equal amount per unit
        EqualAmount := Round(DistributionAmount / NoOfUnits, 0.01, '=');

        // Get starting line number
        JGTDistributionProject.SetRange("Entry No.", Rec."Entry No.");
        if JGTDistributionProject.FindLast() then
            LineNo := JGTDistributionProject."Line No." + 10000
        else
            LineNo := 10000;

        // Create project lines
        if JGTDistributionLines.FindSet() then
            repeat
                Clear(JGTDistributionProject);
                JGTDistributionProject.Init();
                JGTDistributionProject."Entry No." := Rec."Entry No.";
                JGTDistributionProject.Year := DistributionYear;
                JGTDistributionProject.Month := DistributionMonth;
                JGTDistributionProject."Shortcut Dimension 1 Code" := JGTDistributionLines."Shortcut Dimension 1 Code";
                JGTDistributionProject."Shortcut Dimension 2 Code" := JGTDistributionLines."Shortcut Dimension 2 Code";
                JGTDistributionProject."Shortcut Dimension 3 Code" := JGTDistributionLines."Shortcut Dimension 3 Code";
                JGTDistributionProject."Shortcut Dimension 4 Code" := JGTDistributionLines."Shortcut Dimension 4 Code";
                JGTDistributionProject."Square Feets" := JGTDistributionLines."Square Feets";
                JGTDistributionProject."Project Amount" := EqualAmount;
                JGTDistributionProject."Project Line" := true;
                JGTDistributionProject."Line No." := LineNo;
                JGTDistributionProject."G/L Account No." := GLEntry."G/L Account No.";
                JGTDistributionProject."Posting Date" := GLEntry."Posting Date";
                GLEntry.CalcFields("Account Category");
                JGTDistributionProject."Account Category" := GLEntry."Account Category";
                JGTDistributionProject."Document No." := GLEntry."Document No.";
                if (JGTDistributionLines."Company Name" = '') then
                    if (CompanyInformation.Get() = true) then
                        JGTDistributionProject."Company Name" := CompanyInformation.Name
                    else
                        JGTDistributionProject."Company Name" := JGTDistributionLines."Company Name"
                else
                    JGTDistributionProject."Company Name" := JGTDistributionLines."Company Name";

                if not JGTDistributionProject.Insert(true) then
                    Error('Error creating project line: %1', GetLastErrorText());

                LineNo += 10000;
            until JGTDistributionLines.Next() = 0;
    end;

    local procedure UpdateDistributionRuleWithAmounts(EntryNo: Integer; SelectedDimension: Text; SelectedDimensionValue: List of [Text])
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        JGTDistributionProjectTwo: Record "JGT Distribution Project";
        JGTDistributionLines: Record "JGT Distribution Lines";
        JGTDimensionValues: Codeunit "JGT Dimension Values";
        TotalAmount: Decimal;
        DimensionCode: Code[20];
        FilterText: Text;
        DimensionAmount: Decimal;
    begin
        // Clear existing dimension values and amounts
        // Rec."Dimension Value One" := '';
        // Rec."Dimension Value Two" := '';
        // Rec."Dimension Value Three" := '';
        // Rec."Dimension Value Four" := '';
        // Rec."Dimension Value Five" := '';
        Rec."Distribution Amount One" := 0;
        Rec."Distribution Amount Two" := 0;
        Rec."Distribution Amount Three" := 0;
        Rec."Distribution Amount Four" := 0;
        Rec."Distribution Amount Five" := 0;

        // SCENARIO 1: Check if Project Lines exist for this Entry No.
        JGTDistributionProject.SetRange("Entry No.", EntryNo);
        if not JGTDistributionProject.IsEmpty() then begin
            // Project lines exist - calculate based on selected dimension filter
            if (SelectedDimensionValue.Count = 0) then begin
                // No specific dimension value selected - get all unique dimension values from project lines
                UpdateFromProjectLines(EntryNo, SelectedDimension);
            end else begin
                // Filter project lines by selected dimension value and calculate total
                DimensionAmount := CalculateProjectAmountByDimension(EntryNo, SelectedDimension, SelectedDimensionValue);
                FilterText := JGTDimensionValues.FilterTextDimensionValue(SelectedDimensionValue);
                if ((Rec."Dimension Value One" <> '') or (Rec."Dimension Value Two" <> '') or (Rec."Dimension Value Three" <> '') or (Rec."Dimension Value Four" <> '') or (Rec."Dimension Value Five" <> '')) then begin
                    foreach FilterText in SelectedDimensionValue do begin
                        DimensionCode := JGTDimensionValues.GetDimensionCode(SelectedDimension, FilterText);
                        case SelectedDimension of
                            'BRANCH':
                                begin
                                    JGTDistributionProjectTwo.Reset();
                                    JGTDistributionProjectTwo.SetRange("Entry No.", EntryNo);
                                    if (Rec."Dimension Value One" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 1 Code", Rec."Dimension Value One");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount One" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Two" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 1 Code", Rec."Dimension Value Two");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Two" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Three" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 1 Code", Rec."Dimension Value Three");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Three" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Four" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 1 Code", Rec."Dimension Value Four");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Four" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Five" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 1 Code", Rec."Dimension Value Five");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Five" := DimensionAmount;
                                        end;
                                    end;
                                end;
                            'PHASE':
                                begin
                                    JGTDistributionProjectTwo.Reset();
                                    JGTDistributionProjectTwo.SetRange("Entry No.", EntryNo);
                                    if (Rec."Dimension Value One" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 2 Code", Rec."Dimension Value One");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount One" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Two" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 2 Code", Rec."Dimension Value Two");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Two" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Three" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 2 Code", Rec."Dimension Value Three");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Three" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Four" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 2 Code", Rec."Dimension Value Four");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Four" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Five" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 2 Code", Rec."Dimension Value Five");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Five" := DimensionAmount;
                                        end;
                                    end;
                                end;

                            'PROJECT':
                                begin
                                    JGTDistributionProjectTwo.Reset();
                                    JGTDistributionProjectTwo.SetRange("Entry No.", EntryNo);
                                    if (Rec."Dimension Value One" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 3 Code", Rec."Dimension Value One");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount One" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Two" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 3 Code", Rec."Dimension Value Two");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Two" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Three" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 3 Code", Rec."Dimension Value Three");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Three" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Four" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 3 Code", Rec."Dimension Value Four");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Four" := DimensionAmount;
                                        end;
                                    end;
                                    if (Rec."Dimension Value Five" = DimensionCode) then begin
                                        JGTDistributionProjectTwo.SetRange("Shortcut Dimension 3 Code", Rec."Dimension Value Five");
                                        Clear(DimensionAmount);
                                        if (JGTDistributionProjectTwo.FindSet() = true) then begin
                                            repeat
                                                DimensionAmount := DimensionAmount + JGTDistributionProjectTwo."Project Amount";
                                            until JGTDistributionProjectTwo.Next() = 0;
                                            Rec."Distribution Amount Five" := DimensionAmount;
                                        end;
                                    end;
                                end;
                        end;
                    end;
                end
                else begin
                    // SCENARIO 2: No Project Lines exist - get data from Distribution Setup
                    UpdateFromDistributionSetup(EntryNo, SelectedDimension, SelectedDimensionValue);
                end;
            end;
        end;
    end;
    // local procedure CalculateProjectAmountByDimension(EntryNo: Integer; SelectedDimension: Text; SelectedDimensionValue: List of [Text]): Decimal
    // var
    //     JGTDistributionProject: Record "JGT Distribution Project";
    //     TotalAmount: Decimal;
    // begin
    //     TotalAmount := 0;
    //     JGTDistributionProject.SetRange("Entry No.", EntryNo);

    //     // Filter by the selected dimension
    //     case SelectedDimension of
    //         'BRANCH':
    //             JGTDistributionProject.SetRange("Shortcut Dimension 1 Code", Format(SelectedDimensionValue));
    //         'PHASE':
    //             JGTDistributionProject.SetRange("Shortcut Dimension 2 Code", Format(SelectedDimensionValue));
    //         'PROJECT':
    //             JGTDistributionProject.SetRange("Shortcut Dimension 3 Code", Format(SelectedDimensionValue));
    //     end;

    //     if JGTDistributionProject.FindSet() then
    //         repeat
    //             TotalAmount += JGTDistributionProject."Project Amount";
    //         until JGTDistributionProject.Next() = 0;

    //     exit(TotalAmount);
    // end;

    local procedure CalculateProjectAmountByDimension(EntryNo: Integer; SelectedDimension: Text; SelectedDimensionValue: List of [Text]): Decimal
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        JGTDimensionValues: Codeunit "JGT Dimension Values";
        TotalAmount: Decimal;
        FilterText: Text;
        DimValue: Text;
    begin
        TotalAmount := 0;

        JGTDistributionProject.SetRange("Entry No.", EntryNo);

        // Build filter text for multiple values
        FilterText := JGTDimensionValues.FilterTextDimensionValue(SelectedDimensionValue);
        // Apply filter based on selected dimension
        case SelectedDimension of
            'BRANCH':
                JGTDistributionProject.SetFilter("Shortcut Dimension 1 Code", FilterText);
            'PHASE':
                JGTDistributionProject.SetFilter("Shortcut Dimension 2 Code", FilterText);
            'PROJECT':
                JGTDistributionProject.SetFilter("Shortcut Dimension 3 Code", FilterText);
        end;

        if JGTDistributionProject.FindSet() then
            repeat
                TotalAmount += JGTDistributionProject."Project Amount";
            until JGTDistributionProject.Next() = 0;

        exit(TotalAmount);
    end;

    local procedure UpdateFromProjectLines(EntryNo: Integer; SelectedDimension: Text)
    var
        JGTDistributionProject: Record "JGT Distribution Project";
        DimensionAmounts: Dictionary of [Text, Decimal];
        DimensionCode: Text;
        Amount: Decimal;
        Counter: Integer;
    begin
        // Get all project lines and group by the selected dimension
        JGTDistributionProject.SetRange("Entry No.", EntryNo);

        if JGTDistributionProject.FindSet() then
            repeat
                // Get the appropriate dimension code based on selected dimension
                case SelectedDimension of
                    'BRANCH':
                        DimensionCode := JGTDistributionProject."Shortcut Dimension 1 Code";
                    'PHASE':
                        DimensionCode := JGTDistributionProject."Shortcut Dimension 2 Code";
                    'PROJECT':
                        DimensionCode := JGTDistributionProject."Shortcut Dimension 3 Code";
                    else
                        DimensionCode := JGTDistributionProject."Shortcut Dimension 4 Code";
                end;

                if DimensionCode <> '' then begin
                    if DimensionAmounts.ContainsKey(DimensionCode) then
                        DimensionAmounts.Set(DimensionCode, DimensionAmounts.Get(DimensionCode) + JGTDistributionProject."Project Amount")
                    else
                        DimensionAmounts.Add(DimensionCode, JGTDistributionProject."Project Amount");
                end;
            until JGTDistributionProject.Next() = 0;

        // Update dimension values and amounts
        Counter := 0;
        foreach DimensionCode in DimensionAmounts.Keys do begin
            Counter += 1;
            Amount := DimensionAmounts.Get(DimensionCode);

            case Counter of
                1:
                    begin
                        Rec."Dimension Value One" := DimensionCode;
                        Rec."Distribution Amount One" := Amount;
                    end;
                2:
                    begin
                        Rec."Dimension Value Two" := DimensionCode;
                        Rec."Distribution Amount Two" := Amount;
                    end;
                3:
                    begin
                        Rec."Dimension Value Three" := DimensionCode;
                        Rec."Distribution Amount Three" := Amount;
                    end;
                4:
                    begin
                        Rec."Dimension Value Four" := DimensionCode;
                        Rec."Distribution Amount Four" := Amount;
                    end;
                5:
                    begin
                        Rec."Dimension Value Five" := DimensionCode;
                        Rec."Distribution Amount Five" := Amount;
                    end;
            end;
        end;
    end;

    local procedure UpdateFromDistributionSetup(EntryNo: Integer; SelectedDimension: Text; SelectedDimensionValue: list of [Text])
    var
        JGTDistributionLines: Record "JGT Distribution Lines";
        GLEntry: Record "G/L Entry";
        DistributionYear: Code[20];
        DistributionMonth: Code[20];
        DimensionAmounts: Dictionary of [Text, Decimal];
        DimensionCode: Text;
        TotalSquareFeets: Decimal;
        DimensionAmount: Decimal;
        Counter: Integer;
    begin
        // Get G/L Entry and distribution period
        if not GLEntry.Get(EntryNo) then
            exit;

        DistributionYear := UserCustomizedmanage.GetDistributionYear(EntryNo);
        DistributionMonth := UserCustomizedmanage.GetDistributionMonth(EntryNo);

        // Set up distribution lines filter
        JGTDistributionLines.SetRange(Year, DistributionYear);
        JGTDistributionLines.SetRange(Month, DistributionMonth);

        // Apply dimension filter if specified
        if Format(SelectedDimensionValue) <> '' then begin
            case SelectedDimension of
                'BRANCH':
                    JGTDistributionLines.SetRange("Shortcut Dimension 1 Code", Format(SelectedDimensionValue));
                'PROJECT':
                    JGTDistributionLines.SetRange("Shortcut Dimension 2 Code", Format(SelectedDimensionValue));
                'PHASE':
                    JGTDistributionLines.SetRange("Shortcut Dimension 3 Code", Format(SelectedDimensionValue));
            end;
        end;

        // Calculate total square feet and collect dimension amounts
        if JGTDistributionLines.FindSet() then
            repeat
                TotalSquareFeets += JGTDistributionLines."Square Feets";

                // Get dimension code based on selected dimension
                case SelectedDimension of
                    'BRANCH':
                        DimensionCode := JGTDistributionLines."Shortcut Dimension 1 Code";
                    'PROJECT':
                        DimensionCode := JGTDistributionLines."Shortcut Dimension 2 Code";
                    'PHASE':
                        DimensionCode := JGTDistributionLines."Shortcut Dimension 3 Code";
                    else
                        DimensionCode := JGTDistributionLines."Shortcut Dimension 4 Code";
                end;

                if DimensionCode <> '' then begin
                    if not DimensionAmounts.ContainsKey(DimensionCode) then
                        DimensionAmounts.Add(DimensionCode, 0);
                end;
            until JGTDistributionLines.Next() = 0;

        // Calculate and set amounts
        if Format(SelectedDimensionValue) <> '' then begin
            // Single dimension value - distribute total amount
            Rec."Dimension Value One" := Format(SelectedDimensionValue);
            Rec."Distribution Amount One" := Rec."Distribution Amount";
        end else begin
            // Multiple dimension values - distribute based on square feet proportion
            Counter := 0;
            foreach DimensionCode in DimensionAmounts.Keys do begin
                Counter += 1;
                if TotalSquareFeets > 0 then begin
                    // Calculate amount proportion based on square feet
                    JGTDistributionLines.Reset();
                    JGTDistributionLines.SetRange(Year, DistributionYear);
                    JGTDistributionLines.SetRange(Month, DistributionMonth);

                    case SelectedDimension of
                        'BRANCH':
                            JGTDistributionLines.SetRange("Shortcut Dimension 1 Code", DimensionCode);
                        'PROJECT':
                            JGTDistributionLines.SetRange("Shortcut Dimension 3 Code", DimensionCode);
                        'PHASE':
                            JGTDistributionLines.SetRange("Shortcut Dimension 4 Code", DimensionCode);
                    end;

                    DimensionAmount := 0;
                    if JGTDistributionLines.FindSet() then
                        repeat
                            DimensionAmount += (Rec."Distribution Amount" / TotalSquareFeets) * JGTDistributionLines."Square Feets";
                        until JGTDistributionLines.Next() = 0;

                    case Counter of
                        1:
                            begin
                                Rec."Dimension Value One" := DimensionCode;
                                Rec."Distribution Amount One" := Round(DimensionAmount, 0.01, '=');
                            end;
                        2:
                            begin
                                Rec."Dimension Value Two" := DimensionCode;
                                Rec."Distribution Amount Two" := Round(DimensionAmount, 0.01, '=');
                            end;
                        3:
                            begin
                                Rec."Dimension Value Three" := DimensionCode;
                                Rec."Distribution Amount Three" := Round(DimensionAmount, 0.01, '=');
                            end;
                        4:
                            begin
                                Rec."Dimension Value Four" := DimensionCode;
                                Rec."Distribution Amount Four" := Round(DimensionAmount, 0.01, '=');
                            end;
                        5:
                            begin
                                Rec."Dimension Value Five" := DimensionCode;
                                Rec."Distribution Amount Five" := Round(DimensionAmount, 0.01, '=');
                            end;
                    end;
                end;
            end;
        end;
    end;


    // You need to implement these based on your UI controls
    local procedure GetSelectedDimension(): Text
    begin
        // Return the selected dimension from your filter page
        // Example: return 'BRANCH', 'PROJECT', or 'PHASE'
        exit(Rec."Dimension Filter"); // Replace with actual implementation
    end;

    // local procedure GetSelectedDimensionValue(): Text
    // begin
    //     // Return the selected dimension value from your filter page
    //     // Example: return 'BR001', 'SMKA', 'PHASE1', etc.

    //     exit(Rec."Dimension Value One", Rec."Dimension Value Two", Rec."Dimension Value Three", Rec."Dimension Value Four", Rec."Dimension Value Five"); // Replace with actual implementation
    // end;

    local procedure GetSelectedDimensionValues(): List of [Text]
    var
        DimList: List of [Text];
    begin
        if Rec."Dimension Value One" <> '' then
            DimList.Add(Rec."Dimension Value One");

        if Rec."Dimension Value Two" <> '' then
            DimList.Add(Rec."Dimension Value Two");

        if Rec."Dimension Value Three" <> '' then
            DimList.Add(Rec."Dimension Value Three");

        if Rec."Dimension Value Four" <> '' then
            DimList.Add(Rec."Dimension Value Four");

        if Rec."Dimension Value Five" <> '' then
            DimList.Add(Rec."Dimension Value Five");

        exit(DimList);
    end;


    trigger OnOpenPage()
    begin
        FieldEditable := true;
        FieldDimVEdit := true;
        IsEditableDistributionLinkParts := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        GLEntry: Record "G/L Entry";
        xRecDimValue: Code[20];
        JgtProj: Page "JGT Distribution Project";
    begin

        if Rec."Dimension Value" = '' then
            FieldDimVEdit := true;

        GLEntry.Get(Rec."Entry No.");
        CalRemAmount(GLEntry);
        if (GLEntry."Distributio Rule Applied" = true) then begin
            FieldDimVEdit := false;
            IsEditableDistributionLinkParts := false;
        end;

        if Rec."Sales Invoice" then begin
            Rec."Distribution Amount" := GLEntry."Credit Amount";
            Rec."Distribution Method" := Rec."Distribution Method"::Manually;
            FieldEditable := false;
            IsFieldEditableDistributionMethod := false;
            if Rec."Distribution Amount" = 0 then
                Rec."Distribution Amount" := GLEntry."Credit Amount";
        end
        else
            Rec."Distribution Amount" := GLEntry."Debit Amount";

        if not Rec."Sales Invoice" then
            if Rec."Dimension Filter Exsist" then begin
                FieldEditable := false;
                IsFieldEditableDistributionMethod := true;
            end
            else
                IsFieldEditableDistributionMethod := true;

        if Rec."G/L Account No." <> '' then begin
            FieldGLVisible := true;
            GLAccNo := Rec."G/L Account No.";
            GLAccName := GLEntry."G/L Account Name";
        end;

        if Rec."Dimension Value" <> '' then begin
            xRecDimValue := Rec."Dimension Value";
            Rec.Validate("Dimension Value", '');
            if Rec."Dimension Value One" = '' then begin
                Rec."Dimension Value One" := xRecDimValue;
                Rec."Distribution Amount One" := Rec."Distribution Amount";
            end;
        end;

        if (Rec."Distribution Method" = Rec."Distribution Method"::Manually) then
            IsVisibleEmployeeDistributionAction := false
        else
            IsVisibleEmployeeDistributionAction := true;

        if (Rec."Dist Single Line Amount" = false) then
            IsVisibleDistributionRule := true;

        Rec.Modify();
        CurrPage.DistributionRule.Page.UpdateAmount(Amount, RemAmount);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        GLEntry: Record "G/L Entry";
        IsBoolean: Boolean;
    begin
        GLEntry.Get(Rec."Entry No.");
        if (IsEditableAction = true) then begin
            UserCustomizedmanage.FalseUpdateGLEntryDistributioRuleApplied(GLEntry."Entry No.", GLEntry."Document No.", GLEntry."Global Dimension 2 Code",
                GLEntry."Global Dimension 1 Code", Rec."G/L Account No.", GLEntry."VAT Bus. Posting Group", GLEntry."VAT Prod. Posting Group", GLEntry."Gen. Bus. Posting Group", GLEntry."Gen. Prod. Posting Group");
        end else begin
            IsBoolean := CalculateRemainingAmount(GLEntry);
            if (IsBoolean = false) then begin
                Message('Distribution amount not fully applied.');
                UserCustomizedmanage.FalseUpdateGLEntryDistributioRuleApplied(GLEntry."Entry No.", GLEntry."Document No.", GLEntry."Global Dimension 2 Code",
                    GLEntry."Global Dimension 1 Code", Rec."G/L Account No.", GLEntry."VAT Bus. Posting Group", GLEntry."VAT Prod. Posting Group", GLEntry."Gen. Bus. Posting Group", GLEntry."Gen. Prod. Posting Group");
            end else begin
                UserCustomizedmanage.TrueUpdateGLEntryDistributioRuleApplied(GLEntry."Entry No.", GLEntry."Document No.", GLEntry."Global Dimension 2 Code",
                GLEntry."Global Dimension 1 Code", Rec."G/L Account No.", GLEntry."VAT Bus. Posting Group", GLEntry."VAT Prod. Posting Group", GLEntry."Gen. Bus. Posting Group", GLEntry."Gen. Prod. Posting Group");
            end;
        end;
    end;

    var
        UserCustomizedmanage: Codeunit "JGT Distribution Codeunit";
        DistributionYear: Text;
        DistributionMonth: Text;
        GLAccName: Text[100];
        Description: Text[100];
        DocNo: Code[20];
        GLAccNo: Code[20];
        Amount: Decimal;
        RemAmount: Decimal;
        FieldEditable: Boolean;
        IsFieldEditableDistributionMethod: Boolean;
        FieldGLVisible: Boolean;
        FieldDimVEdit: Boolean;
        IsVisibleEmployeeDistributionAction: Boolean;
        IsVisibleConsildationfield: Boolean;
        IsEditableDistributionLinkParts: Boolean;
        EmployeeDistributionAction: Boolean;
        IsVisibleDistributionRule: Boolean;
        IsEditableAction: Boolean;
}