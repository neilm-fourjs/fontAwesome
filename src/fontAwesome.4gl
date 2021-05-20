-- This program is for viewing the fontAwesome fonts.
-- By: Neil J Martin ( neilm@4js.com )

IMPORT os
IMPORT FGL g2_lib.*
IMPORT FGL fgldialog

CONSTANT C_PRGDESC = "FontAwesome Viewer"
CONSTANT C_PRGAUTH = "Neil J.Martin"
CONSTANT C_PRGVER = "3.2"
CONSTANT C_PRGICON = "logo_dark"

TYPE t_rec RECORD
  img STRING,
  nam STRING,
  font STRING,
  val STRING
END RECORD
TYPE t_s10 RECORD
  s01 STRING,
  s02 STRING,
  s03 STRING,
  s04 STRING,
  s05 STRING,
  s06 STRING,
  s07 STRING,
  s08 STRING,
  s09 STRING,
  s10 STRING
END RECORD
DEFINE m_rec DYNAMIC ARRAY OF t_rec
DEFINE m_imgs DYNAMIC ARRAY OF t_s10 	-- images
DEFINE m_icon DYNAMIC ARRAY OF t_s10  -- icon name
DEFINE m_fntn DYNAMIC ARRAY OF t_s10 	-- font name
DEFINE m_imgPath STRING
DEFINE m_img STRING
MAIN
  DEFINE l_ret SMALLINT
  DEFINE l_filter STRING

  CALL g2_core.m_appInfo.progInfo(C_PRGDESC, C_PRGAUTH, C_PRGVER, C_PRGICON)
  CALL g2_core.g2_init(base.Application.getArgument(1), "default")

  OPEN FORM f FROM "fontAwesome"
  DISPLAY FORM f
	LET m_imgPath = fgl_getenv("FGLIMAGEPATH")
  DISPLAY "FGLIMAGEPATH:" || m_imgPath TO fglimagepath
  IF NOT load_arr() THEN
		EXIT PROGRAM
	END IF

  DIALOG ATTRIBUTE(UNBUFFERED)
    INPUT BY NAME l_filter
      ON ACTION applyfilter ATTRIBUTES(ACCELERATOR = 'RETURN')
        CALL load_arr3(l_filter)
    END INPUT
    DISPLAY ARRAY m_imgs TO arr.* ATTRIBUTES(FOCUSONFIELD)
      BEFORE FIELD a01
        CALL disp_img(m_imgs[arr_curr()].s01, m_icon[arr_curr()].s01, m_fntn[arr_curr()].s01)
      BEFORE FIELD a02
        CALL disp_img(m_imgs[arr_curr()].s02, m_icon[arr_curr()].s02, m_fntn[arr_curr()].s02)
      BEFORE FIELD a03
        CALL disp_img(m_imgs[arr_curr()].s03, m_icon[arr_curr()].s03, m_fntn[arr_curr()].s03)
      BEFORE FIELD a04
        CALL disp_img(m_imgs[arr_curr()].s04, m_icon[arr_curr()].s04, m_fntn[arr_curr()].s04)
      BEFORE FIELD a05
        CALL disp_img(m_imgs[arr_curr()].s05, m_icon[arr_curr()].s05, m_fntn[arr_curr()].s05)
      BEFORE FIELD a06
        CALL disp_img(m_imgs[arr_curr()].s06, m_icon[arr_curr()].s06, m_fntn[arr_curr()].s06)
      BEFORE FIELD a07
        CALL disp_img(m_imgs[arr_curr()].s07, m_icon[arr_curr()].s07, m_fntn[arr_curr()].s07)
      BEFORE FIELD a08
        CALL disp_img(m_imgs[arr_curr()].s08, m_icon[arr_curr()].s08, m_fntn[arr_curr()].s08)
      BEFORE FIELD a09
        CALL disp_img(m_imgs[arr_curr()].s09, m_icon[arr_curr()].s09, m_fntn[arr_curr()].s09)
      BEFORE FIELD a10
        CALL disp_img(m_imgs[arr_curr()].s10, m_icon[arr_curr()].s10, m_fntn[arr_curr()].s10)

      BEFORE ROW
				CALL disp_row(DIALOG)

    END DISPLAY

		BEFORE DIALOG
			CALL disp_row(DIALOG)
      CALL disp_img(m_imgs[arr_curr()].s01, m_icon[arr_curr()].s01, m_fntn[arr_curr()].s01)

     ON ACTION copy
       CALL ui.Interface.frontCall("standard", "cbSet", m_img, l_ret)
    ON ACTION clearfilter
      LET l_filter = NULL
      CALL load_arr3(l_filter)
      NEXT FIELD l_filter
    ON ACTION about
      CALL g2_about.g2_about(g2_core.m_appInfo)
    ON ACTION quit
      EXIT DIALOG
    ON ACTION close
      EXIT DIALOG
  END DIALOG
