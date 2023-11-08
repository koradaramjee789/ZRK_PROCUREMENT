CLASS zrk_cl_gen_md_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZRK_CL_GEN_MD_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA lt_send_via TYPE TABLE of zrk_md_send_via.

  lt_send_via = VALUE #( ( client = sy-mandt send_via = 'PRN' sent_via_text = 'Print' )
                           ( client = sy-mandt send_via = 'MAI' sent_via_text = 'Email' )
                           ( client = sy-mandt send_via = 'EDI' sent_via_text = 'Application' ) ).

  MODIFY zrk_md_send_via FROM TABLE @lt_send_via.


    DATA lt_sup TYPE TABLE OF zrk_md_supplier.

    lt_sup = VALUE #(   ( client = sy-mandt sup_no = 'S000000001' name = 'Max Walter')
                        ( client = sy-mandt sup_no = 'S000000002' name = 'Conrad Schulte')
                        ( client = sy-mandt sup_no = 'S000000003' name = 'Robert Schäfer')
                        ( client = sy-mandt sup_no = 'S000000004' name = 'Mathilde Graf')
                        ( client = sy-mandt sup_no = 'S000000005' name = 'Patrick Wagner')
                        ( client = sy-mandt sup_no = 'S000000006' name = 'Gabriele Fuchs')
                        ( client = sy-mandt sup_no = 'S000000007' name = 'Christine Hofmann')
                        ( client = sy-mandt sup_no = 'S000000008' name = 'Henri Kühn')
                        ( client = sy-mandt sup_no = 'S000000009' name = 'Oliver Thomas')
                        ( client = sy-mandt sup_no = 'S000000010' name = 'Manuel Klein')
     ).

    MODIFY zrk_md_supplier FROM TABLE @lt_sup.


    DATA : lt_sup_con TYPE TABLE OF zrk_md_sup_con.

    lt_sup_con = VALUE #(
                    ( client = sy-mandt sup_no = 'S000000001' sup_con_id = 'CP00000001' name = 'Lion Kühn' app_access = 'X' email_id = 'Lion@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000002' name = 'Niklas Böhm' app_access = ' ' email_id = 'Nikl@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000003' name = 'Wilma Dietrich' app_access = ' ' email_id = 'Wilm@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000003' sup_con_id = 'CP00000004' name = 'Noah Lorenz' app_access = 'X' email_id = 'Noah@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000004' sup_con_id = 'CP00000005' name = 'Erna Martin' app_access = ' ' email_id = 'Erna@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000003' sup_con_id = 'CP00000006' name = 'Rosa Scholz' app_access = 'X' email_id = 'Rosa@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000009' sup_con_id = 'CP00000007' name = 'Nadine Busch' app_access = ' ' email_id = 'Nadi@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000001' sup_con_id = 'CP00000008' name = 'Klaus Albrecht' app_access = ' ' email_id = 'Klau@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000009' name = 'Tilla Lorenz' app_access = 'X' email_id = 'Till@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000010' name = 'Amalie Köhler' app_access = ' ' email_id = '' )
                    ( client = sy-mandt sup_no = 'S000000003' sup_con_id = 'CP00000011' name = 'Stefan Neumann' app_access = 'X' email_id = 'Stef@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000004' sup_con_id = 'CP00000012' name = 'Elisabeth Martin' app_access = ' ' email_id = 'Elis@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000006' sup_con_id = 'CP00000013' name = 'Marius Schulte' app_access = ' ' email_id = 'Mari@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000004' sup_con_id = 'CP00000014' name = 'Julie Braun' app_access = 'X' email_id = 'Juli@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000001' sup_con_id = 'CP00000015' name = 'Lisa Schmitz' app_access = ' ' email_id = 'Lisa@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000016' name = 'Lina Frank' app_access = ' ' email_id = 'Lina@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000017' name = 'Margarete Lang' app_access = ' ' email_id = 'Marg@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000003' sup_con_id = 'CP00000018' name = 'Helma Schreiber' app_access = 'X' email_id = '' )
                    ( client = sy-mandt sup_no = 'S000000001' sup_con_id = 'CP00000019' name = 'Josefa Krüger' app_access = ' ' email_id = 'Jose@abhi@com' )
                    ( client = sy-mandt sup_no = 'S000000002' sup_con_id = 'CP00000020' name = 'Janis Winter' app_access = ' ' email_id = 'Jani@abhi@com' )
        ).

    MODIFY zrk_md_sup_con FROM TABLE @lt_sup_con.



    MODIFY zrk_md_buyer FROM TABLE @( VALUE #( ( client = sy-mandt buyer_id = 'BUY0000001' name = 'Gabriele Fuchs' email_id = 'Gabri@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000002' name = 'Sophie Lang' email_id = 'Sophi@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000003' name = 'Julius Berger' email_id = 'Juliu@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000004' name = 'Henrik Kühn' email_id = 'Henri@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000005' name = 'Charlotte Pfeiffer' email_id = 'Charl@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000006' name = 'Rosa Brandt' email_id = 'Rosa @raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000007' name = 'Beate Schmitz' email_id = 'Beate@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000008' name = 'Frank Berger' email_id = 'Frank@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000009' name = 'Frank Weiß' email_id = 'Frank@raja.com' )
                                               ( client = sy-mandt buyer_id = 'BUY0000010' name = 'Marvin Friedrich' email_id = 'Marvi@raja.com' )
                                                 ) ).


    MODIFY zrk_md_category FROM TABLE @( VALUE #( ( client = sy-mandt category_id = 'CC-005-21' description = 'Abrasives, Sandblasting, Metal' )
                                                ( client = sy-mandt category_id = 'CC-005-28' description = 'Abrasives, Sandblasting (other Than Metal)' )
                                                ( client = sy-mandt category_id = 'CC-005-42' description = 'Abrasives, Solid: Wheels, Stones, etc.' )
                                                ( client = sy-mandt category_id = 'CC-005-56' description = 'Abrasives, Tumbling (wheel)' )
                                                ( client = sy-mandt category_id = 'CC-010-70' description = 'Magnesia: Blocks, Sheets, etc.' )
                                                ( client = sy-mandt category_id = 'CC-010-72' description = 'Mineral Wool: Blankets, Blocks, Boards' )
                                                ( client = sy-mandt category_id = 'CC-010-75' description = 'Paints, Primers, Sealers, etc. (for Insulat' )
                                                ( client = sy-mandt category_id = 'CC-010-76' description = 'Paper Type Insulation Material (cellulose,' )
                                                ( client = sy-mandt category_id = 'CC-010-78' description = 'Pipe and Tubing Insulation, All Types' )
                                                ( client = sy-mandt category_id = 'CC-010-81' description = 'Preformed Insulation, All Types (for Ells,' )
                                                ( client = sy-mandt category_id = 'CC-020-02' description = 'Backhoe (for Farm Tractor)' )
                                                ( client = sy-mandt category_id = 'CC-020-04' description = 'Brush and Tree Chippers' )
                                                ( client = sy-mandt category_id = 'CC-020-06' description = 'Brush Cutters and Saws, Motor Driven' )
                                                ( client = sy-mandt category_id = 'CC-020-08' description = 'Components, Agricultural Equipment' )
                                                ( client = sy-mandt category_id = 'CC-020-10' description = 'Counters, Acre' )
                                                ( client = sy-mandt category_id = 'CC-020-13' description = 'Cultivating Equipment, Farm: Go-devils, Row' )
                                                ( client = sy-mandt category_id = 'CC-020-14' description = 'Curb Edger, Heavy Duty, Tractor Mounted' )
                                                ( client = sy-mandt category_id = 'CC-020-15' description = 'Cutters and Shredders (mowers), Heavy Duty,' )
                                                ( client = sy-mandt category_id = 'CC-020-16' description = 'Cutters and Shredders (mowers), Heavy Duty,' )
                                                ( client = sy-mandt category_id = 'CC-020-18' description = 'Dozer Blades (for Farm Tractors)' )
                                                ( client = sy-mandt category_id = 'CC-020-20' description = 'Drying Equipment, Grain' )
                                                 ) )               .


    MODIFY zrk_md_parts FROM TABLE @(  VALUE #( ( client = sy-mandt part_no = 'PT256545' category_id = 'CC-005-21' description = '10" Portable DVD player ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT267655' category_id = 'CC-005-28' description = '7" Widescreen Portable DVD Player w MP3 ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT278765' category_id = 'CC-005-42' description = 'Audio/Video Cable Kit - 4m ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT289875' category_id = 'CC-005-56' description = 'Beam Breaker B-1 ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT300985' category_id = 'CC-010-70' description = 'Blaster Extreme ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT312095' category_id = 'CC-010-72' description = 'CD/DVD case: 264 sleeves ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT323205' category_id = 'CC-010-75' description = 'Camcorder View ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT334315' category_id = 'CC-010-76' description = 'Comfort Easy ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT345425' category_id = 'CC-010-78' description = 'Comfort Senior ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT356535' category_id = 'CC-010-81' description = 'Copperberry ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT367645' category_id = 'CC-020-02' description = 'Copymaster ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT378755' category_id = 'CC-020-04' description = 'Cordless Bluetooth Keyboard, english international ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT156555' category_id = 'CC-020-06' description = 'Cordless Mouse ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT167665' category_id = 'CC-020-08' description = 'Designer Mousepad ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT178775' category_id = 'CC-005-21' description = 'Ergo Mousepad ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT189885' category_id = 'CC-005-28' description = 'Ergo Screen E-I ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT200995' category_id = 'CC-005-42' description = 'Ergonomic Keyboard ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT212105' category_id = 'CC-005-56' description = 'Fabric bag professional ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT223215' category_id = 'CC-010-70' description = 'Family PC Basic ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT234325' category_id = 'CC-005-21' description = 'Family PC Pro ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT245435' category_id = 'CC-005-28' description = 'Flat Basic ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT256545' category_id = 'CC-005-42' description = 'Flat Future ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT267655' category_id = 'CC-005-56' description = 'Flat Watch HD32 ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT278765' category_id = 'CC-010-70' description = 'Flat Watch HD37 ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT289875' category_id = 'CC-010-72' description = 'Flat Watch HD41 ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT300985' category_id = 'CC-010-75' description = 'Flat XL ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT312095' category_id = 'CC-010-76' description = 'Flat XXL ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT323205' category_id = 'CC-010-70' description = 'Gaming Monster ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT334315' category_id = 'CC-010-72' description = 'Gaming Monster Pro ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT345425' category_id = 'CC-005-42' description = 'Gladiator MX ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT356535' category_id = 'CC-005-56' description = 'Goldberry ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT367645' category_id = 'CC-010-70' description = 'Hurricane GX ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT378755' category_id = 'CC-005-35' description = 'Hurricane GX/LN ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT389865' category_id = 'CC-005-42' description = 'ITelO FlexTop I4000 ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT400975' category_id = 'CC-010-74' description = 'ITelO FlexTop I9800 ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT412085' category_id = 'CC-010-76' description = 'ITelO Vault ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT423195' category_id = 'CC-005-70' description = 'ITelO Vault Net ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT434305' category_id = 'CC-005-84' description = 'ITelO Vault SAT ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT445415' category_id = 'CC-010-71' description = 'ITelo Jog-Mate ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT456525' category_id = 'CC-010-70' description = 'ITelo MusicStick ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT467635' category_id = 'CC-010-72' description = 'Internet Keyboard ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT478745' category_id = 'CC-005-42' description = 'Jet Scan Professional ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT489855' category_id = 'CC-005-56' description = 'Jet Scan Professional ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT500965' category_id = 'CC-010-70' description = 'Laser Allround ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT512075' category_id = 'CC-005-35' description = 'Laser Basic ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT523185' category_id = 'CC-005-42' description = 'Laser Professional Eco ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT534295' category_id = 'CC-010-74' description = 'Lovely Sound 5.1 ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT545405' category_id = 'CC-010-76' description = 'Lovely Sound 5.1 Wireless ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT556515' category_id = 'CC-005-70' description = 'Lovely Sound Stereo ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT567625' category_id = 'CC-005-84' description = 'Maxi Tablet ' unit = 'M' )
                                                  ( client = sy-mandt part_no = 'PT578735' category_id = 'CC-010-71' description = 'Media Keyboard ' unit = 'EA' )
                                                  ( client = sy-mandt part_no = 'PT589845' category_id = 'CC-005-140' description = 'Mini Tablet ' unit = 'KG' )
                                                  ( client = sy-mandt part_no = 'PT600955' category_id = 'CC-010-73' description = 'Mousepad ' unit = 'TON' )
                                                  ( client = sy-mandt part_no = 'PT612065' category_id = 'CC-005-77' description = 'Multi Color ' unit = 'L' )
                                                  ( client = sy-mandt part_no = 'PT623175' category_id = 'CC-005-84' description = 'Multi Print ' unit = 'M' )
                                                     ) )      .

    MODIFY zrk_md_status FROM TABLE @( VALUE #( ( client = sy-mandt app = 'PUR_REQ' code = 'SAVED' status = 'Saved' )
                                                ( client = sy-mandt app = 'PUR_REQ' code = 'INPRG' status = 'In progess' )
                                                ( client = sy-mandt app = 'PUR_REQ' code = 'CMPLT' status = 'Completed' )
                                                ( client = sy-mandt app = 'PUR_ORD' code = 'SAVED' status = 'Saved' )
                                                ( client = sy-mandt app = 'PUR_ORD' code = 'AWAPR' status = 'Awaiting approval' )
                                                ( client = sy-mandt app = 'PUR_ORD' code = 'ORDRD' status = 'Ordered' )
                                                ( client = sy-mandt app = 'PUR_ORD' code = 'RJCTD' status = 'Rejected' )
                                                ( client = sy-mandt app = 'PUR_ORD' code = 'DLVRD' status = 'Delivered' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'SAVED' status = 'Saved' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'AWAPR' status = 'Awaiting approval' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'RLSED' status = 'Released' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'RJCTD' status = 'Rejected' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'CNFRM' status = 'Confirmed' )
                                                ( client = sy-mandt app = 'PUR_CON' code = 'RJSPL' status = 'Rejected by Supplier' )
                                                     ) )   .

    MODIFY zrk_md_plant FROM TABLE @( value #( ( client = sy-mandt plant_no ='0100' name = 'Berlin' )
                                                ( client = sy-mandt plant_no ='0200' name = 'Stuttgart' )
                                                ( client = sy-mandt plant_no ='0300' name = 'Frankfurt' )
                                                ( client = sy-mandt plant_no ='0400' name = 'Hamburg' )
                                                ( client = sy-mandt plant_no ='0500' name = 'Karshule' )
     ) ).



    DELETE FROM zrk_md_fisc_year.
    INSERT zrk_md_fisc_year FROM TABLE @( VALUE #( ( client = sy-mandt fisclyear = '2021' )
    ( client = sy-mandt fisclyear = '2022' )
    ( client = sy-mandt fisclyear = '2023' )
    ( client = sy-mandt fisclyear = '2024' )
    ( client = sy-mandt fisclyear = '2025' )
    ( client = sy-mandt fisclyear = '2026' )

    )  ).

    COMMIT WORK.

    out->write( 'Data is inserted' ).

  ENDMETHOD.
ENDCLASS.
