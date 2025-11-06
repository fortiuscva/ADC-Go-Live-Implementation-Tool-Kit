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
                ProdOrderLineStage: Record "ADC Prod. Order Line Stage";
                ProdOrderCompStagingRecLcl: Record "ADC Prod. Order Comp. Stage";
                ProdOrderRoutingLineStagingRecLcl: Record "Prod. Order Routing Line Stage";
            begin
                Window.Update(1, "Prod. Order No.");
                Clear(ProcessProdOrders);
                ClearLastError();
                ProcessProdOrders.SetValidationOptions(ValidateRoutingNo, ValidateProdBOMNo);
                if not ProcessProdOrders.Run(ProductionOrderStage) then begin
                    ProductionOrderStage.Processed := false;
                    ErrorTxtLcl := GetLastErrorText();
                    ProductionOrderStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                    ProductionOrderStage.Modify();

                    ProdOrderLineStage.Reset();
                    ProdOrderLineStage.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderLineStage.ModifyAll(Processed, false);
                    ProdOrderLineStage.ModifyAll("Error Text", ProductionOrderStage."Error Text");


                    ProdOrderCompStagingRecLcl.Reset();
                    ProdOrderCompStagingRecLcl.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderCompStagingRecLcl.ModifyAll(Processed, false);
                    ProdOrderCompStagingRecLcl.ModifyAll("Error Text", ProductionOrderStage."Error Text");

                    ProdOrderRoutingLineStagingRecLcl.Reset();
                    ProdOrderRoutingLineStagingRecLcl.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderRoutingLineStagingRecLcl.ModifyAll(Processed, false);
                    ProdOrderRoutingLineStagingRecLcl.ModifyAll("Error Text", ProductionOrderStage."Error Text");
                end else begin
                    ProductionOrderStage.Processed := true;
                    ProductionOrderStage."Error Text" := '';
                    ProductionOrderStage.Modify();

                    ProdOrderLineStage.Reset();
                    ProdOrderLineStage.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderLineStage.ModifyAll(Processed, true);
                    ProdOrderLineStage.ModifyAll("Error Text", '');


                    ProdOrderCompStagingRecLcl.Reset();
                    ProdOrderCompStagingRecLcl.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderCompStagingRecLcl.ModifyAll(Processed, true);
                    ProdOrderCompStagingRecLcl.ModifyAll("Error Text", '');

                    ProdOrderRoutingLineStagingRecLcl.Reset();
                    ProdOrderRoutingLineStagingRecLcl.SetRange("Prod. Order No.", ProductionOrderStage."Prod. Order No.");
                    ProdOrderRoutingLineStagingRecLcl.ModifyAll(Processed, true);
                    ProdOrderRoutingLineStagingRecLcl.ModifyAll("Error Text", '');

                end;
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ValidateRoutingNo; ValidateRoutingNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Validate Routing No.';
                        ToolTip = 'Enable to validate Routing No. during production order creation.';
                    }
                    field(ValidateProdBOMNo; ValidateProdBOMNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Validate Production BOM No.';
                        ToolTip = 'Enable to validate Production BOM No. during production order creation.';
                    }
                }
            }
        }
    }



    var
        Window: Dialog;
        ProcessProdOrders: Codeunit "ADC Process Production Orders";
        ValidateRoutingNo: Boolean;
        ValidateProdBOMNo: Boolean;
}