END MAIN
--------------------------------------------------------------------------------
FUNCTION disp_img(l_nam STRING, l_id STRING, l_font STRING) RETURNS ()
  LET m_img = l_nam
  DISPLAY l_nam || " (" || l_id || ")" TO img_name
  DISPLAY l_font TO font_name
  DISPLAY l_nam TO img
  DISPLAY l_nam TO img2
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION disp_row(d ui.Dialog) RETURNS ()
	DEFINE x SMALLINT
	LET x = d.getCurrentRow("arr")
	DISPLAY d.getCurrentItem() TO img_name
	DISPLAY BY NAME m_imgs[x].s01
	DISPLAY BY NAME m_imgs[x].s02
	DISPLAY BY NAME m_imgs[x].s03
	DISPLAY BY NAME m_imgs[x].s04
	DISPLAY BY NAME m_imgs[x].s05
	DISPLAY BY NAME m_imgs[x].s06
	DISPLAY BY NAME m_imgs[x].s07
	DISPLAY BY NAME m_imgs[x].s08
	DISPLAY BY NAME m_imgs[x].s09
	DISPLAY BY NAME m_imgs[x].s10

	DISPLAY m_icon[x].s01 TO v01
	DISPLAY m_icon[x].s02 TO v02
	DISPLAY m_icon[x].s03 TO v03
	DISPLAY m_icon[x].s04 TO v04
	DISPLAY m_icon[x].s05 TO v05
	DISPLAY m_icon[x].s06 TO v06
	DISPLAY m_icon[x].s07 TO v07
	DISPLAY m_icon[x].s08 TO v08
	DISPLAY m_icon[x].s09 TO v09
	DISPLAY m_icon[x].s10 TO v10
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION load_arr() RETURNS BOOLEAN
  DEFINE l_file STRING
  DEFINE l_st base.StringTokenizer
  LET l_st = base.StringTokenizer.create(m_imgPath, os.Path.pathSeparator())
  WHILE l_st.hasMoreTokens()
    LET l_file = l_st.nextToken()
    IF l_file MATCHES "*.txt" THEN
      IF NOT load_arr2(l_file) THEN RETURN FALSE END IF
    END IF
  END WHILE
	RETURN TRUE
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION load_arr2(l_file) RETURNS BOOLEAN
  DEFINE l_file STRING
  DEFINE c base.Channel
  DEFINE l_rec RECORD
    fld1 STRING,
    fld2 STRING
  END RECORD
  DEFINE x SMALLINT
  DISPLAY "Adding:", l_file
  LET c = base.Channel.create()
	TRY
  	CALL c.openFile(l_file, "r")
	CATCH
		CALL fgldialog.fgl_winMessage("Error",SFMT("Failed to open %1", l_file),"exclamation")
		RETURN FALSE
	END TRY
  CALL c.setDelimiter("=")
  CALL m_rec.clear()
  WHILE NOT c.isEof()
    IF c.read([l_rec.*]) THEN
      IF l_rec.fld1.getCharAt(1) = "#" THEN
        CONTINUE WHILE
      END IF
      CALL m_rec.appendElement()
      LET m_rec[m_rec.getLength()].img = l_rec.fld1
      LET m_rec[m_rec.getLength()].nam = l_rec.fld1
      LET x = l_rec.fld2.getIndexOf(":", 1)
      LET m_rec[m_rec.getLength()].font = l_rec.fld2.subString(1, x - 1)
      LET m_rec[m_rec.getLength()].val = l_rec.fld2.subString(x + 1, l_rec.fld2.getLength())
      --	DISPLAY "file:",l_file," fld1:",l_rec.fld1," fld2:",l_rec.fld2
    END IF
  END WHILE
  CALL c.close()
  CALL load_arr3(NULL)
	RETURN TRUE
