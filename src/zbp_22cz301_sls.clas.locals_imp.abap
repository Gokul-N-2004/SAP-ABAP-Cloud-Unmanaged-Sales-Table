CLASS lsc_z22cz301_i_sls DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
    METHODS cleanup           REDEFINITION.
    METHODS cleanup_finalize  REDEFINITION.

ENDCLASS.



CLASS lsc_z22cz301_i_sls IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.


  METHOD check_before_save.
  ENDMETHOD.


  METHOD save.

    DATA(lo_util) = ZCL_22CZ301_SALES_UTIL=>get_instance( ).

    lo_util->get_hdr_value(
      IMPORTING
        ex_sales_hdr = DATA(ls_sales_hdr)
    ).

    lo_util->get_itm_value(
      IMPORTING
        ex_sales_itm = DATA(ls_sales_itm)
    ).

    lo_util->get_hdr_t_deletion(
      IMPORTING
        ex_sales_docs = DATA(lt_sales_header)
    ).

    lo_util->get_itm_t_deletion(
      IMPORTING
        ex_sales_info = DATA(lt_sales_items)
    ).

    lo_util->get_deletion_flags(
      IMPORTING
        ex_so_hdr_del = DATA(lv_so_hdr_del)
    ).

* Update Header
    IF ls_sales_hdr IS NOT INITIAL.
      MODIFY z22cz301_vbak FROM @ls_sales_hdr.
    ENDIF.

* Update Items
    IF ls_sales_itm IS NOT INITIAL.
      MODIFY z22cz301_vbap FROM @ls_sales_itm.
    ENDIF.

* Deletion Logic
    IF lv_so_hdr_del = abap_true.

      LOOP AT lt_sales_header INTO DATA(ls_del_hdr).

        DELETE FROM z22cz301_vbak
          WHERE salesdocument = @ls_del_hdr-salesdocument.

        DELETE FROM z22cz301_vbap
          WHERE salesdocument = @ls_del_hdr-salesdocument.

      ENDLOOP.

    ELSE.

      LOOP AT lt_sales_header INTO ls_del_hdr.

        DELETE FROM z22cz301_vbak
          WHERE salesdocument = @ls_del_hdr-salesdocument.

      ENDLOOP.

      LOOP AT lt_sales_items INTO DATA(ls_del_itm).

        DELETE FROM z22cz301_vbap
          WHERE salesdocument   = @ls_del_itm-salesdocument
            AND salesitemnumber = @ls_del_itm-salesitemnumber.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.



  METHOD cleanup.
    ZCL_22CZ301_SALES_UTIL=>get_instance( )->cleanup_buffer( ).
  ENDMETHOD.


  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
