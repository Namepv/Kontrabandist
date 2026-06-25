extends Node2D

var money = 1000

# Наш инвентарь
var inventory = {}

@export var current_item: ItemData
@export var city: CityData


func _ready() -> void:
	update_inventory_label()
	update_balance_label()

	if current_item:
		$ItemNameLabel.text = "Товар: " + current_item.item_name
		$ItemPriceLabel.text = "Цена: " + str(current_item.price) + " монет"


func update_balance_label():
	$MoneyLabel.text = "Баланс: " + str(money)


func show_status(message: String):
	$StatusLabel.text = message

	await get_tree().create_timer(2.0).timeout

	# Очищаем только если сообщение не изменилось
	if $StatusLabel.text == message:
		$StatusLabel.text = ""


func _on_button_plus_pressed() -> void:
	money += 100
	update_balance_label()


func _on_button_minus_pressed() -> void:
	if money >= 100:
		money -= 100

	update_balance_label()


func _on_btn_buy_pressed() -> void:

	# Если товар не назначен
	if not current_item:
		show_status("Товар не найден")
		return

	# Если денег недостаточно
	if money < current_item.price:
		show_status("Недостаточно денег!")
		return

	# Покупка
	money -= current_item.price

	# Добавляем товар в инвентарь
	if inventory.has(current_item.item_name):
		inventory[current_item.item_name] += 1
	else:
		inventory[current_item.item_name] = 1

	update_balance_label()
	update_inventory_label()

	show_status("Куплено: " + current_item.item_name)

	print("Инвентарь:")
	print(inventory)

func update_inventory_label():

	var text = "Инвентарь:\n"

	for item_name in inventory:
		text += item_name + " x" + str(inventory[item_name]) + "\n"

	$InventoryLabel.text = text
