report 77254 "Create Prod. Order Components"
{
    ApplicationArea = All;
    Caption = 'Create Prod. Order Components';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(ProdOrderComponentStage; "ADC Prod. Order Comp. Stage")
        {
            DataItemTableView = sorting("Entry No.") where(Processed = const(false));

            trigger OnPreDataItem()
            begin
                Window.Open('Processing Component Item No. #####1##########');
            end;

            trigger OnAfterGetRecord()
            var
                ErrorTxtLcl: Text;
            begin
                ProdOrderBomsbyNo.Open();

                while ProdOrderBomsbyNo.Read() do begin
                    Window.Update(1, ProdOrderComponentStage."Comp. Item No.");
                    ProdOrderComponentStage.Reset();
                    ProdOrderComponentStage.SetRange("Prod. Order No.", ProdOrderBomsbyNo.ProdOrderNo);
                    ProdOrderComponentStage.SetRange(Processed, false);
                    if ProdOrderComponentStage.FindFirst() then;
                    Clear(ProcessProdOrderComponents);
                    ClearLastError();

                    if not ProcessProdOrderComponents.Run(ProdOrderComponentStage) then begin
                        ProdOrderComponentStage.Processed := false;
                        ErrorTxtLcl := GetLastErrorText();
                        ProdOrderComponentStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                        ProdOrderComponentStage.Modify();
                    end else begin
                        ProdOrderComponentStage.Processed := true;
                        ProdOrderComponentStage."Error Text" := '';
                        ProdOrderComponentStage.Modify();
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
        ProcessProdOrderComponents: Codeunit "Process Prod. Order Components";
        ProdOrderBomsbyNo: Query "ADC ProdOrder Boms by  No.";
}

