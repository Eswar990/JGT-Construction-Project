codeunit 50302 "JGT Dimension Values"
{
    procedure FilterTextDimensionValue(var SelectedDimensionValue: List of [Text]): Text
    var
        FilterText: Text;
        DimValue: Text;
    begin
        // Build filter text for multiple values
        foreach DimValue in SelectedDimensionValue do begin
            if FilterText = '' then
                FilterText := DimValue
            else
                FilterText += '|' + DimValue;
        end;
    end;

    procedure GetDimensionCode(SelectedDimension: Text; FilterText: Text): Code[20]
    var
        JGTDistributionProject: Record "JGT Distribution Project";
    begin
        JGTDistributionProject.Reset();

        case SelectedDimension of
            'BRANCH':
                begin
                    JGTDistributionProject.SetFilter("Shortcut Dimension 1 Code", FilterText);
                    if JGTDistributionProject.FindFirst() then
                        exit(JGTDistributionProject."Shortcut Dimension 1 Code");
                end;

            'PHASE':
                begin
                    JGTDistributionProject.SetFilter("Shortcut Dimension 2 Code", FilterText);
                    if JGTDistributionProject.FindFirst() then
                        exit(JGTDistributionProject."Shortcut Dimension 2 Code");
                end;

            'PROJECT':
                begin
                    JGTDistributionProject.SetFilter("Shortcut Dimension 3 Code", FilterText);
                    if JGTDistributionProject.FindFirst() then
                        exit(JGTDistributionProject."Shortcut Dimension 3 Code");
                end;
        end;

        exit(''); // If nothing found
    end;
}