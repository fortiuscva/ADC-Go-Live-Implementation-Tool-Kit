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
            dataitem(TestStepHeader; "ADC Test Step Header")
            {
                DataItemLinkReference = TestCaseHeader;
                DataItemLink = Description = field(Description);
                dataitem(BCTestStepLine; "ADC BC Test Step Line")
                {
                    DataItemLinkReference = TestStepHeader;
                    DataItemLink = Description = field(Description);
                    trigger OnAfterGetRecord()
                    begin
                        BCTestStepLine."BC Test Case No." := TestCaseHeader."No.";
                        BCTestStepLine."BC Test Step No." := TestStepHeader."No.";
                        BCTestStepLine.Modify(true);
                        Counter += 1;
                    end;
                }
            }
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
