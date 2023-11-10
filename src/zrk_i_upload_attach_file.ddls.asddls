@EndUserText.label: 'Abstract entity for file attachment'
define abstract entity zrk_i_upload_attach_file

{

      @UI.hidden : true
  key id         : abap.char(1);
      @Semantics.largeObject:
      { mimeType : 'MimeType',
        fileName : 'Filename',
        contentDispositionPreference: #INLINE }
      attachment : /dmo/attachment;
      @UI.hidden : true
      @Semantics.mimeType: true
      mimetype   : /dmo/mime_type;
      @UI.hidden : true
      filename   : /dmo/filename;
//      @UI.hidden : true
//      _to_parent : association to parent zrk_i_upload_attachment on _to_parent.id = $projection.id;

}
