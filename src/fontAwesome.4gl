
IMPORT os
IMPORT FGL gl_lib
IMPORT FGL gl_about
&include "genero_lib.inc"
CONSTANT C_VER="3.1"
CONSTANT PRGDESC = "Font Awesome Reference"
CONSTANT PRGAUTH = "Neil J.Martin"

TYPE t_rec RECORD
		img STRING,
		nam STRING,
		font STRING,
		val STRING
	END RECORD
DEFINE m_rec DYNAMIC ARRAY OF t_rec
DEFINE m_rec2 DYNAMIC ARRAY OF RECORD
	i01 STRING,
	i02 STRING,
	i03 STRING,
	i04 STRING,
	i05 STRING,
	i06 STRING,
	i07 STRING,
	i08 STRING,
	i09 STRING,
	i10 STRING
END RECORD
DEFINE m_rec3 DYNAMIC ARRAY OF RECORD
	v01 STRING,
	v02 STRING,
	v03 STRING,
	v04 STRING,
	v05 STRING,
	v06 STRING,
	v07 STRING,
	v08 STRING,
	v09 STRING,
	v10 STRING
	END RECORD
DEFINE m_rec4 DYNAMIC ARRAY OF RECORD
	f01 STRING,
	f02 STRING,
	f03 STRING,
	f04 STRING,
	f05 STRING,
	f06 STRING,
	f07 STRING,
	f08 STRING,
	f09 STRING,
	f10 STRING
	END RECORD

	DEFINE m_img STRING
MAIN
	DEFINE l_ret SMALLINT
	CALL gl_lib.gl_setInfo(C_VER, NULL, NULL, NULL, PRGDESC, PRGAUTH)
	CALL gl_lib.gl_init( ARG_VAL(1) ,NULL,TRUE)
	CALL ui.Interface.setText( gl_progdesc )

	OPEN FORM f FROM "fontAwesome"
	DISPLAY FORM f

	DISPLAY "FGLIMAGEPATH:"||fgl_getEnv("FGLIMAGEPATH") TO fglimagepath
	CALL load_arr()

	DIALOG
		DISPLAY ARRAY m_rec2 TO arr.* ATTRIBUTES(FOCUSONFIELD)
			ON ACTION copy CALL ui.Interface.frontCall("standard","cbSet",m_img, l_ret)

			BEFORE FIELD a01
				CALL dsp_img( m_rec2[ arr_curr() ].i01, m_rec3[ arr_curr() ].v01, m_rec4[ arr_curr() ].f01 )
			BEFORE FIELD a02
				CALL dsp_img( m_rec2[ arr_curr() ].i02, m_rec3[ arr_curr() ].v02, m_rec4[ arr_curr() ].f02 )
			BEFORE FIELD a03
				CALL dsp_img( m_rec2[ arr_curr() ].i03, m_rec3[ arr_curr() ].v03, m_rec4[ arr_curr() ].f03 )
			BEFORE FIELD a04
				CALL dsp_img( m_rec2[ arr_curr() ].i04, m_rec3[ arr_curr() ].v04, m_rec4[ arr_curr() ].f04 )
			BEFORE FIELD a05
				CALL dsp_img( m_rec2[ arr_curr() ].i05, m_rec3[ arr_curr() ].v05, m_rec4[ arr_curr() ].f05 )
			BEFORE FIELD a06
				CALL dsp_img( m_rec2[ arr_curr() ].i06, m_rec3[ arr_curr() ].v06, m_rec4[ arr_curr() ].f06 )
			BEFORE FIELD a07
				CALL dsp_img( m_rec2[ arr_curr() ].i07, m_rec3[ arr_curr() ].v07, m_rec4[ arr_curr() ].f07 )
			BEFORE FIELD a08
				CALL dsp_img( m_rec2[ arr_curr() ].i08, m_rec3[ arr_curr() ].v08, m_rec4[ arr_curr() ].f08 )
			BEFORE FIELD a09
				CALL dsp_img( m_rec2[ arr_curr() ].i09, m_rec3[ arr_curr() ].v09, m_rec4[ arr_curr() ].f09 )
			BEFORE FIELD a10
				CALL dsp_img( m_rec2[ arr_curr() ].i10, m_rec3[ arr_curr() ].v10, m_rec4[ arr_curr() ].f10 )

			BEFORE ROW
				DISPLAY DIALOG.getCurrentItem() TO img_name
				DISPLAY BY NAME m_rec2[ arr_curr() ].i01
				DISPLAY BY NAME m_rec2[ arr_curr() ].i02
				DISPLAY BY NAME m_rec2[ arr_curr() ].i03
				DISPLAY BY NAME m_rec2[ arr_curr() ].i04
				DISPLAY BY NAME m_rec2[ arr_curr() ].i05
				DISPLAY BY NAME m_rec2[ arr_curr() ].i06
				DISPLAY BY NAME m_rec2[ arr_curr() ].i07
				DISPLAY BY NAME m_rec2[ arr_curr() ].i08
				DISPLAY BY NAME m_rec2[ arr_curr() ].i09
				DISPLAY BY NAME m_rec2[ arr_curr() ].i10

				DISPLAY BY NAME m_rec3[ arr_curr() ].v01
				DISPLAY BY NAME m_rec3[ arr_curr() ].v02
				DISPLAY BY NAME m_rec3[ arr_curr() ].v03
				DISPLAY BY NAME m_rec3[ arr_curr() ].v04
				DISPLAY BY NAME m_rec3[ arr_curr() ].v05
				DISPLAY BY NAME m_rec3[ arr_curr() ].v06
				DISPLAY BY NAME m_rec3[ arr_curr() ].v07
				DISPLAY BY NAME m_rec3[ arr_curr() ].v08
				DISPLAY BY NAME m_rec3[ arr_curr() ].v09
				DISPLAY BY NAME m_rec3[ arr_curr() ].v10

		END DISPLAY
		GL_ABOUT
		ON ACTION quit EXIT DIALOG
		ON ACTION close EXIT DIALOG
	END DIALOG
