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

    var
        GoLiveSingleInstance: Codeunit "ADC Go Live Single Instance";


}
