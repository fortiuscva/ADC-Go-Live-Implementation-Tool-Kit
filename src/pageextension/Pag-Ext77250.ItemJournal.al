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
            action("ADC Select and Delete Journal Lines")
            {
                Caption = 'Select and Delete Journal Lines';
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                    SuppressConfirmationCU: Codeunit "ADC Suppress Confirmation";
                    DeletedCount: Integer;
                    LocationCode: Code[20];
                begin
                    LocationCode := '1000';
                    CurrPage.SetSelectionFilter(ItemJnlLine);

                    if ItemJnlLine.IsEmpty() then begin
                        Message('No item journal lines selected.');
                        exit;
                    end;

                    if not Confirm('Do you want delete selected Item Journal Lines?', false) then
                        exit;

                    SuppressConfirmationCU.SetSuppress(true);
                    if ItemJnlLine.FindSet() then
                        repeat
                            if ItemJnlLine."Location Code" = '1000' then begin
                                ItemJnlLine.Delete(true);
                                DeletedCount += 1;
                            end;
                        until ItemJnlLine.Next() = 0;
                    SuppressConfirmationCU.SetSuppress(false);

                    if DeletedCount > 0 then
                        Message('%1 Item Journal Line(s) deleted within the Location %2.', DeletedCount, LocationCode)
                    else
                        Message('Selected Item Journal lines are not in the Location %1, so not deleted.', LocationCode);
                end;
            }
        }
    }
}
