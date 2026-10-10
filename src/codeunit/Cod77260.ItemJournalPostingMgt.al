codeunit 77260 "ADC Item Journal Posting Mgt."
{
    TableNo = "Item Journal Line";

    trigger OnRun()
    var
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        ItemJnlLine.Copy(Rec);

        if ItemJnlLine.IsEmpty() then
            exit;

        ItemJnlPostBatch.Run(ItemJnlLine);
    end;
}
