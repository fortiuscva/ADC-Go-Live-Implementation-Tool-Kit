page 77255 "ADC Prod. Order Comp. Stage"
{
    ApplicationArea = All;
    Caption = 'ADC Prod. Order Comp. Stage';
    PageType = List;
    SourceTable = "ADC Prod. Order Comp. Stage";
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
                field("Prod. Order Line Item No."; Rec."Prod. Order Line Item No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line Item No. field.', Comment = '%';
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Comp. Line No. field.', Comment = '%';
                }
                field("Comp. Item No."; Rec."Comp. Item No.")
                {
                    ToolTip = 'Specifies the value of the Comp. Item No. field.', Comment = '%';
                }
                field("Quantity Per"; Rec."Quantity Per")
                {
                    ToolTip = 'Specifies the value of the Quantity Per field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ToolTip = 'Specifies the value of the Flushing Method field.', Comment = '%';
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ToolTip = 'Specifies the value of the Expected Quantity field.', Comment = '%';
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ToolTip = 'Specifies the value of the Routing Link Code field.', Comment = '%';
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

            action("Import Prod. Order Components")
            {
                ApplicationArea = All;
                Caption = 'Import Prod. Order Components';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportProdOrderCompStaging();
                end;
            }
            action(UnflagProcessedFlag)
            {
                Caption = 'Unflag Processed Lines';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will unflag processed flag value on Staging Production Order Components';
                trigger OnAction()

                begin
                    if not Confirm(UnProcessedConfirmFlagMsg, false) then
                        Error(ProcessInterruptedMsg);
                    ProdOrderCompStageRecGbl.RESET;
                    ProdOrderCompStageRecGbl.ModifyAll(Processed, false);
                    ProdOrderCompStageRecGbl.ModifyAll("Error Text", '');
                end;
            }

        }
    }
    procedure ImportProdOrderCompStaging()
    var
        ProdOrderCompStageRecLcl: Record "ADC Prod. Order Comp. Stage";
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
            Evaluate(LineNoGbl, GetValueAtCell(RowNoVarLcl, 3));
            Evaluate(QuantityPerGbl, GetValueAtCell(RowNoVarLcl, 7));
            Evaluate(ExpectedqtyGbl, GetValueAtCell(RowNoVarLcl, 8));
            ProdOrderCompStageRecLcl.Init();
            ProdOrderCompStageRecLcl.Validate(Status, ProdOrderCompStageRecLcl.Status::Released);
            ProdOrderCompStageRecLcl.Validate("Prod. Order No.", GetValueAtCell(RowNoVarLcl, 2));
            ProdOrderCompStageRecLcl.Validate("Prod. Order Line Item No.", GetValueAtCell(RowNoVarLcl, 1));
            ProdOrderCompStageRecLcl.Validate("Prod. Order Comp. Line No.", LineNoGbl);
            ProdOrderCompStageRecLcl.Validate("Comp. Item No.", GetValueAtCell(RowNoVarLcl, 4));
            ProdOrderCompStageRecLcl.Validate("Unit of Measure Code", GetValueAtCell(RowNoVarLcl, 6));
            ProdOrderCompStageRecLcl.Validate("Quantity Per", QuantityPerGbl);
            ProdOrderCompStageRecLcl.Validate("Expected Quantity", ExpectedqtyGbl);
            ProdOrderCompStageRecLcl.Insert(true);
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
        ProdOrderCompStageRecGbl: Record "ADC Prod. Order Comp. Stage";
        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];
        LineNoGbl: Integer;
        QuantityPerGbl: Decimal;
        ExpectedqtyGbl: Decimal;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
