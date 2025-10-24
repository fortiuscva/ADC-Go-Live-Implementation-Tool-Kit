report 77253 "Create Production Order Lines"
{
    ApplicationArea = All;
    Caption = 'Create Production Order Lines';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ADCProdOrderLineStage; "ADC Prod. Order Line Stage")
        {
            DataItemTableView = sorting("Entry No.") where(Processed = const(false));

            trigger OnPreDataItem()
            begin
                Window.Open('Processing Item No. #####1##########');
            end;

            trigger OnAfterGetRecord()
            var
                ErrorTxtLcl: Text;
            begin
                Window.Update(1, "Item No.");
                Clear(ProcessProdOrderLineCU);
                ClearLastError();
                if not ProcessProdOrderLineCU.ProcessProdOrderLines(ADCProdOrderLineStage) then begin
                    ADCProdOrderLineStage.Processed := false;
                    ErrorTxtLcl := GetLastErrorText();
                    ADCProdOrderLineStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                    ADCProdOrderLineStage.Modify();
                end else begin
                    ADCProdOrderLineStage.Processed := true;
                    ADCProdOrderLineStage."Error Text" := '';
                    ADCProdOrderLineStage.Modify();
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
        ProcessProdOrderLineCU: Codeunit "ADC Process Prod. Order Line";
}
