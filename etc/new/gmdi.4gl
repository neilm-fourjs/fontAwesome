
IMPORT os
DEFINE m_pre, m_file, m_colr STRING
DEFINE m_out base.channel
DEFINE m_arr DYNAMIC ARRAY OF RECORD
    icon STRING,
    code STRING
  END RECORD
DEFINE m_cnt INTEGER
DEFINE m_dir STRING
MAIN
  LET m_out = base.Channel.create()
  CALL m_out.openFile("gmdi.txt", "w")
  CALL readLegacy()

	LET m_dir = os.path.join( "material-design-icons","font" )
	CALL proc( "", "MaterialIcons-Regular", ".ttf" )
	CALL proc( "tt-", "MaterialIconsTwoTone-Regular", ".woff2" )
--	CALL proc( "r-", "MaterialIconsOutlined-Regular", ".otf" )
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
      IF l_line.subString(1,3) != "fa-" THEN
      	CALL m_out.writeLine( l_line )
      END IF
    END IF
  END WHILE
  CALL c.close()
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION proc( l_pre STRING, l_file STRING, l_ext STRING )
	DEFINE l_line STRING
	DEFINE x SMALLINT
  DEFINE c base.channel
  LET c = base.Channel.create()
	CALL c.openFile( os.path.join( m_dir ,l_file||".codepoints"),"r" )
	WHILE NOT c.isEof()
		LET l_line = c.readLine()
		IF l_line.getLength() > 2 THEN
			LET x = l_line.getIndexOf(" ",1)
			LET l_line = SFMT("%1%2=%3:%4", l_pre,l_line.subString(1,x-1), os.path.baseName(l_file)||l_ext, l_line.subString(x+1, l_line.getLength()) )
			CALL m_out.writeLine( l_line )
		END IF
	END WHILE
	CALL c.close()
END FUNCTION
