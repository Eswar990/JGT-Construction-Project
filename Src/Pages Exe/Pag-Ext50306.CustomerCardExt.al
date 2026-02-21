pageextension 50306 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Invoice No. Series"; Rec."Invoice No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
}