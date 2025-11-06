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
                    GoLiveSingleInstance: Codeunit "ADC Go Live Single Instance";
                    DeletedCount: Integer;
                    LocationCode: Code[20];
                begin
                    LocationCode := '1000';
                    CurrPage.SetSelectionFilter(ItemJnlLine);

                    if ItemJnlLine.IsEmpty() then begin
                        Message(NothingToDeleteMsg);
                        exit;
                    end;

                    if not Confirm(JnlLineDeleteConfirmMsg, false) then
                        exit;

                    GoLiveSingleInstance.SetHideDeleteItemTrackingConfirm(true);
                    if ItemJnlLine.FindSet() then
                        repeat
                            ItemJnlLine.Delete(true);
                            DeletedCount += 1;
                        until ItemJnlLine.Next() = 0;
                    GoLiveSingleInstance.SetHideDeleteItemTrackingConfirm(false);

                    if DeletedCount > 0 then
                        Message(StrSubstNo(JnlLinesDeleteSuccessMsg, DeletedCount))
                    else
                        Message(NothingToDeleteMsg);
                end;
            }
        }
    }

    var
        JnlLinesDeleteSuccessMsg: Label '%1 Item Journal Line(s) deleted successfully';
        NothingToDeleteMsg: Label 'There is nothing to delete';
        JnlLineDeleteConfirmMsg: Label 'Do you want to delete selected Item Journal Lines?';

}
