@EndUserText.label: 'Projection CDS for attachments'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZRK_C_PUR_CON_ATT as projection on zrk_i_pur_con_att {
    key AttUuid,
    ConUuid,
    Attachment,
    Mimetype,
    Filename,   
        CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LoclLastChangedAt,
    /* Associations */
    _PurCon : redirected to parent ZRK_C_PUR_CON_UD
}
