#  module.awk Copyright (c) 1993-2020, David A. Clunie DBA PixelMed Publishing. All rights reserved.
# create C++ headers from modules template 

# can set these values on the command line:
#
#	role	  - either "declare" or "build" or "verify" or "write"

function indentcode(count)
{
	if (count) {
		count=count*3;
		while (count-- > 0) {
			printf("\t")
		}
	}
}

function indentforwrite(count)
{
	if (count) {
		indentcode(count)
		printf("\tstream << \"")
		while (count-- > 0) {
			printf("\\t")
		}
		printf("\";\n")
	}
}

NR==1	{
	print "// Automatically generated from template - EDITS WILL BE LOST"
	print ""
	print "// Generated by module.awk with options " role " " outname
	print ""

	if (role == "declare" || role == "build" || role == "verify" || role == "write") {
		print "#ifndef __Header_" outname "__"
		print "#define __Header_" outname "__"
		print ""
	}
	else {
		print "Error - role " role " invalid" >"/dev/tty"
		exit 1
	}

	module=""
	macroormodule=""
}

/^[ 	]*Module=/ || /^[ 	]*DefineMacro=/ {

	module=""
	macroormodule=""
	if (match($0,"Module=\"[^\"]*\"")) {
		macroormodule="Module"
		module=substr($0,RSTART+length("Module=\""),
			RLENGTH-length("Module=\"")-1);
		}
	else if (match($0,"DefineMacro=\"[^\"]*\"")) {
		macroormodule="Macro"	# not DefineMacro
		module=substr($0,RSTART+length("DefineMacro=\""),
			RLENGTH-length("DefineMacro=\"")-1);
		}

	if (role == "declare") {
		print "class " macroormodule "_" module " : public Module {"
		print "\tconst char *module;"
	}
	else if (role == "build") {
		print macroormodule "_" module "::" macroormodule "_" module "(AttributeList *list,InformationEntity ie)"
		print "{"
		print "\t(void)list; // Quiets compiler in case module empty"
		print "\tAssert(list);"
		print "\tmodule = \"" module "\";"
		print ""
	}
	else if (role == "verify") {
		print "bool"
		print macroormodule "_" module "::verify(AttributeList *list,AttributeList *parentlist,AttributeList *rootlist,bool verbose,TextOutputStream& log,ElementDictionary *dict) const"
		print "{"
		#print "\tconst char *module = \"" module "\";"
		print "\t(void)module;  // Quiets compiler in case module empty"
		print "\t(void)list;"
		print "\t(void)verbose;"
		print "\t(void)log;"
		print "\t(void)dict;"
		print "\tAssert(list);"
		print "\tAssert(dict);"
		print ""
		print "\tbool success=true;"
		print ""
		print "\tif (verbose)"
		print "\t\tlog << MMsgDC(Verifying) << \" \" << MMsgDC(" macroormodule ") << \" \" << module << endl;"
		print ""
	}
	else if (role == "write") {
		print "void"
		print macroormodule "_" module "::write(TextOutputStream& stream,AttributeList *list,ElementDictionary *dict) const"
		print "{"
		print "\tstream << \"\\t" macroormodule " <" module ">\\n\";"
		print ""
	}
	sequencenestingdepth=0;
}

/^[ 	]*ModuleEnd/ || /^[ 	]*MacroEnd/{

	if (role == "declare") {
		print "public:"
		print "\t            " macroormodule "_" module "(AttributeList *list,InformationEntity ie);"
		print "\tconst char *identify(void) const { return \"" module "\"; }"
		print "\tvoid        write(TextOutputStream& stream,AttributeList *list,ElementDictionary *dict) const ;"
		print "\tbool        verify(AttributeList *list,AttributeList *parentlist,AttributeList *rootlist,bool verbose,TextOutputStream& log,ElementDictionary *dict) const;"
		print "};"
		print ""
	}
	else if (role == "build") {
		print "}"
		print ""
	}
	else if (role == "verify") {
		print "\treturn success;"
		print "}"
		print ""
	}
	else if (role == "write") {
		print "}"
		print ""
	}

	module=""
	if (sequencenestingdepth != 0)
		print "Error - sequence nesting depth invalid ( " sequencenestingdepth ") - missing or extra SequenceEnd at line " FNR >"/dev/tty"

}

