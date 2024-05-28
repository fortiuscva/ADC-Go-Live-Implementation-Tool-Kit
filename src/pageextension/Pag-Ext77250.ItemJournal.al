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
            action("ADC ImportInventoryToStaging")
            {
                ApplicationArea = All;
                Caption = 'Import Inventory to Staging';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"ADC Imp. Inv. Item Track. Stag");
                    CurrPage.Update(false);
                end;

            }
            action("ADC OpenStagingRecords")
            {
                ApplicationArea = All;
                Caption = 'Open Staging Records';
                Promoted = true;
                PromotedCategory = Process;
                Image = Open;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"ADC Item Journal Lines Stating")
                end;

            }
        }
    }
}
