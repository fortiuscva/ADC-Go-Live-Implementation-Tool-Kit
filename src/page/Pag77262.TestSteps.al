page 77262 "ADC Test Steps"
{
    ApplicationArea = All;
    Caption = 'Test Steps';
    PageType = List;
    SourceTable = "ADC Test Step Header";
    CardPageId = "ADC Test Step";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Default Test Case No."; Rec."Default Test Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Test Case No. field.', Comment = '%';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Data Points"; Rec."Data Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Data Points/Test Data field.', Comment = '%';
                }
                field("Expected Result"; Rec."Expected Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part(TestSteps; "ADC Teststeps Factbox")
            {
                ApplicationArea = All;
                Caption = 'Steps';
                SubPageLink = "Document No." = field("No.");
            }
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
}