/^[ 	]*Sequence=/ {

	donotsetused="F"
	if (match($0,"DoNotSetUsed=\"[^\"]*\""))
		donotsetused="T";

	sequence=""
	if (match($0,"Sequence=\"[^\"]*\""))
		sequence=substr($0,RSTART+length("Sequence=\""),
			RLENGTH-length("Sequence=\"")-1);

	type=""
	if (match($0,"Type=\"[^\"]*\""))
		type=substr($0,RSTART+length("Type=\""),
			RLENGTH-length("Type=\"")-1);

	vm=""
	match($0,"VM=\"[^\"]*\"");
	vm=substr($0,RSTART+length("VM=\""),RLENGTH-length("VM=\"")-1);
	if (vm == "") {
		print "Warning - missing number of sequence items (VM) at line " FNR >"/dev/tty"
		vm="n";	# supresses checking
	}
	vmmin=vmmax=vm;
	if (vm == "n") {
		vmmin=0;
		vmmax="VMUNLIMITED";
	}
	if (match(vm,"-")) {
		match(vm,"[0-9]*-");
		vmmin=substr(vm,RSTART,RLENGTH-1);
		match(vm,"-[0-9n]");
		vmmax=substr(vm,RSTART+1,RLENGTH-1);
		if (vmmax == "n") vmmax="VMUNLIMITED";
	}

	condition=""
	if (match($0,"Condition=\"[^\"]*\""))
		condition=substr($0,RSTART+length("Condition=\""),
			RLENGTH-length("Condition=\"")-1);

	noconditionpresent="no"
	if (match($0,"NoCondition=\"[^\"]*\""))
		noconditionpresent="yes";

	mbpo="false"
	if (match($0,"[Mm]bpo=\"[^\"]*\""))
		mbpo=substr($0,RSTART+length("mbpo=\""),
			RLENGTH-length("mbpo=\"")-1);
	
	if (length(sequence) > 0) {
		if (sequencenestingdepth == 0) {
			# declare globally
			if (role == "declare") {
				print "\tAttribute *" sequence ";"
			}
			else if (role == "build") {
				print "\t" sequence " = (*list)[TagFromName(" sequence ")];"
				# do not reset it if already set (else calls during verify or write undo the work done during build)
				print "\tif (" sequence ") {"
				print "\t\tif (" sequence "->getInformationEntity() == UnknownIE) " sequence "->setInformationEntity(ie);"
				print "\t\telse if (getDepthOfInformationEntity(" sequence "->getInformationEntity()) < getDepthOfInformationEntity(ie)) " sequence "->setInformationEntity(ie);"
				print "\t}"
				print ""
			}
		}
		else {
			# declare locally if going to be used
			if (role == "write" || role == "verify") {
				print "\tAttribute *" sequence " = (*list)[TagFromName(" sequence ")];"
			}
		}

		if (role == "write") {
			indentforwrite(sequencenestingdepth)
			indentcode(sequencenestingdepth)
			print "\tif (" sequence ")"
			indentcode(sequencenestingdepth)
			print "\t\tstream << \"\\t\\tSequence <" sequence ">\\n\";"
			indentcode(sequencenestingdepth)
			print "\telse"
			indentcode(sequencenestingdepth)
			print "\t\tstream << \"\\t\\tSequence <" sequence "> not present\\n\";"
		}
		else if (role == "verify") {
			indentcode(sequencenestingdepth)
			if (donotsetused == "F") {
				printf("\tif (" sequence ") " sequence "->setUsed();\n")
			}
			#if (donotsetused == "T") {
			#	printf("\t{ Attribute *a = (*list)[TagFromName(" sequence ")];}\n")
			#}
			#else {
			#	printf("\t{ Attribute *a = (*list)[TagFromName(" sequence ")]; if (a) a->setUsed(); }\n")
			#}
			indentcode(sequencenestingdepth)
			printf("\tif (! ")
			if (length(type) > 0) {
				print "verifyType" type
			}
			else {
				print "verifyRequired"
			}
			indentcode(sequencenestingdepth)
			print "\t\t\t(" sequence ","
			indentcode(sequencenestingdepth)
			print "\t\t\t\"" module "\",\"" sequence "\","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict,"
			indentcode(sequencenestingdepth)
			if (type == "1C" || type == "2C" || type == "3C") {
				if (length(condition) > 0) {
					print "\t\t\tCondition_" condition ", "
				}
				else {
					print "\t\t\t0, "
					if (noconditionpresent == "no") {
						print "Warning - missing Condition at line " FNR >"/dev/tty"
					}
				}
				if (type == "1C" || type == "2C") {		# mbpo never applies to Type 3C
					indentcode(sequencenestingdepth)
					print "\t\t\t" mbpo ", "
				}
				indentcode(sequencenestingdepth)
				print "\t\t\tlist,parentlist,rootlist, "
			}
			else {
				if (length(condition) > 0) {
					print "Error - unwanted Condition at line " FNR >"/dev/tty"
				}
			}
			indentcode(sequencenestingdepth)
			print "\t\t\t" vmmin "," vmmax ")) success=false;"

			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying " sequence " \" << (success ? \"success\" : \"failure\") << endl;";
		}

		if (role == "write" || role == "verify") {
			# create new state for subsequent stuff enclosed in sequence ...

			indentcode(sequencenestingdepth)
			print "\tif (" sequence " && strcmp(" sequence "->getVR(),\"SQ\") == 0) {"
			indentcode(sequencenestingdepth)
			print "\t\tAttributeList **array;"
			indentcode(sequencenestingdepth)
			print "\t\tint n;"
			indentcode(sequencenestingdepth)
			print "\t\tif ((n="sequence "->getLists(&array)) > 0) {"
			indentcode(sequencenestingdepth)
			print "\t\t\tint i; for (i=0; i<n; ++i) {"
			if (role == "verify") {
				indentcode(sequencenestingdepth)
				print "\t\t\t\tif (verbose)"
				indentcode(sequencenestingdepth)
				print "\t\t\t\t\tlog << \"" sequence "\" << \" item [\" << (i+1) << \"]\" << endl;";
				indentcode(sequencenestingdepth)
				print "\t\t\t\tAttributeList *parentlist=list;"
			}
			indentcode(sequencenestingdepth)
			print "\t\t\t\tAttributeList *list=array[i];"

			if (role == "write") {
				#indentcode(sequencenestingdepth)
				#print "\t\t\t\tif (i) {"
				indentforwrite(sequencenestingdepth)
				indentcode(sequencenestingdepth)
				#print "\t\t\t\t\tstream << \"\\t\\t----\" << endl;"
				print "\t\t\t\t\tstream << \"\\t\\tItem\" << endl;"
				#indentcode(sequencenestingdepth)
				#print "\t\t\t\t}"
			}

			# this value of list will be used until a SequenceEnd is seen
		}
		++sequencenestingdepth
	}
}

