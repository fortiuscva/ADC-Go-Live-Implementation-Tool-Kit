pageextension 77250 "ADC Item Journal" extends "Item Journal"
{
    actions
    {
        addlast(processing)
        {
            action("ADC ImportInventory")
            {
                ApplicationArea = All;
                Caption = 'Import Inventory';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"ADC Imp. Inv. With Item Track.");
                    CurrPage.Update(false);
                end;

            }
        }
    }
}
