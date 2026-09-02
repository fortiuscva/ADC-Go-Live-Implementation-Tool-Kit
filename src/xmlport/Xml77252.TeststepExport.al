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
                // fieldelement(DefaultTestCaseNo; TestStepHeader."Default Test Case No.")
                // {
                // }
                // fieldelement(Description; TestStepHeader.Description)
                // {
                // }
                // fieldelement(DataPoints; TestStepHeader."Data Points")
                // {
                // }
                // fieldelement(ExpectedResult; TestStepHeader."Expected Result")
                // {
                // }
                textelement(TestSteps)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TestSteps := MergedTestSteps;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    TestStepLineRec: Record "ADC Test Step Line";
                    Seperator: Text;
                begin
                    MergedTestSteps := '';
                    Seperator := GetActualSeperator(Format(GoLiveImplSetupRecGbl."Test Steps Line Separator"));

                    TestStepLineRec.Reset();
                    TestStepLineRec.SetRange("Document No.", TestStepHeader."No.");

                    if TestStepLineRec.FindSet() then
                        repeat
                            if MergedTestSteps <> '' then
                                MergedTestSteps += Seperator;

                            MergedTestSteps += TestStepLineRec."Test Step Description";

                        until TestStepLineRec.Next() = 0;
                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin
        GoLiveImplSetupRecGbl.Get();
        GoLiveImplSetupRecGbl.TestField("Test Steps Line Separator");
    end;

    local procedure GetActualSeperator(ConfiguredSeperator: Text): Text
    var
        CRLF: Text[2];
    begin
        CRLF[1] := 13; // Carriage Return
        CRLF[2] := 10; // Line Feed

        Case UpperCase(ConfiguredSeperator) of
            'CRLF':
                exit(Format(CRLF[1]) + Format(CRLF[2]));
        End;
    end;

    var
        GoLiveImplSetupRecGbl: Record "ADC Go Live Impl. Setup";
        MergedTestSteps: Text;
}
