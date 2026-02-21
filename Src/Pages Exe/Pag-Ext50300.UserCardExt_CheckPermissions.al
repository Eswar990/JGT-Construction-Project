// pageextension 50300 "UserCardExt_CheckPermissions" extends "User Card"
// {
//     actions
//     {
//         addlast(Processing)
//         {
//             action(CheckGLEntryPermissions)
//             {
//                 Caption = 'Check G/L Entry Permissions';
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 var
//                     CheckPerms: Codeunit "Check G/L Entry Permissions";
//                 begin
//                     CheckPerms.Run();
//                 end;
//             }
//         }
//     }
// }

permissionset 50300 "G/L ENTRY ACCESS"
{
    Assignable = true;
    Permissions = tabledata "G/L Entry" = IMD;
}