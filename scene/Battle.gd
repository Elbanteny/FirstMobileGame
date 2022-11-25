extends Node

const BattleUnits = preload("res://BattleUnits.tres")

export(Array, PackedScene) var enemies = []

onready var battleActionButtons = $UI/battleActionButtons
onready var fadeAnimation = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoomButton
onready var enemyPosition = $EnemyPosition
onready var TutorialPopup = $TutorialPopup
onready var StartButton = $"TutorialPopup/Start Button"


func _ready():
	TutorialPopup.show()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy:
		enemy.connect("died", self, "_on_enemy_died")


func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy != null and not enemy.is_queued_for_deletion():
		enemy.attack()		
		yield(enemy,"end_turn")	
	start_player_turn()

func start_player_turn():
	var playerStats = BattleUnits.PlayerStats
	battleActionButtons.show()
	playerStats.ap = playerStats.max_ap
	yield(playerStats, "end_turn")	
	start_enemy_turn()

func create_new_enemy():
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyPosition.add_child(enemy)
	enemy.connect("died", self, "_on_enemy_died")

func _on_enemy_died():
	battleActionButtons.hide()
	nextRoomButton.show()

func _on_NextRoomButton_pressed():
	nextRoomButton.hide()
	fadeAnimation.play("FadeToNewRoom")
	$UI/CenterContainer/NextRoomButton/FadeSound.play()
	yield(fadeAnimation, "animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()
	
func _on_Start_Button_pressed():
	StartButton.hide()
	TutorialPopup.hide()
