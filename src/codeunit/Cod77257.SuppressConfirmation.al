codeunit 77257 "ADC Suppress Confirmation"
{
    SingleInstance = true;

    procedure SetSuppress(SuppressVar: Boolean)
    begin
        SuppressConfirm := SuppressVar;
    end;

    procedure GetSuppress(): Boolean
    begin
        exit(SuppressConfirm);
    end;

    var
        SuppressConfirm: Boolean;

}
