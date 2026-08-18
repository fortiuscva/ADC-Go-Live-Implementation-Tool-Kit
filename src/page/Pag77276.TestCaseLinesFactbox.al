page 77276 "ADC Test Case Lines Factbox"
{
    ApplicationArea = All;
    Caption = 'Test Case Lines Factbox';
    PageType = CardPart;
    SourceTable = "ADC Test Case Line";

    layout
    {
        area(Content)
        {
            group("Expected Result")
            {
                Caption = 'Expected Result';

                field(ExpectedResult; ExpectedResult)
                {
                    ApplicationArea = all;
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
                    ApplicationArea = all;
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
    var
        ExpectedResult: Text;
        ActualResult: Text;

    trigger OnAfterGetRecord()
    begin
        ExpectedResult := Rec.GetExpectedResult();
        ActualResult := Rec.GetActualResult();
    end;
}
