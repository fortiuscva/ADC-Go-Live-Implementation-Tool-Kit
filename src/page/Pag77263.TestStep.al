page 77263 "ADC Test Step"
{
    ApplicationArea = All;
    Caption = 'Test Step';
    PageType = Document;
    SourceTable = "ADC Test Step Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    MultiLine = true;
                }
            }
            part(Lines; "ADC Test Step Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = field(Code);
            }
        }
    }
}
