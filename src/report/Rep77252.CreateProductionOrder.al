report 77252 "ADC Create Production Order"
{
    ApplicationArea = All;
    Caption = 'Create Production Order';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ProductionOrderStage; "ADC Production Order Stage")
        {
            DataItemTableView = sorting("Entry No.") where(Processed = const(false));

            trigger OnPreDataItem()
            begin
                Window.Open('Processing Prod. Order No. #####1##########');
            end;

            trigger OnAfterGetRecord()
            var
                ErrorTxtLcl: Text;
            begin
                Window.Update(1, "Prod. Order No.");
                Clear(ProcessProdOrders);
                ClearLastError();
                if not ProcessProdOrders.Run(ProductionOrderStage) then begin
                    ProductionOrderStage.Processed := false;
                    ErrorTxtLcl := GetLastErrorText();
                    ProductionOrderStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                    ProductionOrderStage.Modify();
                end else begin
                    ProductionOrderStage.Processed := true;
                    ProductionOrderStage."Error Text" := '';
                    ProductionOrderStage.Modify();
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
        ProcessProdOrders: Codeunit "ADC Process Production Orders";
}
