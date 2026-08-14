page 77266 "ADC Categories"
{
    ApplicationArea = All;
    Caption = 'Categories';
    PageType = List;
    SourceTable = "ADC Category";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
