extends Node2D

var money = 1000
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	update_balance_label()
	pass # Replace with function body.

func update_balance_label():
	$Label.text = "Баланс: " + str(money)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_plus_pressed() -> void:
	money += 100
	print(money)
	update_balance_label()


func _on_button_minus_pressed() -> void:
	if money >= 100: # Проверка, чтобы баланс не уходил в минус
		money -= 100
	update_balance_label()
