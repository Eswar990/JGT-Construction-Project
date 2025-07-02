table 50300 "JGT Distribution Header"
{
    Caption = 'JGT Distribution Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[10])
        {
            Caption = 'User ID';
        }
        field(2; Year; Code[20])
        {
            Caption = 'Year';
            TableRelation = "Reference Data".Code where(Type = const(Year));
        }
        field(3; Month; Code[20])
        {
            Caption = 'Month';
            TableRelation = "Reference Data".Code where(Type = const(Month));
        }
        field(4; "Previous Year"; Code[20])
        {
            Caption = 'Previous Year';
            TableRelation = "Reference Data".Code where(Type = const(Year));
        }
        field(5; "Previous Month"; Code[20])
        {
            Caption = 'Previous Month';
            TableRelation = "Reference Data".Code where(Type = const(Year));
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}
