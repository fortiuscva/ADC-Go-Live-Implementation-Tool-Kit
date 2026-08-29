report 77258 "ADC Up Default Test Case Nos."
{
    ApplicationArea = All;
    Caption = 'Update Default Test Case Nos.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ADCTestStepHeader; "ADC Test Step Header")
        {
            trigger OnAfterGetRecord()
            var
                CaseHeader: Record "ADC Test Case Header";
            begin
                CaseHeader.Reset();
                CaseHeader.SetRange(Description, ADCTestStepHeader.Description);
                if CaseHeader.FindFirst() then begin
                    ADCTestStepHeader."Default Test Case No." := CaseHeader."No.";
                    ADCTestStepHeader.Modify(true);
                end else begin
                    ADCTestStepHeader."Default Test Case No." := '';
                    ADCTestStepHeader.Modify(true);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
