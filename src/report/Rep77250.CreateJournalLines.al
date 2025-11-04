report 77250 "ADC Create Journal Lines"
{
    Caption = 'Create Journal Lines';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(ADCItemJournalLineStage; "ADC Item Journal Line Stage")
        {
            DataItemTableView = sorting("Entry No.") where(Processed = const(false));

            trigger OnPreDataItem()
            begin
                Window.Open('Processing Entry No. #####1##########');
            end;

            trigger OnAfterGetRecord()
            var
                ErrorTxtLcl: Text;
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                Window.Update(1, ADCItemJournalLineStage."Entry No.");
                LineNoGbl += 10000;
                Clear(ProcessJnlLines);
                ProcessJnlLines.SetValues(SelectedPostingDateGbl, SelectedJournalTemplateNameGbl, SelectedJournalBatchNameGbl, SelectedDocumentNoGbl, LineNoGbl);
                ClearLastError();

                if CheckDuplicateSerialNoGbl and (ADCItemJournalLineStage."Serial No." <> '') then begin
                    ItemLedgEntry.Reset();
                    ItemLedgEntry.SetRange("Item No.", ADCItemJournalLineStage."Item No.");
                    ItemLedgEntry.SetRange("Serial No.", ADCItemJournalLineStage."Serial No.");
                    if ItemLedgEntry.FindFirst() then begin
                        ErrorTxtLcl := StrSubstNo(DuplicateSerialNoErrorMsgLbl, ADCItemJournalLineStage."Serial No.", ADCItemJournalLineStage."Item No.");

                        ADCItemJournalLineStage.Processed := false;
                        ADCItemJournalLineStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                        ADCItemJournalLineStage.Modify();
                        Commit();
                        exit;
                    end;
                end;

                if not ProcessJnlLines.Run(ADCItemJournalLineStage) then begin
                    ADCItemJournalLineStage.Processed := false;
                    ErrorTxtLcl := GetLastErrorText();
                    ADCItemJournalLineStage."Error Text" := CopyStr(ErrorTxtLcl, 1, StrLen(ErrorTxtLcl));
                    ADCItemJournalLineStage.Modify();
                end else begin
                    ADCItemJournalLineStage.Processed := true;
                    ADCItemJournalLineStage."Error Text" := '';
                    ADCItemJournalLineStage.Modify();
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
                    field(SelectedPostingDateGbl; SelectedPostingDateGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                    }
                    field(SelectedJournalTemplateNameGbl; SelectedJournalTemplateNameGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Journal Template Name';
                        TableRelation = "Item Journal Template" where(Type = const(Item),
                                                                   Recurring = const(false));
                    }
                    field(SelectedJournalBatchNameGbl; SelectedJournalBatchNameGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Journal Batch Name';
                        TableRelation = "Item Journal Batch".Name;
                    }
                    field(SelectedDocumentNoGbl; SelectedDocumentNoGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                    }
                    field(CheckDuplicateSerialNoGbl; CheckDuplicateSerialNoGbl)
                    {
                        ApplicationArea = All;
                        Caption = 'Check for Duplicate Serial No.';
                    }

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        SelectedPostingDateGbl := Today;
        SelectedJournalTemplateNameGbl := 'ITEM';
        SelectedJournalBatchNameGbl := 'DEFAULT';
        SelectedDocumentNoGbl := 'OPENING BALANCE';
    end;

    trigger OnPreReport()
    var
        ItemJnlLineLcl: Record "Item Journal Line";
    begin
        ItemJnlLineLcl.SetRange("Journal Template Name", SelectedJournalTemplateNameGbl);
        ItemJnlLineLcl.SetRange("Journal Batch Name", SelectedJournalBatchNameGbl);
        if not ItemJnlLineLcl.FindLast() then
            LineNoGbl := 1000
        else
            LineNoGbl := ItemJnlLineLcl."Line No." + 1000;
    end;

    var
        SelectedJournalBatchNameGbl, SelectedJournalTemplateNameGbl : Code[10];
        SelectedPostingDateGbl: Date;
        SelectedDocumentNoGbl: Code[20];
        LineNoGbl: Integer;
        ProcessJnlLines: Codeunit "ADC Process Item Jnl. Lines";
        Window: Dialog;
        CheckDuplicateSerialNoGbl: Boolean;
        DuplicateSerialNoErrorMsgLbl: Label 'Serial No. %1 already exists for Item %2.';

}
