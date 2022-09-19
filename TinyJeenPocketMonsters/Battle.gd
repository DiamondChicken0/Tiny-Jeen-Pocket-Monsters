extends YSort

onready var PHealth = $Control/PlayerReadout/PlayerHealth
onready var PName = $Control/PlayerReadout/PlayerName
onready var PController = $Path2D2/PathFollow2D/Player/MonsterController
onready var PHealthBar = $Control/PlayerReadout/TextureProgress
var PHPpercentage

onready var EHealth = $Control/EnemyReadout/EnemyHealth
onready var EName = $Control/EnemyReadout/EnemyName
onready var EController = $Path2D/EnemyPath/Enemy/EnemyController
onready var EHealthBar = $Control/EnemyReadout/TextureProgress
var EHPpercentage

func _on_World_update():
	PHealth.text = str(PController.CurrentHP) + "/" + str(PController.HP)
	PName.text = PController.PlayerName
	PHealthBar.max_value = PController.HP
	PHealthBar.value = PController.CurrentHP
	PHPpercentage = (float(PController.CurrentHP) / PController.HP)
	
	if PHPpercentage <= 0.30:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (16).png")
	elif PHPpercentage >= 0.70:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (14).png")
	else:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (15).png")
		
	EHealth.text = str(EController.CurrentHP) + "/" + str(EController.HP)
	EName.text = EController.EnemyName
	EHealthBar.max_value = EController.HP
	EHealthBar.value = EController.CurrentHP
	EHPpercentage = (float(EController.CurrentHP) / EController.HP)
	
	if EHPpercentage <= 0.30:
		EHealthBar.texture_progress = load("res://pixil-frame-0 (16).png")
	elif EHPpercentage >= 0.70:
		EHealthBar.texture_progress = load("res://pixil-frame-0 (14).png")
	else:
		EHealthBar.texture_progress = load("res://pixil-frame-0 (15).png")

func _on_Move_Use(user, power, acc, type, name):
	pass
