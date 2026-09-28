var $unit : Integer
$unit:=Choose:C955(_rowUnit; -999; lk lines:K53:23; lk pixels:K53:22)  //0-1-2

vhMin:=LISTBOX Get auto row height:C1502(*; "LB"; lk row min height:K53:73; $unit)
vhMax:=LISTBOX Get auto row height:C1502(*; "LB"; lk row max height:K53:74; $unit)
