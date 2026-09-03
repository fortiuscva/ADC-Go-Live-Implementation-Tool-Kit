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
                    Width = 0;
                    trigger OnBeforePassVariable()
                    begin
                        TestSteps := GetMergedTestSteps(TestStepHeader."No.");
                    end;
                }
            }
        }
    }

    local procedure GetMergedTestSteps(StepNoPar: Code[20]): Text
    var
        TestStepLineRec: Record "ADC Test Step Line";
        TypeHelper: Codeunit "Type Helper";
        Seperator: Text[2];
    begin
        MergedTestSteps := '';
        Seperator := TypeHelper.CRLFSeparator();

        TestStepLineRec.Reset();
        TestStepLineRec.SetRange("Document No.", StepNoPar);
        TestStepLineRec.SetCurrentKey("Document No.", "Line No.");

        if TestStepLineRec.FindSet() then
            repeat
                if MergedTestSteps <> '' then
                    MergedTestSteps += Seperator;

                MergedTestSteps += TestStepLineRec."Test Step Description";

            until TestStepLineRec.Next() = 0;
        exit(MergedTestSteps);
    end;

    var
        GoLiveImplSetupRecGbl: Record "ADC Go Live Impl. Setup";
        MergedTestSteps: Text;
}
