page 77267 Subcategories
{
    ApplicationArea = All;
    Caption = 'Subcategories';
    PageType = List;
    SourceTable = "ADC Subcategory";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Subcategory; Rec.Subcategory)
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
