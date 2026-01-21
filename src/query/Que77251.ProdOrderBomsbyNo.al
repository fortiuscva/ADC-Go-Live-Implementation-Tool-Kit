query 77251 "ADC ProdOrder Boms by  No."
{
    Caption = 'ProdOrder Boms by No.';
    QueryType = Normal;
    OrderBy = ascending(ProdOrderNo);


    elements
    {
        dataitem(ADCProdOrderCompStage; "ADC Prod. Order Comp. Stage")
        {
            DataItemTableFilter = Processed = const(false);
            column(ProdOrderNo; "Prod. Order No.")
            {
            }
            column(Quantity_Per; "Quantity Per")
            {
                Method = sum;
            }


        }
    }

}
