


/**** Get catalogid's that have invalid characters ****/
--DECLARE @WhiteListedCharacters NVARCHAR(1000 ) = ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
DECLARE @WhiteListedCharacters NVARCHAR(1000 ) = ' !"#$%&' + CHAR(39) + '()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
SELECT catalogid, cname,
        REPLACE(
            TRANSLATE(cname, 
                        @WhiteListedCharacters COLLATE Latin1_General_100_BIN2, 
                        REPLICATE(LEFT(@WhiteListedCharacters,1), LEN(@WhiteListedCharacters))), 
        LEFT(@WhiteListedCharacters,1), 
        '') AS BadChars
FROM   products 
WHERE LEN(
			REPLACE(
				TRANSLATE(cname, 
							@WhiteListedCharacters COLLATE Latin1_General_100_BIN2, 
							REPLICATE(LEFT(@WhiteListedCharacters,1), LEN(@WhiteListedCharacters))), 
			LEFT(@WhiteListedCharacters,1), 
			'')  -- returned len of badchars
		) > 0


/**** Show invalid chars for records above ****/
SELECT catalogid, dbo.Find_Invalid_Chars(cdescription) [Invalid Characters]
FROM products
WHERE dbo.Find_Invalid_Chars(cdescription) IS NOT NULL
	AND catalogid IN (12763, 9874, 9876, 9773)


