@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item - 22cz301'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity Z22CZ301_I_SLSITM
  as select from z22cz301_vbap

  association to parent Z22CZ301_I_SLS as _SalesHeader
    on $projection.Salesdocument = _SalesHeader.SalesDocument

{
    key salesdocument        as Salesdocument,
    key salesitemnumber      as SalesItemNumber,

    material                 as Material,
    plant                    as Plant,

    @Semantics.quantity.unitOfMeasure: 'QuantityUnits'
    quantity                 as Quantity,
    quantityunits            as QuantityUnits,

    local_created_by         as LocalCreatedBy,
    local_created_at         as LocalCreatedAt,
    local_last_changed_by    as LocalLastChangedBy,
    local_last_changed_at    as LocalLastChangedAt,
    last_changed_at          as LastChangedAt,

    _SalesHeader
}
