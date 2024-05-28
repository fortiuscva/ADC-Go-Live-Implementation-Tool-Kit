page 77251 "ADC Item Journal Lines Stating"
{
    ApplicationArea = All;
    Caption = 'Item Journal Lines Stating';
    PageType = List;
    SourceTable = "ADC Item Journal Line Stage";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(UOM; Rec.UOM)
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
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
            action(CreateJnlLines)
            {
                Caption = 'Process Lines';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will create item journals in the selected tempalte and batch';
                RunObject = report "ADC Create Journal Lines";
            }
            action(UnflagProcessedFlag)
            {
                Caption = 'Unflag Processed Lines';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ToolTip = 'This action will unflag processed flag value on Staging Journal Lines';
                trigger OnAction()

                begin
                    if not Confirm(UnProcessedConfirmFlagMsg, false) then
                        Error(ProcessInterruptedMsg);

                    ADCItemJnlLineStagingRecGbl.RESET;
                    ADCItemJnlLineStagingRecGbl.ModifyAll(Processed, false);
                    ADCItemJnlLineStagingRecGbl.ModifyAll("Error Text", '');
                end;

            }

        }

    }
    var
        UnProcessedConfirmFlagMsg: Label 'Do you want to unflag all processed lines?';
        ProcessInterruptedMsg: Label 'Processed Interrupted to respect the Warning';
        ADCItemJnlLineStagingRecGbl: Record "ADC Item Journal Line Stage";
}
