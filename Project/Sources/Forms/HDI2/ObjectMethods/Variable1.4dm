C_LONGINT:C283($unit)
$unit:=Choose:C955(_rowUnit; 999; lk lines:K53:23; lk pixels:K53:22)  //0-1-2

If (vhMax<vhMin)
	vhMin:=vhMax
End if 

LISTBOX SET AUTO ROW HEIGHT:C1501(*; "LB"; lk row min height:K53:73; vhMin; $Unit)
LISTBOX SET AUTO ROW HEIGHT:C1501(*; "LB"; lk row max height:K53:74; vhMax; $Unit)
