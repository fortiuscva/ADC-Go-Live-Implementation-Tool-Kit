report 77251 "ADC Create BOM Components"
{
    ApplicationArea = All;
    Caption = 'Create BOM Components';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {

        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            trigger OnAfterGetRecord()
            begin

                BOMCompByParentItem.Open();
                while BOMCompByParentItem.Read() do begin
                    Window.Update(1, BOMCompByParentItem.ParentItemNo);
                    BOMCompStagingRec.Reset();
                    BOMCompStagingRec.SetRange("Parent Item No.", BOMCompByParentItem.ParentItemNo);
                    BOMCompStagingRec.SetRange(Processed, false);
                    Clear(ProcessBOMComponents);
                    ClearLastError();
                    if not ProcessBOMComponents.Run(BOMCompStagingRec) then begin
                        ErrorTxtGbl := GetLastErrorText();
                        BOMCompStagingRec.ModifyAll(Processed, false);
                        BOMCompStagingRec.ModifyAll("Error Text", ErrorTxtGbl);
                        BOMCompStagingRec.Modify();
                    end else begin
                        BOMCompStagingRec.ModifyAll(Processed, true);
                        BOMCompStagingRec.ModifyAll("Error Text", '');
                        BOMCompStagingRec.Modify();
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
        ProcessBOMComponents: Codeunit "ADC Process BOM Components";
        BOMCompByParentItem: Query "ADC BOM Components By Parent";
        BOMCompStagingRec: Record "ADC BOM Component Stage";
        ErrorTxtGbl: Text;
}
