codeunit 50300 "JGT Distribution Codeunit"
{
    procedure GetFieldCaption(Inx: Integer; FieldNoTxt: Text): Text[100]

    var
        GenLedSetup: Record "General Ledger Setup";
        Dim: Record Dimension;
    begin
        GenLedSetup.Get();
        GenLedSetup.TestField("Shortcut Dimension 3 Code");
        if (Inx = 3) then
            if Dim.Get(GenLedSetup."Shortcut Dimension 3 Code") then
                if FieldNoTxt = '' then
                    exit(Dim.Name)
                else
                    exit(Dim.Name + ' ' + FieldNoTxt);

        if (Inx = 4) then
            if Dim.Get(GenLedSetup."Shortcut Dimension 4 Code") then
                exit(Dim.Name);

        if (Inx = 5) then
            if Dim.Get(GenLedSetup."Shortcut Dimension 5 Code") then
                exit(Dim.Name);
    end;
}
