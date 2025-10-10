xmlport 77252 "ADC Imp. BOMComponents Stage"
{
    Caption = 'Import Assembly BOM Components - Staging';
    Direction = Import;
    FormatEvaluate = Legacy;
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(root)
        {
            tableelement(Integer; "Integer")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                textelement(ParentItemNoGbl) { }
                //textelement(LineNoGbl) { }
                textelement(TypeGbl) { }
                textelement(NoGbl) { }
                textelement(DescriptionGbl) { }
                textelement(QuantityPerGbl) { }
                textelement(UnitOfMeasureCodeGbl) { }
                textelement(InstalledInItemNoGbl) { }
                trigger OnAfterInitRecord()
                begin
                    ParentItemNoGbl := '';
                    //LineNoGbl := '';
                    TypeGbl := '';
                    DescriptionGbl := '';
                    QuantityPerGbl := '';
                    UnitofMeasureCodeGbl := '';
                    InstalledInItemNoGbl := '';
                end;

                trigger OnBeforeInsertRecord()
                begin
                    // BOMComponentStagingRecGbl.Reset();
                    // BOMComponentStagingRecGbl.SetRange("Parent Item No.", ParentItemNoGbl);
                    // if BOMComponentStagingRecGbl.FindLast() then
                    //     NextLineNoGbl := BOMComponentStagingRecGbl."Line No." + 10000
                    // else
                    //     NextLineNoGbl := 10000;
                    Evaluate(LineType, TypeGbl);
                    Evaluate(QuantityGbl, QuantityPerGbl);

                    BOMComponentStagingRecGbl.Init();
                    BOMComponentStagingRecGbl."Entry No." := EntryNo;
                    BOMComponentStagingRecGbl.Validate("Parent Item No.", ParentItemNoGbl);
                    //BOMComponentStagingRecGbl."Line No." := NextLineNoGbl;
                    BOMComponentStagingRecGbl.Validate(Type, LineType);
                    BOMComponentStagingRecGbl.Validate("No.", NoGbl);
                    BOMComponentStagingRecGbl.Validate(Description, DescriptionGbl);
                    BOMComponentStagingRecGbl.Validate("Quantity per", QuantityGbl);
                    BOMComponentStagingRecGbl.Validate("Unit of Measure Code", UnitOfMeasureCodeGbl);
                    BOMComponentStagingRecGbl.Validate("Installed in Item No.", InstalledInItemNoGbl);
                    BOMComponentStagingRecGbl.Insert();
                    EntryNo += 1;
                end;

            }
        }
    }
    trigger OnPreXmlPort()

    begin
        EntryNo := 1;
        BOMComponentStagingRecGbl.Reset();
        if BOMComponentStagingRecGbl.FindFirst() then
            if not Confirm(LinesExistsMsgLbl) then
                error('Process interrupted to respect the Warning');

    end;



    var
        BOMComponentStagingRecGbl: Record "ADC BOM Component Stage";
        NextLineNoGbl: Integer;
        EntryNo: Integer;
        QuantityGbl: Decimal;
        LineType: Enum "BOM Component Type";
        LinesExistsMsgLbl: Label 'There are lines in staging table and existing lines will be deleted to import the new file. Do you want to proceed?';

}
