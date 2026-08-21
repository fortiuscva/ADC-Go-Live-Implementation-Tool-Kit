codeunit 77256 "ADC Event Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeDeleteItemTrackingConfirm, '', false, false)]
    local procedure "Reservation Management_OnBeforeDeleteItemTrackingConfirm"(var Sender: Codeunit "Reservation Management"; var CalcReservEntry2: Record "Reservation Entry"; var IsHandled: Boolean; var Result: Boolean)
    begin
        if GoLiveSingleInstance.GetHideDeleteItemTrackingConfirm() then begin
            IsHandled := true;
            Result := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeCheckQuantityIsCompletelyReleased, '', false, false)]
    local procedure "Reservation Management_OnBeforeCheckQuantityIsCompletelyReleased"(ItemTrackingHandling: Option; QtyToRelease: Decimal; DeleteAll: Boolean; CurrentItemTrackingSetup: Record "Item Tracking Setup" temporary; ReservEntry: Record "Reservation Entry"; var IsHandled: Boolean)
    begin
        if GoLiveSingleInstance.GetHideDeleteItemTrackingConfirm() then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", OnBeforeCheckRoutingNoNotBlank, '', false, false)]
    local procedure "Prod. Order Routing Line_OnBeforeCheckRoutingNoNotBlank"(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var IsHandled: Boolean)

    begin
        if GoLiveSingleInstance.GetHideRoutingNoValidation() then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", OnValidateProductionBOMNoOnBeforeTestStatus, '', false, false)]
    local procedure "Prod. Order Line_OnValidateProductionBOMNoOnBeforeTestStatus"(var ProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    begin
        if GoLiveSingleInstance.GetHideProdBOMNoValidation() then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Doc. Attachment List Factbox", OnAfterGetRecRefFail, '', false, false)]
    local procedure "Doc. Attachment List Factbox_OnAfterGetRecRefFail"(var Sender: Page "Doc. Attachment List Factbox"; var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        TestCaseHeaderRecLcl: Record "ADC Test Case Header";
    begin
        Case DocumentAttachment."Table ID" Of
            Database::"ADC Test Case Header":
                begin
                    RecRef.Open(Database::"ADC Test Case Header");
                    if TestCaseHeaderRecLcl.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(TestCaseHeaderRecLcl);
                end;
        End;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnAfterInitFieldsFromRecRef, '', false, false)]
    local procedure "Document Attachment_OnAfterInitFieldsFromRecRef"(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        Case RecRef.Number Of
            Database::"ADC Test Case Header":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        End;
    end;




    var
        GoLiveSingleInstance: Codeunit "ADC Go Live Single Instance";


}
