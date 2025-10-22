report 77255 "Create Prod. Order Rtng Lines"
{
    ApplicationArea = All;
    Caption = 'Create Prod. Order Routing Lines';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("ProdOrderRoutingLineStage"; "Prod. Order Routing Line Stage")
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
                ProdOrderRoutingLinesByNo.Open();
                while ProdOrderRoutingLinesByNo.Read() do begin
                    Window.Update(1, ProdOrderRoutingLineStage."Prod. Order No.");
                    Clear(ProcessProdOrderRoutingLines);
                    ClearLastError();

                    if not ProcessProdOrderRoutingLines.Run(ProdOrderRoutingLineStage) then begin
                        ProdOrderRoutingLineStage.Processed := false;
                        ErrorTxtLcl := GetLastErrorText();
                        ProdOrderRoutingLineStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                        ProdOrderRoutingLineStage.Modify();
                    end else begin
                        ProdOrderRoutingLineStage.Processed := true;
                        ProdOrderRoutingLineStage."Error Text" := '';
                        ProdOrderRoutingLineStage.Modify();
                    end;

                    Commit();
                end;
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;
        }
    }

    var
        Window: Dialog;
        ProcessProdOrderRoutingLines: Codeunit "Process Prod.  OrderRtng Lines";
        ProdOrderRoutingLinesByNo: Query "ADC ProdOrderRoutingLinesByNo.";
}