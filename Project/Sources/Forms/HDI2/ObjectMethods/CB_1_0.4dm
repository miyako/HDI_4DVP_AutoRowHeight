If (Self:C308->=1)
	LISTBOX SET PROPERTY:C1440(*; "col0"; lk auto row height:K53:72; lk yes:K53:69)
Else 
	LISTBOX SET PROPERTY:C1440(*; "col0"; lk auto row height:K53:72; lk no:K53:68)
End if 

(OBJECT Get pointer:C1124(Object named:K67:5; "CB_AutoHeight"))->:=LISTBOX Get property:C917(*; "LB"; lk auto row height:K53:72)
