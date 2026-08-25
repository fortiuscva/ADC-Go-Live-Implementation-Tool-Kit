codeunit 77258 "ADC Go Live Functions"
{
    procedure CreateTaskForTestCaseLine(TestCaseLine: Record "ADC Test Case Line"; RunPage: Boolean)
    var
        TaskLcl: Record "ADC Task";
        ADCUserSetup: Record "ADC User Setup";
    begin
        //GoLiveImplSetup.Get();
        //GoLiveImplSetup.TestField("Task Nos.");
        TaskLcl.Init();
        TaskLcl."No." := '';
        TaskLcl.Insert(true);
        if ADCUserSetup.Get(UserId) then
            TaskLcl."Assigned By" := ADCUserSetup."User ID";
        TaskLcl."Assigned Date" := Today;
        TaskLcl."Test Case No." := TestCaseLine."Document No.";
        TaskLcl."Test Case Line No." := TestCaseLine."Line No.";
        TaskLcl.Modify(true);
        if RunPage then
            Page.Run(Page::"ADC Task", TaskLcl);
    end;

    var
        GoLiveImplSetup: Record "ADC Go Live Impl. Setup";
}
