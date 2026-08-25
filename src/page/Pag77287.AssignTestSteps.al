page 77287 "ADC Assign Test Steps"
{
    ApplicationArea = All;
    Caption = 'Assign Test Steps to the Selected Users';
    PageType = Worksheet;
    SourceTable = "ADC Test Step User Selection";
    // SaveValues = true;
    SourceTableTemporary = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
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
                        SetTestStepID(TestStepHeader."No.");
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
            field(TargetCompletionDate; TargetCompletionDate)
            {
                ApplicationArea = All;
                Caption = 'Target Completion Date';
                ToolTip = 'Specifies the target completion date that will be assigned on the test case lines';
            }
            field(UserGroup; UserGroupFilter)
            {
                ApplicationArea = All;
                Caption = 'User Group Filter';
                Lookup = true;
                ToolTip = 'Specifies the User Group Filter based on which the users will be selected';
                trigger OnLookup(var Text: Text): Boolean
                var
                    UserGroup: Record "ADC User Group";
                    UserGroups: Page "ADC User Groups";
                begin
                    CurrPage.SaveRecord();
                    Clear(UserGroup);

                    UserGroups.LookupMode(true);
                    UserGroups.SetTableView(UserGroup);

                    if UserGroups.RunModal() = Action::LookupOK then begin
                        UserGroups.GetRecord(UserGroup);
                        SetUserGroup(UserGroup.Code);
                        CurrPage.Update(false);
                    end;
                end;

                trigger OnValidate()
                var
                    ADCUserSetup: Query "ADC User Setup";
                begin
                    Rec.Reset();
                    Rec.DeleteAll();

                    ADCUserSetup.SetRange(UserGroup, UserGroupFilter);
                    ADCUserSetup.Open();
                    while ADCUserSetup.Read() do begin
                        Rec.Init();
                        Rec."User ID" := ADCUserSetup.UserID;
                        Rec."User Group" := ADCUserSetup.UserGroup;
                        Rec.Select := false;
                        Rec.Insert();
                    end;

                    Rec.Reset();
                    if Rec.FindFirst() then;
                end;
            }
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("User Group"; Rec."User Group")
                {
                    ToolTip = 'Specifies the value of the User Group field.', Comment = '%';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.', Comment = '%';
                    trigger OnValidate()
                    var
                        UserGroupFilterErr: Label 'User %1 does not belong to the filtered user group %2';
                    begin
                        if ((UserGroupFilter <> '') and (Rec."User Group" <> UserGroupFilter)) then
                            Error(StrSubstNo(UserGroupFilterErr, Rec."User ID", UserGroupFilter));
                    end;
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
        UserGroupFilter: Code[50];
        SelectionConfirmed: Boolean;
        TargetCompletionDate: Date;

    local procedure SetTestStepID(NewTestStepID: Code[20])
    begin
        TestStepID := NewTestStepID;
    end;

    procedure GetTestStepID(): Code[20]
    begin
        exit(TestStepID);
    end;

    local procedure SetUserGroup(NewUserGroup: Code[50])
    begin
        UserGroupFilter := NewUserGroup;
    end;

    local procedure GetUserGroup(): Code[50]
    begin
        exit(UserGroupFilter);
    end;

    procedure GetTargetCompletionDate(): Date
    begin
        exit(TargetCompletionDate);
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
        ADCUserSetup: Query "ADC User Setup";
    begin
        Rec.Reset();
        Rec.DeleteAll();

        ADCUserSetup.Open();
        while ADCUserSetup.Read() do begin
            Rec.Init();
            Rec."User ID" := ADCUserSetup.UserID;
            Rec."User Group" := ADCUserSetup.UserGroup;
            Rec.Select := false;
            Rec.Insert();
        end;

        Rec.Reset();
        if Rec.FindFirst() then;
    end;

    local procedure SetSelectionValue(NewValue: Boolean)
    begin
        Rec.Reset();
        if UserGroupFilter <> '' then
            Rec.SetRange("User Group", UserGroupFilter);
        if Rec.FindSet(true) then
            repeat
                Rec.Select := NewValue;
                Rec.Modify();
            until Rec.Next() = 0;

        Rec.Reset();
        if Rec.FindFirst() then;
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
