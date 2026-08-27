page 77261 "ADC Test Case Subform"
{
    ApplicationArea = All;
    Caption = 'Test Case Subform';
    PageType = ListPart;
    SourceTable = "ADC Test Case Line";
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Data Points"; Rec."Data Points")
                {
                    ToolTip = 'Specifies the value of the Data Points/Test Data field.', Comment = '%';
                }
                field("Teststep ID"; Rec."Step ID")
                {
                    ToolTip = 'Specifies the value of the Test Steps field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        Teststep: Record "ADC Test Step Header";
                    begin
                        Teststep.Reset();
                        Teststep.Get(Rec."Step ID");
                        Page.Run(Page::"ADC Test Step", Teststep);
                    end;
                }
                field("Expected Result"; Rec."Expected Result")
                {
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
                field("Actual Result"; Rec."Actual Result")
                {
                    ToolTip = 'Specifies the value of the Actual Result field.', Comment = '%';
                }
                field("Defect ID"; Rec."Defect ID")
                {
                    ToolTip = 'Specifies the value of the Defect ID/Link field.', Comment = '%';
                }
            }
        }
    }
}
