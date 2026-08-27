codeunit 77259 "ADC Test Case Assignment Mgt."
{
    procedure CreateLinesForSelectedUsers(TestCaseNo: Code[20]; TestStepID: Code[20]; var TempSelectedUsers: Record "ADC Test Step User Selection" temporary)
    var
        TestCaseLineRecLcl: Record "ADC Test Case Line";
    begin
        TestCaseLineRecLcl.LockTable();

        if TempSelectedUsers.FindSet() then begin
            repeat
                TestCaseLineRecLcl.Init();
                TestCaseLineRecLcl."Document No." := TestCaseNo;
                TestCaseLineRecLcl."Line No." := GetNextLineNo(TestCaseNo);
                TestCaseLineRecLcl.Insert(true);
                TestCaseLineRecLcl.Validate("Step ID", TestStepID);
                TestCaseLineRecLcl.Validate("Assigned To", TempSelectedUsers."User ID");
                TestCaseLineRecLcl.Validate("Assigned Date", Today);
                TestCaseLineRecLcl.Modify(true);
            until TempSelectedUsers.Next() = 0;
        end;

    end;

    local procedure GetNextLineNo(TestCaseNo: Code[20]): Integer
    var
        TestCaseLineLcl: Record "ADC Test Case Line";
    begin
        TestCaseLineLcl.Reset();
        TestCaseLineLcl.SetRange("Document No.", TestCaseNo);

        if TestCaseLineLcl.FindLast() then
            exit(TestCaseLineLcl."Line No." + 10000);

        exit(10000);
    end;
}
