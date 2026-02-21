pageextension 50303 GLAccountCardEx extends "G/L Account Card"
{
    layout
    {
        addafter("Omit Default Descr. in Jnl.")
        {
            field("VAT Account"; Rec."VAT Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Account field.';
            }
            field("Distribution Required"; Rec."Distribution Required")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Distribution Required field.';
            }
            field("Is Asset Distribution"; Rec."Is Asset Distribution")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Is Asset Distribution field.';
            }
        }
    }
}