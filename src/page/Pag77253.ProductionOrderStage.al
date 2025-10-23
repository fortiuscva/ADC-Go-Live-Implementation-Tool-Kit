page 77253 "ADC Production Order Stage"
{
    ApplicationArea = All;
    Caption = 'ADC Production Order Stage';
    PageType = List;
    SourceTable = "ADC Production Order Stage";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ToolTip = 'Specifies the value of the Source Type field.', Comment = '%';
                }
                field("Source No."; Rec."Source No.")
                {
                    ToolTip = 'Specifies the value of the Source No. field.', Comment = '%';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
                field("Error Text"; Rec."Error Text")
                {
                    ToolTip = 'Specifies the value of the Error Text field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        area(processing)
        {

            action("Import Production Orders")
            {
                ApplicationArea = All;
                Caption = 'Import Production Orders';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportProdOrderStaging();
                end;
            }
            action(CreateProductionOrders)
            {
                Caption = 'Process Production Orders';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will create Production Orders';
                RunObject = report "ADC Create Production Order";
            }
            action(DeleteSourceAndUnflagSelected)
            {
                ApplicationArea = All;
                Caption = 'Delete Source and Unflag Processed Lines';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ProdOrderStageRecLcl: Record "ADC Production Order Stage";
                    ProdOrderRecLcl: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderStageRecLcl);
                    if ProdOrderStageRecLcl.FindSet() then begin
                        repeat
                            if ProdOrderStageRecLcl.Processed then begin

                                ProdOrderRecLcl.Reset();
                                ProdOrderRecLcl.SetRange("No.", ProdOrderStageRecLcl."Prod. Order No.");
                                if ProdOrderRecLcl.FindFirst() then
                                    ProdOrderRecLcl.Delete();
                                ProdOrderStageRecLcl.Processed := false;
                                ProdOrderStageRecLcl.Modify();
                            end;
                        until ProdOrderStageRecLcl.Next() = 0;
                        Message('Selected processed lines unflagged and Production Order(s) are deleted.');
                    end else
                        Message('No records selected.');
                end;
            }

        }
        area(Navigation)
        {
            action(ShowProdOrderLines)
            {
                ApplicationArea = All;
                Caption = 'Show Prod. Order Lines';
                Image = Navigate;
                trigger OnAction()
                var
                    ProdOrderLineStagingPage: Page "ADC Prod. Order Line Stage";
                    ProductionOrderStageRecLcl: Record "ADC Production Order Stage";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrderStageRecLcl);
                    ProdOrderLineStagingPage.SetTableView(ProductionOrderStageRecLcl);
                    ProdOrderLineStagingPage.Run();
                end;
            }
        }
    }
    procedure ImportProdOrderStaging()
    var
        ProdOrderStageRecLcl: Record "ADC Production Order Stage";
        RowNoVarLcl: Integer;
        ColNoVarLcl: Integer;
        MaxRowNoVarLcl: Integer;
        QtyVarLcl: Decimal;
    begin

        RowNoVarLcl := 0;
        ColNoVarLcl := 0;
        MaxRowNoVarLcl := 0;

        TempExcelBufferRecGbl.Reset();
        if TempExcelBufferRecGbl.FindLast() then begin
            MaxRowNoVarLcl := TempExcelBufferRecGbl."Row No.";
        end;
        for RowNoVarLcl := 2 to MaxRowNoVarLcl do begin
            Evaluate(QuantityGbl, GetValueAtCell(RowNoVarLcl, 5));

            ProdOrderStageRecLcl.Init();
            ProdOrderStageRecLcl.Validate(Status, ProdOrderStageRecLcl.Status::Released);
            ProdOrderStageRecLcl.Validate("Prod. Order No.", GetValueAtCell(RowNoVarLcl, 2));
            ProdOrderStageRecLcl.Validate("Source Type", ProdOrderStageRecLcl."Source Type"::Item);
            ProdOrderStageRecLcl.Validate("Source No.", GetValueAtCell(RowNoVarLcl, 1));
            ProdOrderStageRecLcl.Validate("Variant Code", '');
            ProdOrderStageRecLcl.Validate(Quantity, QuantityGbl);
            ProdOrderStageRecLcl.Validate("Location Code", GetValueAtCell(RowNoVarLcl, 6));
            ProdOrderStageRecLcl.Validate("Bin Code", '');
            ProdOrderStageRecLcl.Insert(true);
            Commit();
        end;
        Message(ExcelImportSucess);
    end;


    local procedure ReadExcelSheet()
    var
        FileMgtCULcl: Codeunit "File Management";
        IStreamVarLcl: InStream;
        FromFileVarLcl: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFileVarLcl, IStreamVarLcl);
        if FromFileVarLcl <> '' then begin
            FileNameVarLcl := FileMgtCULcl.GetFileName(FromFileVarLcl);
            SheetNameVarLcl := TempExcelBufferRecGbl.SelectSheetsNameStream(IStreamVarLcl);
        end else
            Error(NoFileFoundMsg);
        TempExcelBufferRecGbl.Reset();
        TempExcelBufferRecGbl.DeleteAll();
        TempExcelBufferRecGbl.OpenBookStream(IStreamVarLcl, SheetNameVarLcl);
        TempExcelBufferRecGbl.ReadSheet();
    end;

    local procedure GetValueAtCell(RowNoVarLcl: Integer; ColNoVarLcl: Integer): Text
    begin

        TempExcelBufferRecGbl.Reset();
        If TempExcelBufferRecGbl.Get(RowNoVarLcl, ColNoVarLcl) then
            exit(TempExcelBufferRecGbl."Cell Value as Text")
        else
            exit('');
    end;

    var
        UnProcessedConfirmFlagMsg: Label 'Do you want to unflag all processed lines?';
        ProcessInterruptedMsg: Label 'Processed Interrupted to respect the Warning';
        QuantityGbl: Decimal;
        ProdOrderStageRecGbl: Record "ADC Production Order Stage";
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
