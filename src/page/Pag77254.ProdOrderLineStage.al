page 77254 "ADC Prod. Order Line Stage"
{
    ApplicationArea = All;
    Caption = 'ADC Prod. Order Line Stage';
    PageType = List;
    SourceTable = "ADC Prod. Order Line Stage";
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
                    ToolTip = 'Specifies the value of the Prod. Order No. field.', Comment = '%';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ToolTip = 'Specifies the value of the Production BOM No. field.', Comment = '%';
                }
                field("Production BOM Version Code"; Rec."Production BOM Version Code")
                {
                    ToolTip = 'Specifies the value of the Production BOM Version Code field.', Comment = '%';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the value of the Routing No. field.', Comment = '%';
                }
                field("Routing Version Code"; Rec."Routing Version Code")
                {
                    ToolTip = 'Specifies the value of the Routing Version Code field.', Comment = '%';
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

            action("Import Prod. Order Lines")
            {
                ApplicationArea = All;
                Caption = 'Import Prod. Order Lines';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportProdOrderLineStaging();
                end;
            }
        }
        area(Navigation)
        {
            action(ShowComponents)
            {
                ApplicationArea = All;
                Caption = 'Show Prod. Order Components';
                Image = Navigate;
                trigger OnAction()
                var
                    ProdOrderComponentStagingPage: Page "ADC Prod. Order Comp. Stage";
                    ProdOrderLineStagingRecLcl: Record "ADC Prod. Order Line Stage";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLineStagingRecLcl);
                    ProdOrderComponentStagingPage.SetTableView(ProdOrderLineStagingRecLcl);
                    ProdOrderComponentStagingPage.Run();
                end;
            }
            action(ShowRoutingLines)
            {
                ApplicationArea = All;
                Caption = 'Show Prod. Order Routing Lines';
                Image = Navigate;
                trigger OnAction()
                var
                    RoutingLineStagingPage: Page "Prod. Order Routing Line Stage";
                    ProdOrderLineStagingRecLcl: Record "ADC Prod. Order Line Stage";
                begin
                    CurrPage.SetSelectionFilter(ProdOrderLineStagingRecLcl);
                    RoutingLineStagingPage.SetTableView(ProdOrderLineStagingRecLcl);
                    RoutingLineStagingPage.Run();
                end;
            }
        }
    }
    procedure ImportProdOrderLineStaging()
    var
        ProdOrderLineStageRecLcl: Record "ADC Prod. Order Line Stage";
        RowNoVarLcl: Integer;
        ColNoVarLcl: Integer;
        MaxRowNoVarLcl: Integer;
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
            LineNoGbl := 10000;
            ProdOrderLineStageRecLcl.Reset();
            ProdOrderLineStageRecLcl.SetRange("Prod. Order No.", ProdOrderLineStageRecLcl."Prod. Order No.");
            if ProdOrderLineStageRecLcl.FindLast() then
                LineNoGbl := ProdOrderLineStageRecLcl."Prod. Order Line No." + 10000;
            ProdOrderLineStageRecLcl.Init();
            ProdOrderLineStageRecLcl.Validate(Status, ProdOrderLineStageRecLcl.Status::Released);
            ProdOrderLineStageRecLcl.Validate("Prod. Order No.", GetValueAtCell(RowNoVarLcl, 2));
            ProdOrderLineStageRecLcl.Validate("Prod. Order Line No.", LineNoGbl);
            ProdOrderLineStageRecLcl.Validate("Item No.", GetValueAtCell(RowNoVarLcl, 1));
            ProdOrderLineStageRecLcl.Validate("Variant Code", '');
            ProdOrderLineStageRecLcl.Validate(Quantity, QuantityGbl);
            ProdOrderLineStageRecLcl.Validate("Location Code", GetValueAtCell(RowNoVarLcl, 6));
            ProdOrderLineStageRecLcl.Insert(true);
            LineNoGbl += 10000;
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

        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        QuantityGbl: Decimal;
        LineNoGbl: Integer;
        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
