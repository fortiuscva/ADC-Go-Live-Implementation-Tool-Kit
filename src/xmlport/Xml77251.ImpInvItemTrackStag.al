xmlport 77251 "ADC Imp. Inv. Item Track. Stag"
{
    Caption = 'Import Inventory With Item Tracking - Staging';
    Direction = Import;
    FormatEvaluate = Legacy;
    FieldSeparator = ',';
    Format = VariableText;
    Permissions = tabledata "Item Ledger Entry" = rimd,
                  tabledata "Value Entry" = rimd;

    schema
    {
        textelement(root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'ItemJnlLineGbl';
                textelement(ItemNoGbl) { }
                textelement(QuantityGbl) { }
                textelement(UOMGbl) { }
                textelement(UnitCostGbl) { }
                textelement(LocationCodeGbl) { }
                textelement(LotNoGbl) { }
                textelement(SerialNoGbl) { }
                textelement(BinCodeGbl) { }
                textelement(ExpirationDateGbl) { }

                trigger OnAfterInitRecord()
                begin
                    ItemNoGbl := '';
                    QuantityGbl := '';
                    LotNoGbl := '';
                    UnitCostGbl := '';
                    LocationCodeGbl := '';
                    LotNoGbl := '';
                    SerialNoGbl := '';
                    ExpirationDateGbl := '';
                end;

                trigger OnPreXmlItem()
                begin
                    HeaderVarGbl := true;
                end;

                trigger OnBeforeInsertRecord()
                var
                    LotNoInfoLcl: Record "Lot No. Information";
                    QuantityLcl: Decimal;
                    UnitCostLcl: Decimal;
                    ExpDateLcl: Date;
                begin
                    if HeaderVarGbl then begin
                        HeaderVarGbl := false;
                        currXMLport.Skip();
                    end;

                    Evaluate(QuantityLcl, QuantityGbl);
                    Evaluate(UnitCostLcl, UnitCostGbl);
                    Evaluate(ExpDateLcl, ExpirationDateGbl);

                    ItemJnlLineStagingRecGbl.Init();
                    ItemJnlLineStagingRecGbl."Entry No." := EntryNo;
                    ItemJnlLineStagingRecGbl."Item No." := ItemNoGbl;
                    ItemJnlLineStagingRecGbl.Validate(UOM, UOMGbl);
                    ItemJnlLineStagingRecGbl.Validate(Quantity, QuantityLcl);
                    ItemJnlLineStagingRecGbl.Validate("Location Code", LocationCodeGbl);
                    ItemJnlLineStagingRecGbl.Validate("Unit Cost", UnitCostLcl);
                    ItemJnlLineStagingRecGbl.Validate("Bin Code", BinCodeGbl);
                    ItemJnlLineStagingRecGbl."Lot No." := LotNoGbl;
                    ItemJnlLineStagingRecGbl."Serial No." := SerialNoGbl;
                    ItemJnlLineStagingRecGbl."Expiration Date" := ExpDateLcl;
                    ItemJnlLineStagingRecGbl.Insert();
                    EntryNo += 1;
                end;
            }
        }
    }

    trigger OnPreXmlPort()

    begin
        EntryNo := 1;
        ItemJnlLineStagingRecGbl.Reset();
        if ItemJnlLineStagingRecGbl.FindFirst() then
            if not Confirm(LinesExistsMsgLbl) then
                error('Process interrupted to respect the Warning');

    end;

    var
        ItemGbl: Record Item;
        SelectedJournalBatchNameGbl, SelectedJournalTemplateNameGbl : Code[10];
        SelectedPostingDateGbl: Date;
        SelectedDocumentNoGbl: Code[20];
        LineNoGbl: Integer;
        HeaderVarGbl: Boolean;
        EntryNo: Integer;
        ItemJnlLineStagingRecGbl: Record "ADC Item Journal Line Stage";
        LinesExistsMsgLbl: Label 'There are lines in staging table and existing lines will be deleted to import the new file. Do you want to proceed?';
}