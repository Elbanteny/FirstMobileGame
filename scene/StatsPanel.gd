extends Panel

onready var HpLabel = $StatsContainer/Hp 
onready var ApLabel = $StatsContainer/Ap 
onready var MpLabel = $StatsContainer/Mp

func _on_PlayerStats_hp_changed(value):
	HpLabel.text = "HP\n"+str(value)

func _on_PlayerStats_ap_changed(value):
	ApLabel.text = "AP\n"+str(value)

func _on_PlayerStats_mp_changed(value):
	MpLabel.text = "MP\n"+str(value)
