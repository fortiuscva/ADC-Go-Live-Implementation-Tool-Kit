page 77252 "ADC BOM Component Stage"
{
    ApplicationArea = All;
    Caption = 'BOM Component Stage';
    PageType = List;
    SourceTable = "ADC Assembly BOM Import Stage";
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
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ToolTip = 'Specifies the value of the Parent Item No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
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
                field("Quantity Per"; Rec."Quantity Per")
                {
                    ToolTip = 'Specifies the value of the Quantity Per field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                    ToolTip = 'Specifies the value of the Installed in Item No. field.', Comment = '%';
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
        area(Processing)
        {
            action("ADC NTS ImportBOMComponents")
            {
                ApplicationArea = All;
                Caption = 'Import Assembly BOM Components';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportAssBOMStaging();
                end;
            }
            action(CreateBOMComponents)
            {
                Caption = 'Process BOM Components';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will create Assembly BOM';
                RunObject = report "ADC Create BOM Components";
            }
            action(UnflagProcessedFlag)
            {
                Caption = 'Unflag Processed Lines';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will unflag processed flag value on Staging Assembly BOM Lines';
                trigger OnAction()

                begin
                    if not Confirm(UnProcessedConfirmFlagMsg, false) then
                        Error(ProcessInterruptedMsg);

                    ADCBOMComponentStagingRecGbl.RESET;
                    ADCBOMComponentStagingRecGbl.ModifyAll(Processed, false);
                    ADCBOMComponentStagingRecGbl.ModifyAll("Error Text", '');
                end;

            }

        }

    }
    procedure ImportAssBOMStaging()
    var
        AssBOMImpStageRecLcl: Record "ADC Assembly BOM Import Stage";
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
            Evaluate(LineType, GetValueAtCell(RowNoVarLcl, 3));
            Evaluate(QuantityGbl, GetValueAtCell(RowNoVarLcl, 6));

            AssBOMImpStageRecLcl.Init();
            AssBOMImpStageRecLcl.Validate("Parent Item No.", GetValueAtCell(RowNoVarLcl, 1));
            AssBOMImpStageRecLcl.Validate(Type, LineType);
            AssBOMImpStageRecLcl.Validate("No.", GetValueAtCell(RowNoVarLcl, 4));
            AssBOMImpStageRecLcl.Validate(Description, GetValueAtCell(RowNoVarLcl, 5));
            AssBOMImpStageRecLcl.Validate("Quantity per", QuantityGbl);
            AssBOMImpStageRecLcl.Validate("Unit of Measure Code", GetValueAtCell(RowNoVarLcl, 7));
            AssBOMImpStageRecLcl.Validate("Installed in Item No.", GetValueAtCell(RowNoVarLcl, 8));
            AssBOMImpStageRecLcl.Insert(true);
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
        ADCBOMComponentStagingRecGbl: Record "ADC Assembly BOM Import Stage";

        LineType: Enum "BOM Component Type";
        QuantityGbl: Decimal;
        TempExcelBufferRecGbl: Record "Excel Buffer" temporary;
        FileNameVarLcl: Text[100];
        SheetNameVarLcl: Text[100];
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
}
