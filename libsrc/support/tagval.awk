#  tagval.awk Copyright (c) 1993-2020, David A. Clunie DBA PixelMed Publishing. All rights reserved.
# create C++ headers from tag values template 

# can set these values on the command line:
#
#	role	  - either "declare" or "define"

NR==1	{
	print "// Automatically generated from template - EDITS WILL BE LOST"
	print ""
	print "// Generated by tagval.awk with options " role " " outname
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

/^[ 	]*TagValues/ {
	name=""
	if (match($0,"TagValues=\"[^\"]*\""))
		name=substr($0,RSTART+length("TagValues=\""),
			RLENGTH-length("TagValues=\"")-1);

	if (role == "declare") {
		print "char *\tTagValueDescription_" name "(Uint16 group,Uint16 element);"
	}
	else if (role == "define") {
		print "char *"
		print "TagValueDescription_" name "(Uint16 group,Uint16 element)"
		print "{"
		print "\tostrstream ost;"
		print "\tUint32 value=(((Uint32)group)<<16)|(Uint32)element;"
		print "\tswitch (value) {"
	}

	}

/^[ 	]*0x[0-9a-fA-F]*/ {

	valueline=$0
	if (!match(valueline,"[0-9][x0-9a-fA-F]*,[0-9][x0-9a-fA-F]*")) {
		print "Line " FNR \
			": error in value line - no group,element code <" \
			valueline ">" >"/dev/tty"
		next
	}
	code=substr(valueline,RSTART,RLENGTH)
	valueline=substr(valueline,RSTART+RLENGTH)

	group=""
	if (match(code,"[0-9][x0-9a-fA-F]*,")) {
		group=substr(code,RSTART,RLENGTH-1)
	}
	element=""
	if (match(code,",[0-9][x0-9a-fA-F]*")) {
		element=substr(code,RSTART+1,RLENGTH-1)
	}

	if (match(valueline,"[ 	]*=[ 	]*")) {
		meaning=substr(valueline,RSTART+RLENGTH)
		if (match(meaning,"[ 	]*,*[ 	]*$")) {
			meaning=substr(meaning,0,RSTART-1)
		}
	}
	else {
		meaning=code
	}

	if (group == "" || element == "") {
		print "Line " FNR \
			": error in value line - can't interpret group,element code <" \
			$0 ">" >"/dev/tty"
	}
	else {
		if (role == "define") {
			print "\t\tcase (((Uint32)" group ")<<16)|(Uint32)" element" :"
			print "\t\t\tost << \"" meaning "\" << ends;"
			print "\t\t\treturn ost.str();"
		}
	}

	}

/^[ 	]*}/ {
	if (role == "define") {
		print "\t\tdefault:"
		print "\t\t\treturn 0;"
		print "\t}"
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

