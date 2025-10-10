pageextension 77251 "ADC Item List" extends "Item List"
{
    actions
    {
        addlast(processing)
        {
            action("ADC NTS ImportBOMComponents")
            {
                ApplicationArea = All;
                Caption = 'Import Assembly BOM Components';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "ADC Imp. BOMComponents Stage";
            }

        }
    }
}
