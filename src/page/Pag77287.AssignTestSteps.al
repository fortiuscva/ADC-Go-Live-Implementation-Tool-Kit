page 77287 "ADC Assign Test Steps"
{
    ApplicationArea = All;
    Caption = 'Assign Test Steps';
    PageType = Worksheet;
    SourceTable = "ADC Test Step User Selection";
    // SaveValues = true;
    SourceTableTemporary = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(TestStepID; TestStepID)
                {
                    ApplicationArea = All;
                    Caption = 'Test Step ID';
                    Lookup = true;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the Test Step that will be assigned to the selected users.';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        TestStepHeader: Record "ADC Test Step Header";
                        TestSteps: Page "ADC Test Steps";
                    begin
                        CurrPage.SaveRecord();
                        Clear(TestSteps);

                        TestSteps.LookupMode(true);
                        TestSteps.SetTableView(TestStepHeader);

                        if TestSteps.RunModal() = Action::LookupOK then begin
                            TestSteps.GetRecord(TestStepHeader);
                            TestStepID := TestStepHeader."No.";
                            CurrPage.Update(false);
                        end;
                    end;

                    trigger OnValidate()
                    var
                        TestStepHeader: Record "ADC Test Step Header";
                    begin
                        if TestStepID <> '' then
                            TestStepHeader.Get(TestStepID);
                    end;
                }
            }

            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(SelectAll)
            {
                ApplicationArea = All;
                Caption = 'Select All';
                Image = SelectEntries;
                Ellipsis = true;
                ToolTip = 'Select all users.';
                trigger OnAction()
                begin
                    SetSelectionValue(true);
                end;
            }
            action(ClearAll)
            {
                ApplicationArea = All;
                Caption = 'Clear All';
                Image = ClearFilter;
                Ellipsis = true;
                ToolTip = 'Clears the selection for all users.';
                trigger OnAction()
                begin
                    SetSelectionValue(false);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(SelectAllPromoted; SelectAll)
                {
                }
                actionref(ClearAllPromoted; ClearAll)
                {
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        LoadUsers();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [Action::OK, Action::LookupOK] then begin
            ValidateSelection();
            SelectionConfirmed := true;
        end;
    end;


    var
        TestStepID: Code[20];
        SelectionConfirmed: Boolean;

    procedure SetTestStepID(NewTestStepID: Code[20])
    begin
        TestStepID := NewTestStepID;
    end;

    procedure GetTestStepID(): Code[20]
    begin
        exit(TestStepID);
    end;

    procedure WasSelectionConfirmed(): Boolean
    begin
        exit(SelectionConfirmed);
    end;

    procedure GetSelectedUsers(var TempSelectedUsers: Record "ADC Test Step User Selection" temporary)
    begin
        TempSelectedUsers.Reset();
        TempSelectedUsers.DeleteAll();

        Rec.Reset();
        Rec.SetRange(Select, true);

        if Rec.FindSet() then begin
            repeat
                TempSelectedUsers := Rec;
                TempSelectedUsers.Insert();
            until Rec.Next() = 0;
        end;
    end;

    local procedure LoadUsers()
    var
        ADCUserSetup: Record "ADC User Setup";
    begin
        Rec.Reset();
        Rec.DeleteAll();

        ADCUserSetup.Reset();
        if ADCUserSetup.FindSet() then begin
            repeat
                Rec.Init();
                Rec."User ID" := ADCUserSetup."User ID";
                Rec.Select := false;
                Rec.Insert();
            until ADCUserSetup.Next() = 0;
        end;

        Rec.Reset();
        if Rec.FindFirst() then;
    end;

    local procedure SetSelectionValue(NewValue: Boolean)
    begin
        Rec.Reset();

        if Rec.FindSet(true) then
            repeat
                Rec.Select := NewValue;
                Rec.Modify();
            until Rec.Next() = 0;

        Rec.Reset();
        CurrPage.Update(false);
    end;

    local procedure ValidateSelection()
    var
        TestStepHeader: Record "ADC Test Step Header";
        NoTestStepIdErr: Label 'Test Step ID must have a value.';
        NoUserSelectedErr: Label 'At least one or more users must be selected.';
    begin
        if TestStepID = '' then
            Error(NoTestStepIdErr);

        TestStepHeader.Get(TestStepID);

        Rec.Reset();
        Rec.SetRange(Select, true);

        if Rec.IsEmpty() then
            Error(NoUserSelectedErr);

        Rec.Reset();
    end;
}
