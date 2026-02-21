codeunit 50301 "Consolidation Company"
{
    trigger OnRun()
    begin
        ImportCustomData();
    end;

    procedure ImportCustomData()
    var
        SourceDistProject: Record "JGT Distribution Project";
        TargetDistProject: Record "JGT Distribution Project";
        LastLineNo: Integer;
        SourceCompanyName: Text[100];
        CompanyIn: Record "Company Information";
    begin
        // Capture source company name
        SourceCompanyName := CompanyName;

        // Get source company information
        CompanyIn.Get();

        // Switch to Consolidation Company
        TargetDistProject.ChangeCompany('Asset JGT Group Consolidation');

        // ============================
        // DELETE EXISTING DATA
        // ============================
        TargetDistProject.Reset();
        TargetDistProject.SetRange("Company Name", CompanyIn.Name);
        if (TargetDistProject.FindSet(false) = true) then begin
            TargetDistProject.DeleteAll(true);
        end;

        // ============================
        // GET LAST LINE NO.
        // ============================
        TargetDistProject.Reset();
        if TargetDistProject.FindLast() then
            LastLineNo := TargetDistProject."Line No."
        else
            LastLineNo := 0;

        // ============================
        // READ SOURCE DATA
        // ============================
        SourceDistProject.Reset();
        if not SourceDistProject.FindSet() then
            Error('No Distribution Project data found in source company.');

        repeat
            TargetDistProject.Init();
            TargetDistProject.TransferFields(SourceDistProject);

            LastLineNo += 10000;
            TargetDistProject."Line No." := LastLineNo;


            // Ensure Company Name is populated
            if TargetDistProject."Company Name" = '' then
                TargetDistProject."Company Name" := CompanyIn.Name;

            TargetDistProject.Insert(true);
        until SourceDistProject.Next() = 0;

        Message(
          'Distribution Project data consolidated successfully from %1.',
          SourceCompanyName);
    end;
}
