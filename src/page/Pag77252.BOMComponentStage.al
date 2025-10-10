page 77252 "ADC BOM Component Stage"
{
    ApplicationArea = All;
    Caption = 'BOM Component Stage';
    PageType = List;
    SourceTable = "ADC BOM Component Stage";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Parent Item No."; Rec."Parent Item No.")
                {
                    ToolTip = 'Specifies the value of the Parent Item No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Quantity Per"; Rec."Quantity Per")
                {
                    ToolTip = 'Specifies the value of the Quantity Per field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Installed in Item No."; Rec."Installed in Item No.")
                {
                    ToolTip = 'Specifies the value of the Installed in Item No. field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
                field("Error Text"; Rec."Error Text")
                {
                    ToolTip = 'Specifies the value of the Error Text field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateBOMComponents)
            {
                Caption = 'Process BOM Components';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will create Assembly BOM';
                RunObject = report "ADC Create BOM Components";
            }
            action(UnflagProcessedFlag)
            {
                Caption = 'Unflag Processed Lines';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will unflag processed flag value on Staging Assembly BOM Lines';
                trigger OnAction()

                begin
                    if not Confirm(UnProcessedConfirmFlagMsg, false) then
                        Error(ProcessInterruptedMsg);

                    ADCBOMComponentStagingRecGbl.RESET;
                    ADCBOMComponentStagingRecGbl.ModifyAll(Processed, false);
                    ADCBOMComponentStagingRecGbl.ModifyAll("Error Text", '');
                end;

            }

        }

    }
    var
        UnProcessedConfirmFlagMsg: Label 'Do you want to unflag all processed lines?';
        ProcessInterruptedMsg: Label 'Processed Interrupted to respect the Warning';
        ADCBOMComponentStagingRecGbl: Record "ADC BOM Component Stage";
}
