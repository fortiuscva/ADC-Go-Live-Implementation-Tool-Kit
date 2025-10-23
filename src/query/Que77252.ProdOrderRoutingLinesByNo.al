query 77252 "ADC ProdOrderRoutingLinesByNo."
{
    Caption = 'ProdOrderRoutingLinesByNo.';
    QueryType = Normal;
    OrderBy = ascending(ProdOrderNo);
    elements
    {
        dataitem(ProdOrderRoutingLineStage; "Prod. Order Routing Line Stage")
        {
            DataItemTableFilter = Processed = const(false);
            column(ProdOrderNo; "Prod. Order No.")
            {
            }
        }
    }
}
