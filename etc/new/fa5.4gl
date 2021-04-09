IMPORT util
IMPORT os
DEFINE m_pre, m_file, m_colr STRING
DEFINE m_out base.channel
DEFINE m_arr DYNAMIC ARRAY OF RECORD
		icon STRING,
		code STRING
	END RECORD
DEFINE m_cnt INTEGER
MAIN
	LET m_out = base.Channel.create()
	CALL m_out.openFile("fa5.txt", "w")
	CALL readLegacy()
	CALL procFile( "Font-Awesome/js/regular.js" )
	CALL procFile( "Font-Awesome/js/solid.js" )
	CALL procFile( "Font-Awesome/js/brands.js" )
	CALL m_out.close()
END MAIN
--------------------------------------------------------------------------------
FUNCTION readLegacy()
	DEFINE c base.channel
	DEFINE l_dir, l_line STRING
	DEFINE x, y SMALLINT
	LET l_dir = os.path.join(  fgl_getEnv("FGLDIR"), "lib" )
	LET c = base.Channel.create()
	CALL c.openFile( os.path.join( l_dir ,"image2font.txt"),"r")
	WHILE NOT c.isEof()	
		LET l_line = c.readLine()
		IF l_line.getLength() > 2 THEN
			IF l_line.subString(1,3) = "fa-" THEN	
				LET x = l_line.getIndexOf("=",4)
				LET m_arr[ m_cnt := m_cnt + 1 ].icon = l_line.subString(4,x-1)
				DISPLAY m_arr[ m_cnt ].icon
			END IF
			CALL m_out.writeLine( l_line )
		END IF
	END WHILE
	CALL c.close()
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION procFile( l_file STRING )
	DEFINE c base.channel
	DEFINE l_proc BOOLEAN = FALSE
	DEFINE l_line STRING
	LET c = base.Channel.create()
	CALL c.openFile(l_file,"r")
	LET l_file = os.path.baseName( l_file )
	--DISPLAY l_file
	CASE os.path.rootName( l_file )
		WHEN "regular"
			LET m_pre = "fa"
			LET m_file = "fa-regular-400.ttf"
			LET m_colr = NULL
		WHEN "solid"
			LET m_pre = "fas"
			LET m_file = "fa-solid-900.ttf"
			LET m_colr = NULL
		WHEN "brands"
			LET m_pre = "fab"
			LET m_file = "fa-brands-400.ttf"
			LET m_colr = "#f00"
	END CASE
	WHILE NOT c.isEof()	
		LET l_line = c.readLine()	
		IF NOT l_proc THEN
			IF l_line.getIndexOf( "var icons =", 1 ) > 0 THEN
				LET l_proc = TRUE
			END IF
		ELSE
			IF l_line.getIndexOf( "};", 1 ) > 0 THEN
				EXIT WHILE
			END IF
			CALL proc( l_line )
		END IF
	END WHILE
	CALL c.close()
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION proc( l_line STRING )
	DEFINE a, b, c, d SMALLINT
	DEFINE l_out STRING
	DEFINE l_nam, l_code STRING
	DEFINE x SMALLINT
	LET a = l_line.getIndexOf("\"",1) 	
	LET b = l_line.getIndexOf("\"",a+1) 	
	LET c = l_line.getIndexOf("\"",b+1) 	
	LET d = l_line.getIndexOf("\"",c+1) 	
	LET l_nam = l_line.subString(a+1,b-1)
	LET l_code = l_line.subString(c+1,d-1)
-- fas-align-center=fa-solid-900.ttf:f037
	FOR x = 1 TO m_cnt
		IF l_nam = m_arr[x].icon THEN
			RETURN 
		END IF
	END FOR
	LET m_arr[ m_cnt := m_cnt + 1 ].icon = l_nam
	DISPLAY m_arr[ m_cnt ].icon
	LET l_out = SFMT("%1-%2=%3:%4:%5", m_pre, l_nam, m_file, l_code, m_colr )
	CALL m_out.writeLine( l_out )
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION proc_json()
	
END FUNCTION
