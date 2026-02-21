permissionset 50301 "JGT Distribution - F"
{
    Assignable = true;
    Caption = 'JGT Distribution - Full Access', MaxLength = 30;
    Permissions = table "JGT Distribution Header" = X,
        tabledata "JGT Distribution Header" = RMID,
        table "JGT Distribution Lines" = X,
        tabledata "JGT Distribution Lines" = RMID,
        table "Reference Data" = X,
        tabledata "Reference Data" = RMID,
        table "JGT Distribution Rule Filter" = X,
        tabledata "JGT Distribution Rule Filter" = RMID,
        table "JGT Distribution Rule" = X,
        tabledata "JGT Distribution Rule" = RMID,
        table "JGT Distribution Project line" = X,
        tabledata "JGT Distribution Project line" = RMID,
        table "JGT Distribution Project Lines" = X,
        tabledata "JGT Distribution Project Lines" = RMID,
        table "JGT Distribution Project" = X,
        tabledata "JGT Distribution Project" = RMID,
        page "JGT Distribution Setup" = X,
        page "JGT Distribution Lines" = X,
        page "Reference Data List" = X,
        page "JGT Distribution Entries" = X,
        page "JGT Distribution Project" = X,
        page "JGT Distribution Rule" = X,
        page "JGT Distribution Project Lines" = X,
        page "JGT Distribution Project API" = X,
        page "JGT Distribution Rule Filters" = X,
        report "JGT Distribution Analysis" = X,
        codeunit "JGT Distribution Codeunit" = X;
}