table 50303 "JGT Distribution Rule Filter"
{
    Caption = 'JGT Distribution Rule Filter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No';
        }
        field(2; "Dimension Filter"; Code[20])
        {
            Caption = 'Dimension';
            TableRelation = Dimension.Code where("Dimension Filter" = const(true));
            // TableRelation = Dimension;
            trigger OnValidate()
            begin
                Rec.Validate("Dimension Value", '');
            end;
        }
        field(3; "Dimension Value"; Code[20])
        {
            Caption = 'Dimension  Value';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                UserCustManage.CreateProjectDistRuleFilter(Rec."Entry No.", Rec."Dimension Value", xRec."Dimension Value", Rec."G/L Account No.");
            end;
        }
        field(4; "Distribution Method"; Option)
        {
            Caption = 'Distribution Method';
            OptionMembers = " ",Manually;
        }
        field(5; "Negative Allocation"; Boolean)
        {
            Caption = 'Negative Allocation';
        }
        field(6; "Sales Invoice"; Boolean)
        {
            Caption = 'Sales Invoice';
        }
        field(7; "G/L Amount"; Decimal)
        {
            Caption = 'G/L Amount';
        }
        field(8; "Distribution Amount"; Decimal)
        {
            Caption = 'Distribution Amount';
            Editable = false;
        }
        field(9; "Dimension Filter Exsist"; Boolean)
        {
            Caption = 'Dimension Filter Exsist';
            Editable = false;
        }
        field(10; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
        }
        field(11; "Dimension Value One"; Code[20])
        {
            Caption = 'Dimension Value One';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                /* In this Dimension Will give only Respected Dimension Values*/

                if ((Rec."Distribution Method" = Rec."Distribution Method"::Manually)) then begin
                    if ("Distribution Setup" = true) then begin
                        if (Rec."Sales Invoice" = true) then begin
                            if ((Rec."Distribution Options" = Rec."Distribution Options"::"Single Project") or (Rec."Distribution Options" = Rec."Distribution Options"::"Multiple Project")) then begin
                                if (("Dimension Value One" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value One", xRec."Dimension Value One", Rec."G/L Account No.", 1, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value One" <> Rec."Dimension Value Two") or (Rec."Dimension Value One" <> Rec."Dimension Value Three") or (Rec."Dimension Value One" <> Rec."Dimension Value Four") or (Rec."Dimension Value One" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value One", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value One");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value One" <> Rec."Dimension Value One") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value One", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end else
                                Error('Please Fill Distribution Options Either Single Project Or Multiple Project');
                        end else begin
                            if (Rec."Sales Invoice" = false) then begin
                                if (("Dimension Value One" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value One", xRec."Dimension Value One", Rec."G/L Account No.", 1, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value One" <> Rec."Dimension Value Two") or (Rec."Dimension Value One" <> Rec."Dimension Value Three") or (Rec."Dimension Value One" <> Rec."Dimension Value Four") or (Rec."Dimension Value One" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value One", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value One");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value One" <> Rec."Dimension Value One") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value One", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end;
                        end;
                    end else
                        Error('Distribution Setup Must be True');
                end else
                    Error('Please Fill Distribution Method Manually');
            end;

        }
        field(12; "Distribution Amount One"; Decimal)
        {
            Caption = 'Distribution Amount One';
            trigger OnValidate()
            begin
                CheckDistributionAmounts();
            end;
        }
        field(13; "Dimension Value Two"; Code[20])
        {
            Caption = 'Dimension Value Two';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                /* In this Dimension Will give only Respected Dimension Values*/

                if ((Rec."Distribution Method" = Rec."Distribution Method"::Manually)) then begin
                    if ("Distribution Setup" = true) then begin
                        if (Rec."Sales Invoice" = true) then begin
                            if ((Rec."Distribution Options" = Rec."Distribution Options"::"Single Project") or (Rec."Distribution Options" = Rec."Distribution Options"::"Multiple Project")) then begin
                                if (("Dimension Value Two" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Two", xRec."Dimension Value Two", Rec."G/L Account No.", 2, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Two" <> Rec."Dimension Value One") or (Rec."Dimension Value Two" <> Rec."Dimension Value Three") or (Rec."Dimension Value Two" <> Rec."Dimension Value Four") or (Rec."Dimension Value Two" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Two", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Two");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Two" <> Rec."Dimension Value Two") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Two", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end else
                                Error('Please Fill Distribution Options Either Single Project Or Multiple Project');
                        end else begin
                            if (Rec."Sales Invoice" = false) then begin
                                if (("Dimension Value Two" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Two", xRec."Dimension Value Two", Rec."G/L Account No.", 2, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Two" <> Rec."Dimension Value One") or (Rec."Dimension Value Two" <> Rec."Dimension Value Three") or (Rec."Dimension Value Two" <> Rec."Dimension Value Four") or (Rec."Dimension Value Two" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Two", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Two");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Two" <> Rec."Dimension Value Two") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Two", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end;
                        end;
                    end else
                        Error('Distribution Setup Must be True');
                end else
                    Error('Please Fill Distribution Method Manually');
            end;

        }
        field(14; "Distribution Amount Two"; Decimal)
        {
            Caption = 'Distribution Amount Two';
            trigger OnValidate()
            begin
                CheckDistributionAmounts();
            end;
        }
        field(15; "Dimension Value Three"; Code[20])
        {
            Caption = 'Dimension Value Three';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                /* In this Dimension Will give only Respected Dimension Values*/

                if ((Rec."Distribution Method" = Rec."Distribution Method"::Manually)) then begin
                    if ("Distribution Setup" = true) then begin
                        if (Rec."Sales Invoice" = true) then begin
                            if ((Rec."Distribution Options" = Rec."Distribution Options"::"Single Project") or (Rec."Distribution Options" = Rec."Distribution Options"::"Multiple Project")) then begin
                                if (("Dimension Value Three" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Three", xRec."Dimension Value Three", Rec."G/L Account No.", 3, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Three" <> Rec."Dimension Value One") or (Rec."Dimension Value Three" <> Rec."Dimension Value Two") or (Rec."Dimension Value Three" <> Rec."Dimension Value Four") or (Rec."Dimension Value Three" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Three", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Three");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Three" <> Rec."Dimension Value Three") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Three", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end else
                                Error('Please Fill Distribution Options Either Single Project Or Multiple Project');
                        end else begin
                            if (Rec."Sales Invoice" = false) then begin
                                if (("Dimension Value Three" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Three", xRec."Dimension Value Three", Rec."G/L Account No.", 3, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Three" <> Rec."Dimension Value One") or (Rec."Dimension Value Three" <> Rec."Dimension Value Two") or (Rec."Dimension Value Three" <> Rec."Dimension Value Four") or (Rec."Dimension Value Three" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Three", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Three");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Three" <> Rec."Dimension Value Three") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Three", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end;
                        end;
                    end else
                        Error('Distribution Setup Must be True');
                end else
                    Error('Please Fill Distribution Method Manually');
            end;
        }

        field(16; "Distribution Amount Three"; Decimal)
        {
            Caption = 'Distribution Amount Three';
            trigger OnValidate()
            begin
                CheckDistributionAmounts();
            end;
        }
        field(17; "Dimension Value Four"; Code[20])
        {
            Caption = 'Dimension Value Four';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                /* In this Dimension Will give only Respected Dimension Values*/

                if ((Rec."Distribution Method" = Rec."Distribution Method"::Manually)) then begin
                    if ("Distribution Setup" = true) then begin
                        if (Rec."Sales Invoice" = true) then begin
                            if ((Rec."Distribution Options" = Rec."Distribution Options"::"Single Project") or (Rec."Distribution Options" = Rec."Distribution Options"::"Multiple Project")) then begin
                                if (("Dimension Value Four" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Four", xRec."Dimension Value Four", Rec."G/L Account No.", 4, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Four" <> Rec."Dimension Value One") or (Rec."Dimension Value Four" <> Rec."Dimension Value Two") or (Rec."Dimension Value Four" <> Rec."Dimension Value Three") or (Rec."Dimension Value Four" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Four", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Four");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Four" <> Rec."Dimension Value Four") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Four", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end else
                                Error('Please Fill Distribution Options Either Single Project Or Multiple Project');
                        end else begin
                            if (Rec."Sales Invoice" = false) then begin
                                if (("Dimension Value Four" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Four", xRec."Dimension Value Four", Rec."G/L Account No.", 4, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Four" <> Rec."Dimension Value One") or (Rec."Dimension Value Four" <> Rec."Dimension Value Two") or (Rec."Dimension Value Four" <> Rec."Dimension Value Three") or (Rec."Dimension Value Four" <> Rec."Dimension Value Five")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Four", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Four");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Four" <> Rec."Dimension Value Four") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Four", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end;
                        end;
                    end else
                        Error('Distribution Setup Must be True');
                end else
                    Error('Please Fill Distribution Method Manually');
            end;
        }
        field(18; "Distribution Amount Four"; Decimal)
        {
            Caption = 'Distribution Amount Four';
            trigger OnValidate()
            begin
                CheckDistributionAmounts();
            end;
        }
        field(19; "Dimension Value Five"; Code[20])
        {
            Caption = 'Dimension Value Five';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Filter"));
            trigger OnValidate()
            begin
                /* In this Dimension Will give only Respected Dimension Values*/

                if ((Rec."Distribution Method" = Rec."Distribution Method"::Manually)) then begin
                    if ("Distribution Setup" = true) then begin
                        if (Rec."Sales Invoice" = true) then begin
                            if ((Rec."Distribution Options" = Rec."Distribution Options"::"Single Project") or (Rec."Distribution Options" = Rec."Distribution Options"::"Multiple Project")) then begin
                                if (("Dimension Value Five" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Five", xRec."Dimension Value Five", Rec."G/L Account No.", 5, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Five" <> Rec."Dimension Value One") or (Rec."Dimension Value Five" <> Rec."Dimension Value Two") or (Rec."Dimension Value Five" <> Rec."Dimension Value Three") or (Rec."Dimension Value Five" <> Rec."Dimension Value Four")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Five", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Five");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Five" <> Rec."Dimension Value Five") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Five", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end else
                                Error('Please Fill Distribution Options Either Single Project Or Multiple Project');
                        end else begin
                            if (Rec."Sales Invoice" = false) then begin
                                if (("Dimension Value Five" <> '')) then
                                    UserCustManage.CreateProjectDistFromDistributionLine(Rec."Entry No.", Rec."Dimension Value Five", xRec."Dimension Value Five", Rec."G/L Account No.", 5, Rec."Dimension Filter")
                                else begin
                                    if ((Rec."Dimension Value Five" <> Rec."Dimension Value One") or (Rec."Dimension Value Five" <> Rec."Dimension Value Two") or (Rec."Dimension Value Five" <> Rec."Dimension Value Three") or (Rec."Dimension Value Five" <> Rec."Dimension Value Four")) then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Five", 0);
                                        if (IsBoolean = false) then
                                            Error('%1 Dimension value already exist', "Dimension Value Five");
                                    end;

                                    Clear(IsBoolean);
                                    if (xRec."Dimension Value Five" <> Rec."Dimension Value Five") then begin
                                        IsBoolean := UserCustManage.DeleteAndSendErrorDistributionProjectAndDistributionRuleLines(Rec."Entry No.", xRec."Dimension Value Five", 1);
                                        if (IsBoolean = false) then
                                            Message('Distribution Project and Distribution Rule Lines are Deleted');
                                    end;

                                    Clear(IsBoolean);
                                end;
                            end;
                        end;
                    end else
                        Error('Distribution Setup Must be True');
                end else
                    Error('Please Fill Distribution Method Manually');
            end;
        }

        field(20; "Distribution Amount Five"; Decimal)
        {
            Caption = 'Distribution Amount Five';
            trigger OnValidate()
            begin
                CheckDistributionAmounts();
            end;
        }
        field(21; "Distribution Setup"; Boolean)
        {
            Caption = 'Distribution Setup';
        }
        field(22; "Dist Single Line Amount"; Boolean)
        {
            Caption = 'Dist Single Line Amount';
        }
        field(23; "Distribution Options"; Option)
        {
            Caption = 'Distribution Options';
            OptionMembers = "","Single Project","Multiple Project";
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    local procedure CheckDistributionAmounts()
    var
        DimensionAmount: Decimal;
    begin
        DimensionAmount := ((Rec."Distribution Amount One") + (Rec."Distribution Amount Two") + (Rec."Distribution Amount Three") + (Rec."Distribution Amount Four") + (Rec."Distribution Amount Five"));
        if (DimensionAmount > Rec."Distribution Amount") then
            Error('Please Check The Distribution Amount');
    end;

    var
        UserCustManage: Codeunit "JGT Distribution Codeunit";
        IsBoolean: Boolean;
}
