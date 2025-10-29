codeunit 77257 "ADC Go Live Single Instance"
{
    SingleInstance = true;

    procedure SetHideDeleteItemTrackingConfirm(SuppressVar: Boolean)
    begin
        HideDeleteItemTrackingConfirm := SuppressVar;
    end;

    procedure GetHideDeleteItemTrackingConfirm(): Boolean
    begin
        exit(HideDeleteItemTrackingConfirm);
    end;

    var
        HideDeleteItemTrackingConfirm: Boolean;

}
