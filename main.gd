extends Node2D

# Наш инвентарь
var inventory = {}
var cargo_capacity = 10
var money = 1000

@export var current_item: ItemData
@export var north_city: CityData
@export var south_city: CityData

var current_city: CityData


func _ready() -> void:
	update_inventory_label()
	update_balance_label()
	current_city = north_city
	update_city()
	update_cargo_label()

func update_city():
	$CityLabel.text = "Город: " + current_city.city_name
	$ItemPriceLabel.text = "Цена: " + str(current_city.food_price)

	if current_item:
		$ItemNameLabel.text = "Товар: " + current_item.item_name
		$ItemPriceLabel.text = "Цена: " + str(current_city.food_price) + " монет"


func update_balance_label():
	$MoneyLabel.text = "Баланс: " + str(money)

func get_total_cargo() -> int:

	var total = 0

	for item_name in inventory:
		total += inventory[item_name]

	return total

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

func update_cargo_label():
	$CargoLabel.text = "Груз: " + str(get_total_cargo()) + "/" + str(cargo_capacity)


func _on_btn_buy_pressed() -> void:
	
	if get_total_cargo() >= cargo_capacity:
		show_status("Транспорт заполнен")
		return
	# Если товар не назначен
	if not current_item:
		show_status("Товар не найден")
		return

	# Если денег недостаточно
	if money < current_city.food_price:
		show_status("Недостаточно денег!")
		return

	# Покупка
	money -= current_city.food_price
	update_cargo_label()
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


func _on_btn_change_city_pressed() -> void:

	if current_city == north_city:
		current_city = south_city
	else:
		current_city = north_city

	update_city()


func _on_btn_sell_pressed() -> void:

	if not current_item:
		show_status("Товар не найден")
		return

	if not inventory.has(current_item.item_name):
		show_status("Нет товара")
		return

	if inventory[current_item.item_name] <= 0:
		show_status("Нет товара")
		return

	inventory[current_item.item_name] -= 1
	update_cargo_label()
	money += current_city.food_price

	update_balance_label()
	update_inventory_label()

	show_status("Продано: " + current_item.item_name)
