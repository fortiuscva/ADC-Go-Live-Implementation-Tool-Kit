query 77250 "ADC BOM Components By Parent"
{
    Caption = 'BOM Components By Parent';
    QueryType = Normal;
    OrderBy = ascending(ParentItemNo);

    elements
    {
        dataitem(ADCBOMComponentStage; "ADC BOM Component Stage")
        {
            DataItemTableFilter = Processed = const(false);
            column(ParentItemNo; "Parent Item No.")
            {
            }
            column(QuantityPer; "Quantity Per")
            {
                Method = Sum;
            }
        }
    }
}
