extends YSort

onready var PHealth = $Control/PlayerReadout/PlayerHealth
onready var PName = $Control/PlayerReadout/PlayerName
onready var PController = $Path2D2/PathFollow2D/Player/MonsterController
onready var PHealthBar = $Control/PlayerReadout/TextureProgress
var PHPpercentage

func _on_World_update():
	PHealth.text = str(PController.CurrentHP) + "/" + str(PController.HP)
	PName.text = PController.PlayerName
	PHealthBar.max_value = PController.HP
	PHealthBar.value = PController.CurrentHP
	PHPpercentage = (float(PController.CurrentHP) / PController.HP)
	print (PHPpercentage)
	
	if PHPpercentage <= 0.30:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (16).png")
	elif PHPpercentage >= 0.70:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (14).png")
	else:
		PHealthBar.texture_progress = load("res://pixil-frame-0 (15).png")

