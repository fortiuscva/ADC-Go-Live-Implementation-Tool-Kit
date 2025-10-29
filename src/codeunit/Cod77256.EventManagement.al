codeunit 77256 "ADC Event Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeDeleteItemTrackingConfirm, '', false, false)]
    local procedure "Reservation Management_OnBeforeDeleteItemTrackingConfirm"(var Sender: Codeunit "Reservation Management"; var CalcReservEntry2: Record "Reservation Entry"; var IsHandled: Boolean; var Result: Boolean)
    var
        GoLiveSingleInstance: Codeunit "ADC Go Live Single Instance";
    begin
        if GoLiveSingleInstance.GetHideDeleteItemTrackingConfirm() then begin
            IsHandled := true;
            Result := true;
        end;
    end;

}