END FUNCTION
--------------------------------------------------------------------------------
-- Set the arrays for displaying
FUNCTION load_arr3(l_filter STRING) RETURNS ()
  DEFINE x, i SMALLINT
  DEFINE l_rec DYNAMIC ARRAY OF t_rec
  CALL m_imgs.clear()
  CALL m_icon.clear()
  CALL m_fntn.clear()
  CALL m_rec.copyTo(l_rec)
  IF l_filter IS NOT NULL THEN
    FOR x = l_rec.getLength() TO 1 STEP -1
      DISPLAY "Img:", l_rec[x].img
      IF NOT l_rec[x].img MATCHES l_filter THEN
        CALL l_rec.deleteElement(x)
      END IF
    END FOR
  END IF
  MESSAGE SFMT("Loading array using filter: %1", l_filter)
  FOR x = 1 TO l_rec.getLength() STEP 10
    CALL m_imgs.appendElement()
    CALL m_icon.appendElement()
    CALL m_fntn.appendElement()
		LET i = m_imgs.getLength()
    LET m_imgs[i].s01 = l_rec[x].img
    LET m_imgs[i].s02 = l_rec[x + 1].img
    LET m_imgs[i].s03 = l_rec[x + 2].img
    LET m_imgs[i].s04 = l_rec[x + 3].img
    LET m_imgs[i].s05 = l_rec[x + 4].img
    LET m_imgs[i].s06 = l_rec[x + 5].img
    LET m_imgs[i].s07 = l_rec[x + 6].img
    LET m_imgs[i].s08 = l_rec[x + 7].img
    LET m_imgs[i].s09 = l_rec[x + 8].img
    LET m_imgs[i].s10 = l_rec[x + 9].img
    LET m_icon[i].s01 = l_rec[x].val
    LET m_icon[i].s02 = l_rec[x + 1].val
    LET m_icon[i].s03 = l_rec[x + 2].val
    LET m_icon[i].s04 = l_rec[x + 3].val
    LET m_icon[i].s05 = l_rec[x + 4].val
    LET m_icon[i].s06 = l_rec[x + 5].val
    LET m_icon[i].s07 = l_rec[x + 6].val
    LET m_icon[i].s08 = l_rec[x + 7].val
    LET m_icon[i].s09 = l_rec[x + 8].val
    LET m_icon[i].s10 = l_rec[x + 9].val
    LET m_fntn[i].s01 = l_rec[x].font
    LET m_fntn[i].s02 = l_rec[x + 1].font
    LET m_fntn[i].s03 = l_rec[x + 2].font
    LET m_fntn[i].s04 = l_rec[x + 3].font
    LET m_fntn[i].s05 = l_rec[x + 4].font
    LET m_fntn[i].s06 = l_rec[x + 5].font
    LET m_fntn[i].s07 = l_rec[x + 6].font
    LET m_fntn[i].s08 = l_rec[x + 7].font
    LET m_fntn[i].s09 = l_rec[x + 8].font
    LET m_fntn[i].s10 = l_rec[x + 9].font
  END FOR
END FUNCTION
