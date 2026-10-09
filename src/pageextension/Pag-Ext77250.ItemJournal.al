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
                    //  Xmlport.Run(Xmlport::"ADC Imp. Inv. With Item Track.");
                    ReadExcelSheet();
                    ImportItemJournalStaging();
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
                    // Xmlport.Run(Xmlport::"ADC Imp. Inv. Item Track. Stag");
                    ReadExcelSheet();
                    ImportItemJournalStaging();
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
    local procedure ReadExcelSheet()
    var
        FileMgtCULcl: Codeunit "File Management";
        IStreamVarLcl: InStream;
        FromFileVarLcl: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFileVarLcl, IStreamVarLcl);
        if FromFileVarLcl = '' then
            Error(NoFileFoundMsg);

        FileNameVarLcl := FileMgtCULcl.GetFileName(FromFileVarLcl);
        SheetNameVarLcl := TempExcelBufferRecGbl.SelectSheetsNameStream(IStreamVarLcl);
        TempExcelBufferRecGbl.Reset();
        TempExcelBufferRecGbl.DeleteAll();
        TempExcelBufferRecGbl.OpenBookStream(IStreamVarLcl, SheetNameVarLcl);
        TempExcelBufferRecGbl.ReadSheet();
    end;


    local procedure ImportItemJournalStaging()
    var
        ItemJnlStageRecLcl: Record "ADC Item Journal Line Stage";
        RowNoVarLcl: Integer;
        MaxRowNoVarLcl: Integer;
        QuantityLcl: Decimal;
        UnitCostLcl: Decimal;
        ExpirationDateLcl: Date;
        EntryNoLcl: Integer;
        ExpirationDateTextLcl: Text;
    begin
        TempExcelBufferRecGbl.Reset();

        if not TempExcelBufferRecGbl.FindLast() then
            Error(NoDataFoundMsg);

        MaxRowNoVarLcl := TempExcelBufferRecGbl."Row No.";
        ItemJnlStageRecLcl.Reset();
        if ItemJnlStageRecLcl.FindFirst() then begin
            if not Confirm(LinesExistsMsgLbl) then
                Error(ProcessInterruptedMsg);
            ItemJnlStageRecLcl.DeleteAll();
        end;

        EntryNoLcl := 1;

        ItemJnlStageRecLcl.Reset();

        if ItemJnlStageRecLcl.FindLast() then
            EntryNoLcl := ItemJnlStageRecLcl."Entry No." + 1;

        for RowNoVarLcl := 2 to MaxRowNoVarLcl do begin
            if GetValueAtCell(RowNoVarLcl, 1) <> '' then begin

                Clear(QuantityLcl);
                Clear(UnitCostLcl);
                Clear(ExpirationDateLcl);
                Evaluate(QuantityLcl, GetValueAtCell(RowNoVarLcl, 2));
                Evaluate(UnitCostLcl, GetValueAtCell(RowNoVarLcl, 4));
                ExpirationDateTextLcl := GetValueAtCell(RowNoVarLcl, 9);
                Evaluate(ExpirationDateLcl, ExpirationDateTextLcl);
                ItemJnlStageRecLcl.Init();

                ItemJnlStageRecLcl."Entry No." := EntryNoLcl;
                ItemJnlStageRecLcl."Item No." := GetValueAtCell(RowNoVarLcl, 1);
                ItemJnlStageRecLcl.Validate(UOM, GetValueAtCell(RowNoVarLcl, 3));
                ItemJnlStageRecLcl.Validate(Quantity, QuantityLcl);
                ItemJnlStageRecLcl.Validate("Location Code", GetValueAtCell(RowNoVarLcl, 5));
                ItemJnlStageRecLcl.Validate("Unit Cost", UnitCostLcl);
                ItemJnlStageRecLcl.Validate("Bin Code", GetValueAtCell(RowNoVarLcl, 8));
                ItemJnlStageRecLcl."Lot No." := GetValueAtCell(RowNoVarLcl, 6);
                ItemJnlStageRecLcl."Serial No." := GetValueAtCell(RowNoVarLcl, 7);
                if ExpirationDateLcl <> 0D then
                    ItemJnlStageRecLcl."Expiration Date" := ExpirationDateLcl;

                ItemJnlStageRecLcl.Insert(true);

                EntryNoLcl += 1;
            end;
        end;
        Message(ExcelImportSuccessMsg);
    end;


    local procedure GetValueAtCell(RowNoVarLcl: Integer; ColNoVarLcl: Integer): Text
    begin
        TempExcelBufferRecGbl.Reset();

        if TempExcelBufferRecGbl.Get(RowNoVarLcl, ColNoVarLcl)
        then
            exit(TempExcelBufferRecGbl."Cell Value as Text");

        exit('');
    end;


    var
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;

        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];

        UploadExcelMsg: Label 'Please choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        NoDataFoundMsg: Label 'No data was found in the Excel file.';

        LinesExistsMsgLbl: Label 'There are lines in the staging table and existing lines will be deleted to import the new file. Do you want to proceed?';

        ProcessInterruptedMsg: Label 'Process interrupted to respect the warning.';

        ExcelImportSuccessMsg: Label 'Excel is successfully imported.';

        JnlLinesDeleteSuccessMsg: Label '%1 Item Journal Line(s) deleted successfully';
        NothingToDeleteMsg: Label 'There is nothing to delete';
        JnlLineDeleteConfirmMsg: Label 'Do you want to delete selected Item Journal Lines?';

}
