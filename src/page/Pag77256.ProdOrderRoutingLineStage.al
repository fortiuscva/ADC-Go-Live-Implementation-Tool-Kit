page 77256 "Prod. Order Routing Line Stage"
{
    ApplicationArea = All;
    Caption = 'Prod. Order Routing Line Stage';
    PageType = List;
    SourceTable = "Prod. Order Routing Line Stage";
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
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the value of the Routing No. field.', Comment = '%';
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    ToolTip = 'Specifies the value of the Routing Reference No. field.', Comment = '%';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ToolTip = 'Specifies the value of the Routing Link Code field.', Comment = '%';
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ToolTip = 'Specifies the value of the Flushing Method field.', Comment = '%';
                }
                field("Previous Operation No."; Rec."Previous Operation No.")
                {
                    ToolTip = 'Specifies the value of the Previous Operation No. field.', Comment = '%';
                }
                field("Next Operation No."; Rec."Next Operation No.")
                {
                    ToolTip = 'Specifies the value of the Next Operation No. field.', Comment = '%';
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

            action("Import Prod. Order Routing Lines")
            {
                ApplicationArea = All;
                Caption = 'Import Prod. Order Routing Lines';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportProdOrderRoutingLinesStaging();
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
                ToolTip = 'This action will unflag processed flag value on Staging Production Order Routing Lines';
                trigger OnAction()

                begin
                    if not Confirm(UnProcessedConfirmFlagMsg, false) then
                        Error(ProcessInterruptedMsg);
                    ProdOrderRoutingLineStageRecGbl.RESET;
                    ProdOrderRoutingLineStageRecGbl.ModifyAll(Processed, false);
                    ProdOrderRoutingLineStageRecGbl.ModifyAll("Error Text", '');
                end;

            }
        }
    }
    procedure ImportProdOrderRoutingLinesStaging()
    var
        ProdOrderRoutingLinesStageRecLcl: Record "Prod. Order Routing Line Stage";
        ProdOrderLineRecLcl: Record "Prod. Order Line";
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
            ProdOrderLineRecLcl.Reset();
            ProdOrderLineRecLcl.SetRange("Prod. Order No.", GetValueAtCell(RowNoVarLcl, 2));
            ProdOrderLineRecLcl.SetRange("Item No.", GetValueAtCell(RowNoVarLcl, 1));
            if ProdOrderLineRecLcl.FindFirst() then begin
                ProdOrderRoutingLinesStageRecLcl.Validate("Routing No.", ProdOrderLineRecLcl."Routing No.");
                ProdOrderRoutingLinesStageRecLcl.Validate("Routing Reference No.", ProdOrderLineRecLcl."Routing Reference No.");
                ProdOrderRoutingLinesStageRecLcl.Validate("Prod. Order Line No.", ProdOrderLineRecLcl."Line No.");
            end;
            ProdOrderRoutingLinesStageRecLcl.Validate(Status, ProdOrderRoutingLinesStageRecLcl.Status::Released);
            ProdOrderRoutingLinesStageRecLcl.Validate("Prod. Order No.", GetValueAtCell(RowNoVarLcl, 2));
            ProdOrderRoutingLinesStageRecLcl.Validate("Operation No.", GetValueAtCell(RowNoVarLcl, 3));
            ProdOrderRoutingLinesStageRecLcl.Validate(Type, ProdOrderRoutingLinesStageRecLcl.Type::"Work Center");
            ProdOrderRoutingLinesStageRecLcl.Validate("No.", GetValueAtCell(RowNoVarLcl, 4));
            ProdOrderRoutingLinesStageRecLcl.Validate(Description, GetValueAtCell(RowNoVarLcl, 5));
            ProdOrderRoutingLinesStageRecLcl.Insert(true);
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
        ProdOrderRoutingLineStageRecGbl: Record "Prod. Order Routing Line Stage";
        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
