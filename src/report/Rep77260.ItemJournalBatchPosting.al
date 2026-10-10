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
                ErrorText: Text;
                LineNo: Integer;
                ItemNo: Code[20];
            begin
                LineToPost := ItemJnlLine;
                LineToPost.SetRecFilter();

                ClearLastError();

                if not PostingMgt.Run(LineToPost) then begin
                    ErrorText := GetLastErrorText();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {

        }
    }
}