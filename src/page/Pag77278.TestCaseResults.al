page 77278 "ADC Test Case Results"
{
    ApplicationArea = All;
    Caption = 'Test Case Results';
    PageType = Card;
    SourceTable = "ADC Test Case Line";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                group("Expected Result")
                {
                    Caption = 'Expected Result';
                    field(ExpectedResult; ExpectedResult)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                        trigger OnValidate()
                        begin
                            Rec.SetExpectedResult(ExpectedResult);
                        end;
                    }
                }
                group("Actual Result")
                {
                    Caption = 'Actual Result';
                    field(ActualResult; ActualResult)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the value of the Actual Result field.', Comment = '%';
                        trigger OnValidate()
                        begin
                            Rec.SetActualResult(ActualResult);
                        end;
                    }
                }
            }
        }
    }
    var
        ExpectedResult: Text;
        ActualResult: Text;

    trigger OnAfterGetRecord()
    begin
        ExpectedResult := Rec.GetExpectedResult();
        ActualResult := Rec.GetActualResult();
    end;
}
