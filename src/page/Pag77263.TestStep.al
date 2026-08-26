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
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
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
                    Clear(FunctionsCULcl);
                    FunctionsCULcl.SynchronizeUpdatesToTestCases(Rec);
                end;
            }
        }
    }
}
