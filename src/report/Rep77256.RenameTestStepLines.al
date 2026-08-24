report 77256 "ADC Rename Test Step Lines"
{
    ApplicationArea = All;
    Caption = 'Rename Test Step Lines';
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
                dataitem(TestStepLine; "ADC Test Step Line")
                {
                    DataItemLinkReference = TestStepHeader;
                    DataItemLink = "Document No." = field("No.");
                    trigger OnAfterGetRecord()
                    begin
                        TestStepLine.Rename(TestCaseHeader."No.", TestStepLine."Line No.");
                    end;
                }
            }
        }
    }
}
