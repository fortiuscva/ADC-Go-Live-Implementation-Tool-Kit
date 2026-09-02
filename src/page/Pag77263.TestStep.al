page 77263 "ADC Test Step"
{
    ApplicationArea = All;
    Caption = 'Test Step';
    PageType = Document;
    SourceTable = "ADC Test Step Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field("Default Test Case No."; Rec."Default Test Case No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ToolTip = 'Specifies the value of the Default Test Case No. field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
            part(Lines; "ADC Test Step Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No.");
            }
            group("Data Points/Test Data")
            {
                Caption = 'Data Points/Test Data';
                field(DataPointsOrTestData; Rec."Data Points")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Data Points/Test Data field.', Comment = '%';
                }
            }
            group("Expected Result")
            {
                Caption = 'Expected Result';
                field(ExpectedResult; Rec."Expected Result")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"ADC Test Step Header"), "No." = field("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SynchronizeUpdates)
            {
                ApplicationArea = All;
                Caption = 'Synchronize Updates';
                Image = UpdateDescription;
                Ellipsis = true;
                ToolTip = 'Synchronize the updates on the associated test cases.';
                trigger OnAction()
                var
                    FunctionsCULcl: Codeunit "ADC Go Live Functions";
                begin
                    if not Confirm('Do you want to synchronize updates to the associated test case lines?', false) then
                        exit;
                    FunctionsCULcl.SynchronizeUpdatesToTestCases(Rec);
                end;
            }
            action(ExporttoExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';

                trigger OnAction()
                var
                    TestStepExport: XmlPort "ADC Test step Export";
                    TestStepHeader: Record "ADC Test Step Header";
                begin
                    CurrPage.SetSelectionFilter(TestStepHeader);
                    Xmlport.Run(Xmlport::"ADC Test step Export", true, false, TestStepHeader);
                end;
            }
            //             HeaderRec: Record "ADC Test Step Header";
            //             LineRec: Record "ADC Test Step Line";
            //             ExcelBuf: Record "Excel Buffer" temporary;
            //             CombinedLines: Text;
            //         begin
            //             ExcelBuf.DeleteAll();

            //             ExcelBuf.NewRow();
            //             ExcelBuf.AddColumn('Test Step', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            //             ExcelBuf.AddColumn('Test Step Lines', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);

            //             // Loop through each Header
            //             if HeaderRec.FindSet() then
            //                 repeat
            //                     CombinedLines := '';

            //                     LineRec.SetRange(LineRec."Document No.", HeaderRec."No.");
            //                     if LineRec.FindSet() then
            //                         repeat
            //                             if CombinedLines = '' then
            //                                 CombinedLines := LineRec."Test Step Description"
            //                             else
            //                                 CombinedLines := CombinedLines + '#(lf)' + LineRec."Test Step Description";
            //                         until LineRec.Next() = 0;

            //                     ExcelBuf.NewRow();
            //                     ExcelBuf.AddColumn(HeaderRec."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            //                     ExcelBuf.AddColumn(CombinedLines, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
            //                 until HeaderRec.Next() = 0;

            //             ExcelBuf.CreateNewBook('Test Step Export');
            //             ExcelBuf.WriteSheet('Test Steps', CompanyName, UserId);
            //             ExcelBuf.CloseBook();
            //             ExcelBuf.OpenExcel();
            //         end;
            //     }
            // }
        }
        area(Promoted)
        {
            actionref(SynchronizeUpdates_Promoted; SynchronizeUpdates)
            {
            }
        }
    }
}
