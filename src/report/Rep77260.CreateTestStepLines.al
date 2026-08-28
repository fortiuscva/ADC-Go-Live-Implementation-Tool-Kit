report 77260 "ADC Create Test Step Lines"
{
    ApplicationArea = All;
    Caption = 'Create Test Step Lines';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    trigger OnPostReport()
    var
        BCTestStepLine: Record "ADC BC Test Step Line";
        TestStepLine: Record "ADC Test Step Line";
        Counter: Integer;
    begin
        Clear(Counter);
        Counter := 0;
        BCTestStepLine.Reset();
        BCTestStepLine.SetFilter("BC Test Case No.", '<>%1', '');
        BCTestStepLine.SetFilter("BC Test Step No.", '<>%1', '');
        if BCTestStepLine.FindFirst() then begin
            repeat
                TestStepLine.Init();
                TestStepLine."Document No." := BCTestStepLine."BC Test Step No.";
                TestStepLine."Line No." := GetNextLineNo(BCTestStepLine."BC Test Step No.");
                TestStepLine.Insert(true);
                TestStepLine."Test Step Description" := BCTestStepLine."Test Step Description";
                TestStepLine.Modify(true);
                Counter += 1;
            until BCTestStepLine.Next() = 0;
        end;
        Message('Created %1 Test Step Lines and associated with Test Steps and Test Cases', Counter);
    end;

    local procedure GetNextLineNo(DocNo: Code[20]): Integer
    var
        TestStepLineLcl: Record "ADC Test Step Line";
    begin
        TestStepLineLcl.Reset();
        TestStepLineLcl.SetRange("Document No.", DocNo);
        if TestStepLineLcl.FindLast() then
            exit(TestStepLineLcl."Line No." + 10000)
        else
            exit(10000);
    end;
}
