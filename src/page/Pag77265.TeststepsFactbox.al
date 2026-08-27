page 77265 "ADC Teststeps Factbox"
{
    ApplicationArea = All;
    Caption = 'Teststeps Factbox';
    PageType = ListPart;
    SourceTable = "ADC Test Step Line";

    layout
    {
        area(Content)
        {
            repeater(Teststeps)
            {
                ShowCaption = false;
                field("Test Step Description"; Rec."Test Step Description")
                {
                    ToolTip = 'Specifies the value of the Test Step Description field.', Comment = '%';
                }
            }
        }
    }
}
