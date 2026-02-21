pageextension 50302 DimensionsExe extends Dimensions
{
    layout
    {
        addafter(Blocked)
        {

            field("Dimension Filter"; Rec."Dimension Filter")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension Filter field.';
            }
        }
    }
}