/^[ 	]*SequenceEnd/ {

	--sequencenestingdepth

	if (role == "write" || role == "verify") {
		# take down nesting for stuff enclosed in sequence ...

		indentcode(sequencenestingdepth)
		print "\t\t\t}"
		indentcode(sequencenestingdepth)
		print "\t\t}"
		indentcode(sequencenestingdepth)
		print "\t}"
	}
}

/^[ 	]*(Name|Verify)=/ {

	donotsetused="F"
	if (match($0,"DoNotSetUsed=\"[^\"]*\""))
		donotsetused="T";

	name=""
	if (match($0,"Name=\"[^\"]*\""))
		name=substr($0,RSTART+length("Name=\""),
			RLENGTH-length("Name=\"")-1);

	verify=""
	if (match($0,"Verify=\"[^\"]*\""))
		verify=substr($0,RSTART+length("Verify=\""),
			RLENGTH-length("Verify=\"")-1);

	type=""
	if (match($0,"Type=\"[^\"]*\""))
		type=substr($0,RSTART+length("Type=\""),
			RLENGTH-length("Type=\"")-1);

	stringdefinedterms=""
	if (match($0,"StringDefinedTerms=\"[^\"]*\""))
		stringdefinedterms=substr($0,RSTART+length("StringDefinedTerms=\""),
			RLENGTH-length("StringDefinedTerms=\"")-1);

	stringenumvalues=""
	if (match($0,"StringEnumValues=\"[^\"]*\""))
		stringenumvalues=substr($0,RSTART+length("StringEnumValues=\""),
			RLENGTH-length("StringEnumValues=\"")-1);

	binaryenumvalues=""
	if (match($0,"BinaryEnumValues=\"[^\"]*\""))
		binaryenumvalues=substr($0,RSTART+length("BinaryEnumValues=\""),
			RLENGTH-length("BinaryEnumValues=\"")-1);

	tagenumvalues=""
	if (match($0,"TagEnumValues=\"[^\"]*\""))
		tagenumvalues=substr($0,RSTART+length("TagEnumValues=\""),
			RLENGTH-length("TagEnumValues=\"")-1);

	binarybitmap=""
	if (match($0,"BinaryBitMap=\"[^\"]*\""))
		binarybitmap=substr($0,RSTART+length("BinaryBitMap=\""),
			RLENGTH-length("BinaryBitMap=\"")-1);

	match($0,"VM=\"[^\"]*\"");
	vm=substr($0,RSTART+length("VM=\""),RLENGTH-length("VM=\"")-1);
	if (vm == "") vm=0;
	vmmin=vmmax=vm;
	if (vm == "n") {
		vmmin=1;
		vmmax="VMUNLIMITED";
	}
	if (match(vm,"-")) {
		match(vm,"[0-9]*-");
		vmmin=substr(vm,RSTART,RLENGTH-1);
		match(vm,"-[0-9n]");
		vmmax=substr(vm,RSTART+1,RLENGTH-1);
		if (vmmax == "n") vmmax="VMUNLIMITED";
	}

	selector=""
	if (match($0,"ValueSelector=\"[^\"]*\""))
		selector=substr($0,RSTART+length("ValueSelector=\""),
			RLENGTH-length("ValueSelector=\"")-1);

	if (length(selector) == 0) {
		selector="-1"		# default is wildcard not 1st value !
	}
	else if (selector == "*") {
		selector="-1"		# wildcard
	}

	condition=""
	if (match($0,"Condition=\"[^\"]*\""))
		condition=substr($0,RSTART+length("Condition=\""),
			RLENGTH-length("Condition=\"")-1);

	noconditionpresent="no"
	if (match($0,"NoCondition=\"[^\"]*\""))
		noconditionpresent="yes";

	mbpo="false"
	if (match($0,"[Mm]bpo=\"[^\"]*\""))
		mbpo=substr($0,RSTART+length("mbpo=\""),
			RLENGTH-length("mbpo=\"")-1);

	notzero="no"
	if (match($0,"NotZeroWarning=\"[^\"]*\"")) {
		notzero="warning";
	}
	else if (match($0,"NotZeroError=\"[^\"]*\"")) {
		notzero="error";
	}
	
	message=""
	messageConditionModifier=""
	messageErrorOrWarning=""
	if (match($0,"ThenErrorMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="E"
		message=substr($0,RSTART+length("ThenErrorMessage=\""),
			RLENGTH-length("ThenErrorMessage=\"")-1);
	}
	if (match($0,"ThenWarningMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="W"
		message=substr($0,RSTART+length("ThenWarningMessage=\""),
			RLENGTH-length("ThenWarningMessage=\"")-1);
	}
	if (match($0,"ThenMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="M"
		message=substr($0,RSTART+length("ThenMessage=\""),
			RLENGTH-length("ThenMessage=\"")-1);
	}
	
	if (match($0,"ElseErrorMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="E"
		messageConditionModifier="!"
		message=substr($0,RSTART+length("ElseErrorMessage=\""),
			RLENGTH-length("ElseErrorMessage=\"")-1);
	}
	if (match($0,"ElseWarningMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="W"
		messageConditionModifier="!"
		message=substr($0,RSTART+length("ElseWarningMessage=\""),
			RLENGTH-length("ElseWarningMessage=\"")-1);
	}
	if (match($0,"ElseMessage=\"[^\"]*\"")) {
		messageErrorOrWarning="M"
		messageConditionModifier="!"
		message=substr($0,RSTART+length("ElseMessage=\""),
			RLENGTH-length("ElseMessage=\"")-1);
	}

	showValueWithMessage="false"
	if (match($0,"ShowValueWithMessage=\"[^\"]*\""))
		showValueWithMessage=substr($0,RSTART+length("ShowValueWithMessage=\""),
			RLENGTH-length("ShowValueWithMessage=\"")-1);
	
	if (length(name) > 0) {
		if (sequencenestingdepth == 0) {
			# declare globally
			if (role == "declare") {
				print "\tAttribute *" name ";"
			}
			else if (role == "build") {
				print "\t" name " = (*list)[TagFromName(" name ")];"
				# do not reset it if already set (else calls during verify or write undo the work done during build)
				print "\tif (" name ") {"
				print "\t\tif (" name "->getInformationEntity() == UnknownIE) " name "->setInformationEntity(ie);"
				print "\t\telse if (getDepthOfInformationEntity(" name "->getInformationEntity()) < getDepthOfInformationEntity(ie)) " name "->setInformationEntity(ie);"
				print "\t}"
				print ""
			}
		}
		else {
			# declare locally if going to be used
			if (role == "write" || role == "verify") {
				indentcode(sequencenestingdepth)
				print "\tAttribute *" name " = (*list)[TagFromName(" name ")];"
			}
		}

		if (role == "write") {
			indentforwrite(sequencenestingdepth)
			indentcode(sequencenestingdepth)
			print "\tif (" name ") {"
			indentcode(sequencenestingdepth)
			print "\t\tstream << \"\\t\\t\";"
			indentcode(sequencenestingdepth)
			print "\t\t" name "->write(stream,dict);"
			indentcode(sequencenestingdepth)
			print "\t\tstream << \"\\n\";"
			indentcode(sequencenestingdepth)
			print "\t}"
			indentcode(sequencenestingdepth)
			print "\telse"
			indentcode(sequencenestingdepth)
			print "\t\tstream << \"\\t\\tElement <" name "> not present\\n\";"
			print ""
		}
		else if (role == "verify") {
			if (length(name) > 0) {
				indentcode(sequencenestingdepth)
				if (donotsetused == "F") {
					printf("\tif (" name ") " name "->setUsed();\n")
				}
				#if (donotsetused == "T") {
				#	printf("\t{ Attribute *a = (*list)[TagFromName(" name ")];}\n")
				#}
				#else {
				#	printf("\t{ Attribute *a = (*list)[TagFromName(" name ")]; if (a) a->setUsed(); }\n")
				#}
			}
			indentcode(sequencenestingdepth)
			printf("\tif (! ");
			if (length(type) > 0) {
				print "verifyType" type
			}
			else {
				print "verifyRequired"
			}
			indentcode(sequencenestingdepth)
			print "\t\t\t(" name ","
			indentcode(sequencenestingdepth)
			print "\t\t\t\"" module "\",\"" name "\","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict,"
			indentcode(sequencenestingdepth)
			if (type == "1C" || type == "2C" || type == "3C") {
				if (length(condition) > 0) {
					print "\t\t\tCondition_" condition ", "
				}
				else {
					print "\t\t\t0, "
					if (noconditionpresent == "no") {
						print "Warning - missing Condition at line " FNR >"/dev/tty"
					}
				}
				if (type == "1C" || type == "2C") {		# mbpo never applies to Type 3C
					indentcode(sequencenestingdepth)
					print "\t\t\t" mbpo ", "
				}
				indentcode(sequencenestingdepth)
				print "\t\t\tlist,parentlist,rootlist, "
			}
			else {
				if (length(condition) > 0) {
					print "Error - unwanted Condition at line " FNR >"/dev/tty"
				}
			}
			indentcode(sequencenestingdepth)
			print "\t\t\t" vmmin "," vmmax ")) success=false;"

			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
	}

	if ((length(name) > 0 || length(verify) > 0) && role == "verify") {
		if (length(name) == 0 && length(verify) > 0) name=verify;
		if (length(verify) > 0 && vm != "0") {		# check that VM was explicitly specified and do NOT repeat VM check for other than verify case
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyVM("
			indentcode(sequencenestingdepth)
			print "\t\t\t\"" module "\",\"" name "\",log,dict," vmmin "," vmmax ",\"" condition "\")) success=false;"	# use condition as source
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
		}
		if (length(stringdefinedterms) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name ") " name "->verifyDefinedTerms("
			indentcode(sequencenestingdepth)
			print "\t\t\tStringValueDescription_" stringdefinedterms ","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector ");"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying string defined terms " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
		if (length(stringenumvalues) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyEnumValues("
			indentcode(sequencenestingdepth)
			print "\t\t\tStringValueDescription_" stringenumvalues ","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector ")) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying string enumerated values " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
		if (length(binaryenumvalues) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyEnumValues("
			indentcode(sequencenestingdepth)
			print "\t\t\tBinaryValueDescription_" binaryenumvalues ","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector ")) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying binary enumerated values " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
		if (length(tagenumvalues) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyEnumValues("
			indentcode(sequencenestingdepth)
			print "\t\t\tTagValueDescription_" tagenumvalues ","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector ")) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying tag enumerated values " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
		if (length(binarybitmap) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyBitMap("
			indentcode(sequencenestingdepth)
			print "\t\t\tBinaryBitMapDescription_" binarybitmap ","
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector ")) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying binary bit map " name " \" << (success ? \"success\" : \"failure\") << endl;";
		}
		if (notzero != "no") {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tif (" name " && !" name "->verifyNotZero("
			indentcode(sequencenestingdepth)
			print "\t\t\tverbose,log,dict," selector "," (notzero == "warning" ? "true" : "false") ")) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
		}
		if (length(message) > 0 && length(messageErrorOrWarning) > 0) {
			print ""
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (" messageConditionModifier "Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\t\tlog << " messageErrorOrWarning "MsgDCNull() << \"" message " - attribute <" name ">\""
			if (showValueWithMessage == "true") {
				print "\t\t\t<< \" = <\" << (const char *)AttributeValue((*list)[TagFromName(" name ")],\"\") << \">\""
			}
			print "\t\t\t<< endl;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
		}
		print ""
	}
	
	}

/^[	 ]*InvokeMacro=/ {

        invokedmacro=""
        if (match($0,"InvokeMacro=\"[^\"]*\""))
                invokedmacro=substr($0,RSTART+length("InvokeMacro=\""),
                        RLENGTH-length("InvokeMacro=\"")-1);

        condition=""
        if (match($0,"Condition=\"[^\"]*\""))
                condition=substr($0,RSTART+length("Condition=\""),
                        RLENGTH-length("Condition=\"")-1);

        if (role == "verify") {
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\tif (Condition_" condition "(list,parentlist,rootlist)) {"
			}
			indentcode(sequencenestingdepth)
			print "\tif (!Macro_" invokedmacro "(list,ie).verify(list,parentlist,rootlist,verbose,log,dict)) success=false;"
			if (length(condition) > 0) {
				indentcode(sequencenestingdepth)
				print "\t}"
			}
			print ""
			indentcode(sequencenestingdepth)
			print "\tif (verbose)"
			indentcode(sequencenestingdepth)
			print "\t\tlog << \"" module " success after verifying " invokedmacro " \" << (success ? \"success\" : \"failure\") << endl;";
        }
        else if (role == "write") {
			indentforwrite(sequencenestingdepth+1)
			print "\tMacro_" invokedmacro "(list,ie).write(stream,list,dict);"
			indentforwrite(sequencenestingdepth+1)
			print "\tstream << \"\\tEndMacro <" invokedmacro ">\\n\";"
			print ""
        }
		else if (role == "build") {
			if (module != "DocumentRelationshipMacro") {
				# build a macro, just to set the IE of the attributes that it uses - need to be sure that subsequent constructor calls during write or verify do not undo setting of IE
				print "\tnew Macro_" invokedmacro "(list,ie);"
			}
			# else supress, since causes infinite recursive invocation, and we don't need it anyway
		}

        }

END {
	if (role == "declare" || role == "build" || role == "verify" || role == "write") {
		print ""
		print "#endif /* __Header_" outname "__ */"
	}
}



