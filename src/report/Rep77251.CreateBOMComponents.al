report 77251 "ADC Create BOM Components"
{
    ApplicationArea = All;
    Caption = 'Create BOM Components';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ADCBOMComponentStage; "ADC BOM Component Stage")
        {
            DataItemTableView = sorting("Entry No.") where(Processed = const(false));
            trigger OnPreDataItem()
            begin
                Window.Open('Processing Parent Item No. #####1##########');
            end;

            trigger OnAfterGetRecord()
            var
                ErrorTxtLcl: Text;
            begin
                Window.Update(1, ADCBOMComponentStage."Parent Item No.");
                Clear(ProcessBOMComponents);
                ClearLastError();
                if not ProcessBOMComponents.Run(ADCBOMComponentStage) then begin
                    ADCBOMComponentStage.Processed := false;
                    ErrorTxtLcl := GetLastErrorText();
                    ADCBOMComponentStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                    ADCBOMComponentStage.Modify();
                end else begin
                    ADCBOMComponentStage.Processed := true;
                    ADCBOMComponentStage."Error Text" := '';
                    ADCBOMComponentStage.Modify();
                end;
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;
        }
    }
    var
        Window: Dialog;
        ProcessBOMComponents: Codeunit "ADC Process BOM Components";
}
