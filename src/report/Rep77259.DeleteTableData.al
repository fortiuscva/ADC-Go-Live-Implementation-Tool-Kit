report 77259 "ADC Delete Table Data"
{
    Caption = 'Delete Table Data';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = None;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(TableID; TableID)
                    {
                        Caption = 'Table ID';
                        TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));


                        ApplicationArea = All;
                    }

                    field(CompanyNameGbl; CompanyNameGbl)
                    {
                        Caption = 'Company Name (Optional)';
                        ApplicationArea = All;
                        TableRelation = Company;
                    }
                    field(RunForAllCompanies; RunForAllCompanies)
                    {
                        Caption = 'Run For All Companies';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        RecRef: RecordRef;
        RecordCount: Integer;
    begin
        if TableID = 0 then
            Error('Table ID is required.');

        if not RunForAllCompanies then
            if CompanyNameGbl = '' then
                Error('Company Name is required.');

        RecRef.Open(TableID);

        if CompanyNameGbl <> '' then
            RecRef.ChangeCompany(CompanyNameGbl);

        RecordCount := RecRef.Count;

        if RecordCount = 0 then begin
            Message('No records found.');
            exit;
        end;

        if not Confirm(
            StrSubstNo(
                'Delete %1 records from table %2?',
                RecordCount,
                TableID),
            false)
        then
            exit;

        RecRef.DeleteAll(true);

        Message('%1 records deleted.', RecordCount);
    end;

    var
        TableID: Integer;
        CompanyNameGbl: Text[100];
        RunForAllCompanies: Boolean;
}
