xmlport 77250 "ADC Imp. Inv. With Item Track."
{
    Caption = 'Import Inventory With Item Tracking';
    FormatEvaluate = Legacy;
    FieldSeparator = ',';
    Format = VariableText;
    Permissions = tabledata "Item Ledger Entry" = rimd,
                  tabledata "Value Entry" = rimd;

    schema
    {
        textelement(root)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'ItemJnlLineGbl';
                SourceTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                textelement(ItemNoGbl)
                {
                }
                textelement(QuantityGbl)
                {
                }
                textelement(UOMGbl)
                {
                }
                textelement(UnitCostGbl)
                {
                }
                textelement(LocationCodeGbl)
                {
                }
                textelement(LotNoGbl)
                {
                }
                textelement(SerialNoGbl)
                {
                }
                textelement(BinCodeGbl)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    ItemNoGbl := '';
                    QuantityGbl := '';
                    LotNoGbl := '';
                    UnitCostGbl := '';
                    LocationCodeGbl := '';
                    LotNoGbl := '';
                    SerialNoGbl := '';
                end;

                trigger OnBeforeInsertRecord()
                var
                    LotNoInfoLcl: Record "Lot No. Information";
                    QuantityLcl: Decimal;
                    UnitCostLcl: Decimal;
                begin
                    if HeaderVarGbl then begin
                        HeaderVarGbl := false;
                        currXMLport.Skip();
                    end;

                    Evaluate(QuantityLcl, QuantityGbl);
                    Evaluate(UnitCostLcl, UnitCostGbl);

                    if QuantityLcl = 0 then
                        currXMLport.Skip();

                    ItemGbl.Get(ItemNoGbl);
                    ItemGbl.TestField(Blocked, false);

                    "Item Journal Line".Init();
                    "Item Journal Line".Validate("Journal Template Name", SelectedJournalTemplateNameGbl);
                    "Item Journal Line".Validate("Journal Batch Name", SelectedJournalBatchNameGbl);
                    "Item Journal Line".Validate("Line No.", LineNoGbl);
                    "Item Journal Line".Insert(true);

                    "Item Journal Line".Validate("Posting Date", SelectedPostingDateGbl);
                    "Item Journal Line".Validate("Document No.", SelectedDocumentNoGbl);
                    "Item Journal Line".Validate("Entry Type", "Item Journal Line"."Entry Type"::"Positive Adjmt.");
                    "Item Journal Line".Validate("Item No.", ItemNoGbl);
                    if UOMGbl <> '' then
                        "Item Journal Line".Validate("Unit of Measure Code", UOMGbl);


                    "Item Journal Line".Validate(Quantity, QuantityLcl);

                    "Item Journal Line".Validate("Location Code", LocationCodeGbl);


                    "Item Journal Line".Validate("Unit Cost", UnitCostLcl);

                    if BinCodeGbl <> '' then
                        "Item Journal Line".Validate("Bin Code", BinCodeGbl);

                    "Item Journal Line".Modify(true);

                    if (LotNoGbl <> '') or (SerialNoGbl <> '') then begin
                        ReservationStatus := ReservationStatus::Prospect;
                        CheckForTracking(ItemGbl."No.", LotNoGbl, SerialNoGbl);
                        "Item Journal Line".SetReservationEntry(ForReservEntry);
                        ForReservEntry."Lot No." := LotNoGbl;
                        ForReservEntry."Serial No." := SerialNoGbl;
                        CreateReservEntry.CreateReservEntryFor(
                          DATABASE::"Item Journal Line",
                          "Item Journal Line"."Entry Type".AsInteger(), "Item Journal Line"."Journal Template Name",
                          "Item Journal Line"."Journal Batch Name", 0, "Item Journal Line"."Line No.", "Item Journal Line"."Qty. per Unit of Measure",
                          "Item Journal Line".Quantity, "Item Journal Line"."Quantity (Base)", ForReservEntry);
                        CreateReservEntry.CreateEntry(
                          "Item Journal Line"."Item No.", "Item Journal Line"."Variant Code", "Item Journal Line"."Location Code",
                          "Item Journal Line".Description, "Item Journal Line"."Posting Date", 0D, 0, ReservationStatus);

                    end;
                    LineNoGbl := LineNoGbl + 1000;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(SelectedPostingDateGbl; SelectedPostingDateGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
                field(SelectedJournalTemplateNameGbl; SelectedJournalTemplateNameGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Journal Template Name';
                    TableRelation = "Item Journal Template" where(Type = const(Item),
                                                                   Recurring = const(false));
                }
                field(SelectedJournalBatchNameGbl; SelectedJournalBatchNameGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name';
                    TableRelation = "Item Journal Batch".Name;
                }
                field(SelectedDocumentNoGbl; SelectedDocumentNoGbl)
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                }
            }
        }
    }

    trigger OnInitXmlPort()
    begin
        SelectedPostingDateGbl := Today;
        HeaderVarGbl := true;
        SelectedJournalTemplateNameGbl := 'ITEM';
        SelectedJournalBatchNameGbl := 'DEFAULT';
        SelectedDocumentNoGbl := 'OPENING BALANCE';
    end;

    trigger OnPreXmlPort()
    var
        ItemJnlLineLcl: Record "Item Journal Line";
    begin
        ItemJnlLineLcl.SetRange("Journal Template Name", SelectedJournalTemplateNameGbl);
        ItemJnlLineLcl.SetRange("Journal Batch Name", SelectedJournalBatchNameGbl);
        if not ItemJnlLineLcl.FindLast() then
            LineNoGbl := 1000
        else
            LineNoGbl := ItemJnlLineLcl."Line No." + 1000;
    end;


    procedure CheckForTracking(ItemNoPar: Code[20]; LotNoPar: Code[20]; SerialNoPar: Code[20])
    var
        ItemRecLcl: Record Item;
        ItemTrackingCodeRecLcl: Record "Item Tracking Code";
        SpecificLotTracking: Boolean;
        SpecificSNTracking: Boolean;
        LotNoCannotBeEmptyErrLbl: Label 'Item %1 is enabled for Lot Tracking. Lot No. cannot be empty';
        LotNoMustBeEmptyErrLbl: Label 'Item %1 is not enabled for Lot Tracking. Lot No. must be empty';
        SerialCannotBeEmptyErrLbl: Label 'Item %1 is enabled for Serial Tracking. Serial No. cannot be empty';
        SerialNoMustBeEmptyErrLbl: Label 'Item %1 is not enabled for Serial Tracking. Serial No. must be empty';

    begin
        ItemRecLcl.get(ItemNoPar);
        if ItemRecLcl."Item Tracking Code" <> '' then begin
            ItemTrackingCodeRecLcl.Get(ItemRecLcl."Item Tracking Code");
            SpecificLotTracking := ItemTrackingCodeRecLcl."Lot Specific Tracking";
            SpecificSNTracking := ItemTrackingCodeRecLcl."SN Specific Tracking";
        end else begin
            SpecificLotTracking := false;
            SpecificSNTracking := false;
        end;

        if SpecificLotTracking then
            if LotNoPar = '' then
                error(StrSubstNo(LotNoCannotBeEmptyErrLbl, ItemNoPar));

        if LotNoPar <> '' then
            if not SpecificLotTracking then
                error(StrSubstNo(LotNoMustBeEmptyErrLbl, ItemNoPar));

        If SpecificSNTracking then
            if SerialNoPar = '' then
                error(StrSubstNo(SerialCannotBeEmptyErrLbl, ItemNoPar));

        if SerialNoPar <> '' then
            if not SpecificSNTracking then
                error(StrSubstNo(SerialNoMustBeEmptyErrLbl, ItemNoPar));

    end;

    var
        ItemGbl: Record Item;
        SelectedJournalBatchNameGbl, SelectedJournalTemplateNameGbl : Code[10];
        SelectedPostingDateGbl: Date;
        SelectedDocumentNoGbl: Code[20];
        LineNoGbl: Integer;
        HeaderVarGbl: Boolean;
        ReservationMgmt: Codeunit "Reservation Management";
        ItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ForReservEntry: Record "Reservation Entry";
        ReservationStatus: Enum "Reservation Status";




}