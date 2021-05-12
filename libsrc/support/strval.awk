#  strval.awk Copyright (c) 1993-2020, David A. Clunie DBA PixelMed Publishing. All rights reserved.
# create C++ headers from string values template 

# can set these values on the command line:
#
#	role	  - either "declare" or "define"

NR==1	{
	print "// Automatically generated from template - EDITS WILL BE LOST"
	print ""
	print "// Generated by strval.awk with options " role " " outname
	print ""

	if (role == "declare" || role == "define") {
		print "#ifndef __Header_" outname "__"
		print "#define __Header_" outname "__"
		print ""
	}
	else {
		print "Error - role " role " invalid" >"/dev/tty"
		exit 1
	}

	mode=""
	}

/^[ 	]*StringValues/ {
	name=""
	if (match($0,"StringValues=\"[^\"]*\""))
		name=substr($0,RSTART+length("StringValues=\""),
			RLENGTH-length("StringValues=\"")-1);
	mode="values"

	if (role == "declare") {
		print "char *\tStringValueDescription_" name "(char * value);"
	}
	else if (role == "define") {
		print "static struct StringValueEntry"
		print "StringValueTable_" name "[] = {"
	}

	}
	
$0 !~ /(.*[{}])|(^[ 	]*$)|(^[ 	]*#)/ {

	if (mode == "values") {
		valueline=$0
#print "Line " FNR ": evaluating for code valueline = " valueline >"/dev/tty"
		#if (match(valueline,"[0-9a-zA-Z _/-][0-9a-zA-Z _/-]*")) {
		if (match(valueline,"[^ 	=,][^=,]*")) {
			code=substr(valueline,RSTART,RLENGTH)
#print "Line " FNR ": match code = " code >"/dev/tty"
			# remove trailing spaces ...
			if (match(code,"[ 	]*$")) {
				sub("[ 	]*$","",code);
				#code=substr(code,0,RSTART-1)
#print "Line " FNR ": removed trailing spaces now code = " code >"/dev/tty"
			}
			valueline=substr(valueline,RSTART+RLENGTH)
#print "Line " FNR ": now valueline = " valueline >"/dev/tty"
			if (code == "***EMPTYVALUE***") {
#print "Line " FNR ": empty value code " >"/dev/tty"
				code=""
			}
		}
		else {
			print "Line " FNR \
				": warning in value line - no code <" \
				valueline ">" >"/dev/tty"
			code=""
#print "Line " FNR ": no code " >"/dev/tty"
		}
#print "Line " FNR ": evaluating for meaning valueline = " valueline >"/dev/tty"
		if (match(valueline,"[ 	]*=[ 	]*")) {
			meaning=substr(valueline,RSTART+RLENGTH)
#print "Line " FNR ": match meaning = " meaning >"/dev/tty"
			if (match(meaning,"[ 	]*,*[ 	]*$")) {
				meaning=substr(meaning,0,RSTART-1)
#print "Line " FNR ": removed trailing spaces now meaning = " meaning >"/dev/tty"
			}
		}
		else {
			meaning=""
#print "Line " FNR ": no meaning " >"/dev/tty"
		}

		if (role == "define") {
			print "\t\"" code "\",\t\"" meaning "\","
		}
	}
	else {
		print "Line " FNR ": error - no group name" >"/dev/tty"
	}

	}

/^[ 	]*}/ {
	if (role == "define" && mode == "values") {
		print "\t0,0"
		print "};"
		print ""
		print "char *"
		print "StringValueDescription_" name "(char * value)"
		print "{"
		print "\treturn StringValueDescription(StringValueTable_" name ",value);"
		print "}"
		print ""
	}

	mode=""
	}

END {
	if (role == "declare" || role == "define") {
		print ""
		print "#endif /* __Header_" outname "__ */"
	}
}

