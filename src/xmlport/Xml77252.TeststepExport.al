xmlport 77252 "ADC Test step Export"
{
    Caption = 'Test step Export ';
    Direction = Export;
    FormatEvaluate = Legacy;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    RecordSeparator = '<NewLine>';
    UseRequestPage = false;
    Format = VariableText;
    FileName = 'TestSteps.csv';
    TextEncoding = UTF8;

    schema
    {
        textelement(Root)
        {
            tableelement(TestStepHeader; "ADC Test Step Header")
            {
                RequestFilterFields = "No.";
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                fieldelement(No; TestStepHeader."No.")
                {
                }
                textelement(TestSteps)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    TestSteps := GetMergedTestSteps(TestStepHeader."No.");
                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        GoLiveImplSetupRecGbl.Get();
        GoLiveImplSetupRecGbl.TestField("Test Steps Line Separator");
    end;

    local procedure GetMergedTestSteps(StepNoPar: Code[20]): Text
    var
        TestStepLineRec: Record "ADC Test Step Line";
        Seperator: Text;
    begin
        MergedTestSteps := '';
        Seperator := GetActualSeperator(Format(GoLiveImplSetupRecGbl."Test Steps Line Separator"));

        TestStepLineRec.Reset();
        TestStepLineRec.SetRange("Document No.", StepNoPar);

        if TestStepLineRec.FindSet() then
            repeat
                if MergedTestSteps <> '' then
                    MergedTestSteps += Seperator;

                MergedTestSteps += TestStepLineRec."Test Step Description";

            until TestStepLineRec.Next() = 0;

        exit(MergedTestSteps);
    end;

    local procedure GetActualSeperator(ConfiguredSeperator: Text): Text
    var
        CRLF: Text[2];
    begin
        CRLF[1] := 13; // Carriage Return
        CRLF[2] := 10; // Line Feed

        Case UpperCase(ConfiguredSeperator) of
            'CRLF':
                exit(CRLF);
        End;
    end;

    var
        GoLiveImplSetupRecGbl: Record "ADC Go Live Impl. Setup";
        MergedTestSteps: Text;
}
