xmlport 77252 "ADC Test step Export"
{
    Caption = 'Test step Export ';
    Direction = Export;
    FormatEvaluate = Legacy;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    RecordSeparator = '<CR/LF>';
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
                    Width = 0;
                }
                trigger OnAfterGetRecord()
                begin
                    GetMergedTestSteps(TestStepHeader."No.");
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
        Seperator: Text[1];
    begin
        TestSteps := '';
        Seperator := GetActualSeperator(GoLiveImplSetupRecGbl."Test Steps Line Separator");

        TestStepLineRec.Reset();
        TestStepLineRec.SetRange("Document No.", StepNoPar);
        TestStepLineRec.SetCurrentKey("Document No.", "Line No.");

        if TestStepLineRec.FindSet() then begin
            repeat
                if TestSteps <> '' then
                    TestSteps += Seperator;

                TestSteps += TestStepLineRec."Test Step Description";

            until TestStepLineRec.Next() = 0;
        end;

        exit(TestSteps);
    end;

    local procedure GetActualSeperator(TestStepLineSeperatorPar: Enum "ADC Test Steps Line Separator"): Text[1];
    var
        TypeHelper: Codeunit "Type Helper";
        CRLF: Text[2];
    begin
        CRLF := TypeHelper.CRLFSeparator();
        Case TestStepLineSeperatorPar of
            TestStepLineSeperatorPar::CR:
                exit(CRLF[1]);
            TestStepLineSeperatorPar::LF:
                exit(CRLF[2]);
        end;
    end;

    var
        GoLiveImplSetupRecGbl: Record "ADC Go Live Impl. Setup";
}
