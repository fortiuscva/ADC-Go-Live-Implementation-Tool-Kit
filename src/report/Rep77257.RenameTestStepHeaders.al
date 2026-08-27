report 77257 "Rename Test Steps"
{
    ApplicationArea = All;
    Caption = 'Rename Test Step Headers';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(TestCaseHeader; "ADC Test Case Header")
        {
            DataItemTableView = where(Description = filter(<> ''));
            RequestFilterFields = "No.";
            dataitem(TestStepHeader; "ADC Test Step Header")
            {
                DataItemLinkReference = TestCaseHeader;
                DataItemLink = Description = field(Description);
                trigger OnAfterGetRecord()
                begin
                    TestStepHeader.Rename(TestCaseHeader."No.");
                end;
            }
        }
    }
}