END MAIN
--------------------------------------------------------------------------------
FUNCTION dsp_img( l_nam STRING, l_id STRING,  l_font STRING)
	LET m_img = l_nam
	DISPLAY l_nam||" ("||l_id||")" TO img_name
	DISPLAY l_font TO font_name
	DISPLAY l_nam TO img
	DISPLAY l_nam TO img2
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION load_arr()
	DEFINE l_file STRING
	DEFINE l_st base.StringTokenizer
	LET l_st = base.StringTokenizer.create( fgl_getEnv("FGLIMAGEPATH"), os.path.pathSeparator() )
	WHILE l_st.hasMoreTokens()
		LET l_file = l_st.nextToken()
		IF l_file MATCHES "*.txt" THEN
			CALL load_arr2( l_file )
		END IF
	END WHILE
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION load_arr2(l_file)
	DEFINE l_file STRING
	DEFINE c base.channel
	DEFINE l_rec RECORD 
		fld1 STRING,
		fld2 STRING
		END RECORD
	DEFINE x SMALLINT
	DISPLAY "Adding:",l_file
	LET c = base.channel.create()
--	CALL c.openFile( fgl_getEnv("FGLDIR")||"/lib/image2font.txt","r")
	CALL c.openFile( l_file, "r")
	CALL c.setDelimiter("=")
	CALL m_rec.clear()
	WHILE NOT c.isEOF()
		IF c.read( [ l_rec.* ] ) THEN
			IF l_rec.fld1.getCharAt(1) = "#" THEN CONTINUE WHILE END IF
			CALL m_rec.appendElement()
			LET m_rec[ m_rec.getLength() ].img = l_rec.fld1
			LET m_rec[ m_rec.getLength() ].nam = l_rec.fld1
			LET x = l_rec.fld2.getIndexOf(":",1)
			LET m_rec[ m_rec.getLength() ].font= l_rec.fld2.subString(1,x-1)
			LET m_rec[ m_rec.getLength() ].val = l_rec.fld2.subString(x+1, l_rec.fld2.getLength())
		--	DISPLAY "file:",l_file," fld1:",l_rec.fld1," fld2:",l_rec.fld2
		END IF
	END WHILE
	FOR x = 1 TO m_rec.getLength() STEP 10
		CALL m_rec2.appendElement()
		CALL m_rec3.appendElement()
		CALL m_rec4.appendElement()
		LET m_rec2[ m_rec2.getLength() ].i01 = m_rec[x].img
		LET m_rec2[ m_rec2.getLength() ].i02 = m_rec[x+1].img
		LET m_rec2[ m_rec2.getLength() ].i03 = m_rec[x+2].img
		LET m_rec2[ m_rec2.getLength() ].i04 = m_rec[x+3].img
		LET m_rec2[ m_rec2.getLength() ].i05 = m_rec[x+4].img
		LET m_rec2[ m_rec2.getLength() ].i06 = m_rec[x+5].img
		LET m_rec2[ m_rec2.getLength() ].i07 = m_rec[x+6].img
		LET m_rec2[ m_rec2.getLength() ].i08 = m_rec[x+7].img
		LET m_rec2[ m_rec2.getLength() ].i09 = m_rec[x+8].img
		LET m_rec2[ m_rec2.getLength() ].i10 = m_rec[x+9].img
		LET m_rec3[ m_rec3.getLength() ].v01 = m_rec[x].val
		LET m_rec3[ m_rec3.getLength() ].v02 = m_rec[x+1].val
		LET m_rec3[ m_rec3.getLength() ].v03 = m_rec[x+2].val
		LET m_rec3[ m_rec3.getLength() ].v04 = m_rec[x+3].val
		LET m_rec3[ m_rec3.getLength() ].v05 = m_rec[x+4].val
		LET m_rec3[ m_rec3.getLength() ].v06 = m_rec[x+5].val
		LET m_rec3[ m_rec3.getLength() ].v07 = m_rec[x+6].val
		LET m_rec3[ m_rec3.getLength() ].v08 = m_rec[x+7].val
		LET m_rec3[ m_rec3.getLength() ].v09 = m_rec[x+8].val
		LET m_rec3[ m_rec3.getLength() ].v10 = m_rec[x+9].val
		LET m_rec4[ m_rec4.getLength() ].f01 = m_rec[x].font
		LET m_rec4[ m_rec4.getLength() ].f02 = m_rec[x+1].font
		LET m_rec4[ m_rec4.getLength() ].f03 = m_rec[x+2].font
		LET m_rec4[ m_rec4.getLength() ].f04 = m_rec[x+3].font
		LET m_rec4[ m_rec4.getLength() ].f05 = m_rec[x+4].font
		LET m_rec4[ m_rec4.getLength() ].f06 = m_rec[x+5].font
		LET m_rec4[ m_rec4.getLength() ].f07 = m_rec[x+6].font
		LET m_rec4[ m_rec4.getLength() ].f08 = m_rec[x+7].font
		LET m_rec4[ m_rec4.getLength() ].f09 = m_rec[x+8].font
		LET m_rec4[ m_rec4.getLength() ].f10 = m_rec[x+9].font
	END FOR
	CALL c.close()
END FUNCTION
