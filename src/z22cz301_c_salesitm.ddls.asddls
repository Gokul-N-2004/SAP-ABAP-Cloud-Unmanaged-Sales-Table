@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Items Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity Z22CZ301_C_SALESITM
  as projection on Z22CZ301_I_SLSITM
{
    key Salesdocument,
    key SalesItemNumber,

    @Search.defaultSearchElement: true
    Material,
    Plant,

    @Semantics.quantity.unitOfMeasure: 'Quantityunits'
    Quantity,
    QuantityUnits,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,

    _SalesHeader : redirected to parent Z22CZ301_C_SALESHD
}

