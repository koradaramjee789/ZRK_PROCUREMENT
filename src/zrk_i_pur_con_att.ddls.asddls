@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contract attachments'
@Metadata.ignorePropagatedAnnotations: true


define view entity zrk_i_pur_con_att
  as select from zrk_lb_att
  association to parent ZRK_I_PUR_CON_UD as _PurCon on $projection.ConUuid = _PurCon.ConUuid
{
  key att_uuid             as AttUuid,
      obj_uuid             as ConUuid,
      @Semantics.largeObject: {
          mimeType: 'Mimetype',
          fileName: 'Filename',
         // acceptableMimeTypes: [''],
          contentDispositionPreference: #INLINE
      }
      attachment           as Attachment,
      @Semantics.mimeType: true
      mimetype             as Mimetype,
      filename             as Filename,
      @Semantics.user.createdBy: true
      created_by           as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at           as CreatedAt,
      @Semantics.user.lastChangedBy
      last_changed_by      as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at      as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locl_last_changed_at as LoclLastChangedAt,
      _PurCon
}
