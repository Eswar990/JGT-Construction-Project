tableextension 50304 DimensionExe extends Dimension
{
    fields
    {
        field(50300; "Dimension Filter"; Boolean)
        {
            Caption = 'Dimension Filter';
            DataClassification = ToBeClassified;

            // trigger OnValidate()
            // var
            //     GeneralLedgerSetup: Record "General Ledger Setup";
            // begin
            //     GeneralLedgerSetup.Get();
            //     if ((GeneralLedgerSetup."Global Dimension 1 Code" <> Rec.Code) or (GeneralLedgerSetup."Global Dimension 2 Code" <> Rec.Code) or (GeneralLedgerSetup."Shortcut Dimension 3 Code" <> Rec.Code)) then
            //         Error('You are not allowed to select this dimension, please contact system administrator.');
            // end;

            trigger OnValidate()
            var
                GeneralLedgerSetup: Record "General Ledger Setup";
            begin
                GeneralLedgerSetup.Get();
                if not (
                        (GeneralLedgerSetup."Global Dimension 1 Code" = Rec.Code) or
                       (GeneralLedgerSetup."Global Dimension 2 Code" = Rec.Code) or
                       (GeneralLedgerSetup."Shortcut Dimension 3 Code" = Rec.Code)) then
                    Error('You are not allowed to select this dimension, please contact system administrator.');
            end;
        }
    }
}