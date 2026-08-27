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
            begin
                ADCTestStepHeader."Default Test Case No." := ADCTestStepHeader."No.";
                ADCTestStepHeader.Modify(true);
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
