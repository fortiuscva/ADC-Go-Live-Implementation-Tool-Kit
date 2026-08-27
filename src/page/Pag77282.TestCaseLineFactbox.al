page 77282 "ADC Test Case Line Factbox"
{
    ApplicationArea = All;
    Caption = 'Test Case Line Factbox';
    PageType = CardPart;
    SourceTable = "ADC Test Case Line";

    layout
    {
        area(Content)
        {
            group("Data Points or Test Data")
            {
                Caption = 'Data Points/Test Data';
                field(TestData; Rec."Data Points")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Data Points or Test Data field.', Comment = '%';
                }
            }
            group("Expected Result")
            {
                Caption = 'Expected Result';

                field(ExpectedResult; Rec."Expected Result")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
            }
            group("Actual Result")
            {
                Caption = 'Actual Result';
                field(ActualResult; Rec."Actual Result")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Actual Result field.', Comment = '%';
                }
            }
        }
    }
    // var
    //     ExpectedResult: Text;
    //     ActualResult: Text;
    //     TestData: Text;

    // trigger OnAfterGetRecord()
    // begin
    //     ExpectedResult := Rec.GetExpectedResult();
    //     ActualResult := Rec.GetActualResult();
    //     TestData := Rec.GetTestData();
    // end;
}