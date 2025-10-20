codeunit 77250 "ADC Process Item Jnl. Lines"
{
    TableNo = "ADC Item Journal Line Stage";
    trigger OnRun()
    Var
        LotNoInfoLcl: Record "Lot No. Information";
        QuantityLcl: Decimal;
        UnitCostLcl: Decimal;
        ItemGbl: Record Item;
        ItemJnlLineRecLcl: Record "Item Journal Line";
    begin
        Rec.TestField(Quantity);

        ItemGbl.Get(Rec."Item No.");
        ItemGbl.TestField(Blocked, false);

        ItemJnlLineRecLcl.Init();
        ItemJnlLineRecLcl.Validate("Journal Template Name", SelectedJournalTemplateNameGbl);
        ItemJnlLineRecLcl.Validate("Journal Batch Name", SelectedJournalBatchNameGbl);
        ItemJnlLineRecLcl.Validate("Line No.", LineNoGbl);
        ItemJnlLineRecLcl.Insert(true);

        ItemJnlLineRecLcl.Validate("Posting Date", SelectedPostingDateGbl);
        ItemJnlLineRecLcl.Validate("Document No.", SelectedDocumentNoGbl);
        ItemJnlLineRecLcl.Validate("Entry Type", ItemJnlLineRecLcl."Entry Type"::"Positive Adjmt.");
        ItemJnlLineRecLcl.Validate("Item No.", Rec."Item No.");
        if Rec.UOM <> '' then
            ItemJnlLineRecLcl.Validate("Unit of Measure Code", Rec.UOM);
        ItemJnlLineRecLcl.Validate(Quantity, Rec.Quantity);

        ItemJnlLineRecLcl.Validate("Location Code", Rec."Location Code");
        ItemJnlLineRecLcl.Validate("Unit Cost", UnitCostLcl);

        if Rec."Bin Code" <> '' then
            ItemJnlLineRecLcl.Validate("Bin Code", Rec."Bin Code");

        ItemJnlLineRecLcl.Modify(true);

        if (Rec."Lot No." <> '') or (Rec."Serial No." <> '') then begin
            LotNoGbl := Rec."Lot No.";
            SerialNoGbl := Rec."Serial No.";

            ReservationStatus := ReservationStatus::Prospect;
            CheckForTracking(ItemGbl."No.", LotNoGbl, SerialNoGbl);
            ItemJnlLineRecLcl.SetReservationEntry(ForReservEntry);
            ForReservEntry."Lot No." := LotNoGbl;
            ForReservEntry."Serial No." := SerialNoGbl;
            ForReservEntry."Expiration Date" := Rec."Expiration Date";
            CreateReservEntry.CreateReservEntryFor(
              DATABASE::"Item Journal Line",
              ItemJnlLineRecLcl."Entry Type".AsInteger(), ItemJnlLineRecLcl."Journal Template Name",
              ItemJnlLineRecLcl."Journal Batch Name", 0, ItemJnlLineRecLcl."Line No.", ItemJnlLineRecLcl."Qty. per Unit of Measure",
              ItemJnlLineRecLcl.Quantity, ItemJnlLineRecLcl."Quantity (Base)", ForReservEntry);
            CreateReservEntry.CreateEntry(
              ItemJnlLineRecLcl."Item No.", ItemJnlLineRecLcl."Variant Code", ItemJnlLineRecLcl."Location Code",
              ItemJnlLineRecLcl.Description, ItemJnlLineRecLcl."Posting Date", 0D, 0, ReservationStatus);
        end;
        LineNoGbl := LineNoGbl + 1000;
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

    procedure SetValues(SelectedPostingDatePar: Date; SelectedJournalTemplateNamePar: Code[10]; SelectedJournalBatchNamePar: Code[10]; SelectedDocumentNoPar: Code[20]; LineNoPar: Integer)
    begin
        SelectedPostingDateGbl := SelectedPostingDatePar;
        SelectedJournalTemplateNameGbl := SelectedJournalTemplateNamePar;
        SelectedJournalBatchNameGbl := SelectedJournalBatchNamePar;
        SelectedDocumentNoGbl := SelectedDocumentNoPar;
        LineNoGbl := LineNoPar;
    end;

    Var
        SelectedJournalBatchNameGbl, SelectedJournalTemplateNameGbl : Code[10];
        SelectedPostingDateGbl: Date;
        SelectedDocumentNoGbl: Code[20];
        LineNoGbl: Integer;
        LotNoGbl: Code[20];
        SerialNoGbl: Code[20];
        ReservationMgmt: Codeunit "Reservation Management";
        ItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ForReservEntry: Record "Reservation Entry";
        ReservationStatus: Enum "Reservation Status";


}
