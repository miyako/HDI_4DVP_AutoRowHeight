Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY PICTURE:C279(col0; 0)
		ARRAY TEXT:C222(col1; 0)
		ARRAY TEXT:C222(col2; 0)
		ARRAY TEXT:C222(col3; 0)
		
		ALL RECORDS:C47([DOC:1])
		SELECTION TO ARRAY:C260([DOC:1]Title:2; col1; [DOC:1]ShortText:3; col2; [DOC:1]LongText:4; col3; [DOC:1]SamplePict:5; col0)
		
		
		//--------------------------------------------------------------------------------------
		
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_AutoHeight"))->:=LISTBOX Get property:C917(*; "LB"; lk auto row height:K53:72)
		
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_1_0"))->:=LISTBOX Get property:C917(*; "col0"; lk auto row height:K53:72)
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_1_1"))->:=LISTBOX Get property:C917(*; "col1"; lk auto row height:K53:72)
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_1_2"))->:=LISTBOX Get property:C917(*; "col2"; lk auto row height:K53:72)
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_1_3"))->:=LISTBOX Get property:C917(*; "col3"; lk auto row height:K53:72)
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_2_1"))->:=LISTBOX Get property:C917(*; "col1"; lk allow wordwrap:K53:39)
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_2_2"))->:=LISTBOX Get property:C917(*; "col2"; lk allow wordwrap:K53:39)
		(OBJECT Get pointer:C1124(Object named:K67:5; "CB_2_3"))->:=LISTBOX Get property:C917(*; "col3"; lk allow wordwrap:K53:39)
		
		
		ARRAY TEXT:C222(_pictFormat; 0)
		APPEND TO ARRAY:C911(_pictFormat; "Truncated centered (*)")  //1
		APPEND TO ARRAY:C911(_pictFormat; "Scaled to fit")  //2
		APPEND TO ARRAY:C911(_pictFormat; "On background")  //3
		APPEND TO ARRAY:C911(_pictFormat; "Truncated non centered (*)")  //4
		APPEND TO ARRAY:C911(_pictFormat; "Scaled to fit proportional (*)")  //5
		APPEND TO ARRAY:C911(_pictFormat; "Scaled to fit prop centered (*)")  //6
		APPEND TO ARRAY:C911(_pictFormat; "Replicated")  //7
		_pictFormat:=Character code:C91(OBJECT Get format:C894(*; "col0"))
		
		
		ARRAY TEXT:C222(_rowUnit; 0)
		APPEND TO ARRAY:C911(_rowUnit; "Lines")  //1
		APPEND TO ARRAY:C911(_rowUnit; "Pixels")  //2
		_rowUnit:=1
		
		vhMin:=LISTBOX Get auto row height:C1502(*; "LB"; lk row min height:K53:73; lk lines:K53:23)
		vhMax:=LISTBOX Get auto row height:C1502(*; "LB"; lk row max height:K53:74; lk lines:K53:23)
		
End case 

