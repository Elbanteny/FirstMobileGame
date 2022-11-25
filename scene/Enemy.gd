extends Node2D

const BattleUnits = preload("res://BattleUnits.tres")

export (int) var enemyHp = 30 setget set_hp
export (int) var enemyDamage = 5

onready var EnemyHPLabel = $HPLabel
onready var AnimationEnemy = $AnimationEnemy
onready var EnemyAttackSound = $AnimationEnemy/EnemyAttackSound

signal died
signal end_turn

func set_hp(new_hp):
	enemyHp = new_hp
	if EnemyHPLabel != null:
		EnemyHPLabel.text = str(enemyHp) + " Hp"

func _ready():
		BattleUnits.Enemy = self	
func _exit_tree():
		BattleUnits.Enemy = null

func attack() -> void:	
	yield(get_tree().create_timer(0.5), "timeout")
	AnimationEnemy.play("attack")
	EnemyAttackSound.play()
	yield(AnimationEnemy, "animation_finished")
	emit_signal("end_turn")

func deal_damage():
	EnemyAttackSound.play()
	BattleUnits.PlayerStats.hp -= enemyDamage
	
func take_damage(amount):
	self.enemyHp -= amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		AnimationEnemy.play("shake")

func is_dead():
	return enemyHp <= 0


