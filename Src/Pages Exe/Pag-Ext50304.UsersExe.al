// pageextension 50304 UsersExe extends Users
// {
//     actions
//     {
//         addlast(Processing)
//         {
//             action("CheckGLEntryPermissions")
//             {
//                 Caption = 'Check G/L Entry Permissions';
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 var
//                     CheckGLEntryPermissions: Codeunit "Check G/L Entry Permissions";
//                 begin
//                     CheckGLEntryPermissions.Run();
//                 end;
//             }
//         }
//     }
// }
