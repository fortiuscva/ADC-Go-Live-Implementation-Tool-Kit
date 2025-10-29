codeunit 77256 "ADC Event Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reservation Management", OnBeforeDeleteItemTrackingConfirm, '', false, false)]
    local procedure "Reservation Management_OnBeforeDeleteItemTrackingConfirm"(var Sender: Codeunit "Reservation Management"; var CalcReservEntry2: Record "Reservation Entry"; var IsHandled: Boolean; var Result: Boolean)
    var
        SuppressConfirmationCU: Codeunit "ADC Suppress Confirmation";
    begin
        if SuppressConfirmationCU.GetSuppress() then begin
            IsHandled := true;
            Result := true;
        end;
    end;

}
