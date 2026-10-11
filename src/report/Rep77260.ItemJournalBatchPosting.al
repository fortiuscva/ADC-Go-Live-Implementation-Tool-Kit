report 77260 "ADC Item Journal Batch Posting"
{
    Caption = 'Item Journal Batch Posting';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(ItemJnlLine; "Item Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";

            trigger OnAfterGetRecord()
            var
                PostingMgt: Codeunit "ADC Item Journal Posting Mgt.";
                LineToPost: Record "Item Journal Line";
                PostingLog: Record "ADC Item Jounral posting Log";
                ErrorText: Text;
                LineNo: Integer;
                ItemNo: Code[20];
            begin
                LineToPost := ItemJnlLine;
                LineToPost.SetRecFilter();

                ClearLastError();

                if not PostingMgt.Run(LineToPost) then begin
                    ErrorText := GetLastErrorText();

                    PostingLog.Init();
                    PostingLog."Journal Name" := ItemJnlLine."Journal Template Name";
                    PostingLog."Batch Name" := ItemJnlLine."Journal Batch Name";
                    PostingLog."Item No." := ItemJnlLine."Item No.";
                    PostingLog."Line No." := ItemJnlLine."Line No.";
                    PostingLog.Quantity := ItemJnlLine.Quantity;
                    PostingLog."Error Msg" := CopyStr(ErrorText, 1, MaxStrLen(PostingLog."Error Msg"));
                    PostingLog.Insert(true);
                end;
                Commit();
            end;
        }
    }

    requestpage
    {
        layout
        {

        }
    }
    trigger OnPostReport()
    var
        PostingLog: Record "ADC Item Jounral posting Log";
    begin
        PostingLog.DeleteAll();
        Commit();
    end;
}