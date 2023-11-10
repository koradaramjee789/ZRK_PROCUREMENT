@EndUserText.label: 'Abstract entity to upload attachment'
define root abstract entity zrk_i_upload_attachment
{
      @UI.hidden: true
  key id      : abap.char(1);
      preview : abap_boolean;

//      _assoc  : composition [1..1] of zrk_i_upload_attach_file;
      
}
