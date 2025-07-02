codeunit 50300 "JGT Distribution Codeunit"
{
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
}
