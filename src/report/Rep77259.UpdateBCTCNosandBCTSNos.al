report 77259 "Update BC TC Nos and BC TS Nos"
{
    ApplicationArea = All;
    Caption = 'Update BC Test Case Nos. and BC Test Step Nos.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(TestCaseHeader; "ADC Test Case Header")
        {
            DataItemTableView = where(Description = filter(<> ''));

            trigger OnAfterGetRecord()
            var
                BCStepLine: Record "ADC BC Test Step Line";
                ADCStepHeader: Record "ADC Test Step Header";
            begin
                BCStepLine.Reset();
                BCStepLine.SetRange(Description, TestCaseHeader.Description);
                BCStepLine.ModifyAll("BC Test Case No.", TestCaseHeader."No.");

                ADCStepHeader.Reset();
                ADCStepHeader.SetRange(Description, TestCaseHeader.Description);
                if ADCStepHeader.FindFirst() then begin
                    BCStepLine.Reset();
                    BCStepLine.SetRange(Description, TestCaseHeader.Description);
                    BCStepLine.ModifyAll("BC Test Case No.", ADCStepHeader."No.");
                end;
                Counter += 1;
            end;
        }
    }
    trigger OnPreReport()
    begin
        Clear(Counter);
        Counter := 0;
    end;

    trigger OnPostReport()
    begin
        Message('Updated BC Test Case Nos. and BC Test Step Nos. to %1 BC Test Step Line Records', Counter);
    end;

    var
        Counter: Integer;
}
