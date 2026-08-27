page 77278 "ADC Test Case Results"
{
    ApplicationArea = All;
    Caption = 'Test Case Results';
    PageType = Card;
    SourceTable = "ADC Test Case Line";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = None;

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
                    ToolTip = 'Specifies the value of the Data Points or Test Data field.', Comment = '%';
                }
            }

            group("Expected Result")
            {
                Caption = 'Expected Result';
                field(ExpectedResult; Rec."Expected Result")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
            }
            group("Actual Result")
            {
                Caption = 'Actual Result';
                field(ActualResult; Rec."Actual Result")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Actual Result field.', Comment = '%';
                }
            }
        }
    }
}
