pageextension 50305 UserSteupExe extends "User Setup"
{
    layout
    {
        addafter("Register Time")
        {

            field(Distribution; Rec.Distribution)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Distribution field.';
            }
        }
    }
}