CLASS zrk_cl_test_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CL_TEST_OBJECTS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


      READ ENTITIES OF zrk_i_pur_con_ud
      ENTITY PurCon
      FROM VALUE #( ( %control-Buyer = 'BUY0000001' ) )
      RESULT DATA(lt_con).

  ENDMETHOD.
ENDCLASS.
