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

    procedure SetHideRoutingNoValidation(SuppressValidationVar: Boolean)
    begin
        HideRoutingNoValidation := SuppressValidationVar;
    end;

    procedure GetHideRoutingNoValidation(): Boolean
    begin
        exit(HideRoutingNoValidation);
    end;

    procedure SetHideProdBOMNoValidation(SuppressValidationVar: Boolean)
    begin
        HideProdBOMNoValidation := SuppressValidationVar;
    end;

    procedure GetHideProdBOMNoValidation(): Boolean
    begin
        exit(HideProdBOMNoValidation);
    end;

    var
        HideDeleteItemTrackingConfirm: Boolean;
        HideRoutingNoValidation: Boolean;
        HideProdBOMNoValidation: Boolean;
   
}
