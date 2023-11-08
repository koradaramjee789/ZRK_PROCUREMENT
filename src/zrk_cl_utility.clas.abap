CLASS zrk_cl_utility DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CL_UTILITY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*    SELECT * FROM zrk_demo_ord INTO TABLE @DATA(lt_ord).
*
*    MODIFY zrk_demo_ord FROM TABLE @lt_ord.

    UPDATE zrk_t_pur_con SET stat_code = 'RLSE' , version_no = 1  WHERE object_id = 'PC00000014'.

    COMMIT WORK.


  ENDMETHOD.
ENDCLASS.
