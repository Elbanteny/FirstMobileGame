extends "res://scene/ActionButton.gd"

func _on_pressed():
	var playerStats = BattleUnits.PlayerStats
	if playerStats:
		if playerStats.mp >= 8:
			$HealSound.play()
			playerStats.hp += 5
			playerStats.mp -= 8
			playerStats.ap -= 1
