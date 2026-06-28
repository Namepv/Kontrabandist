extends Node

var root

func refresh_all():
	update_balance_label()
	update_inventory_label()
	update_city()
	update_cargo_label()


func update_balance_label():
	root.get_node("MoneyLabel").text = "Баланс: " + str(GameManager.money)


func update_cargo_label():
	root.get_node("CargoLabel").text = "Груз: " + str(Inventory.get_total_cargo()) + "/" + str(GameManager.cargo_capacity)


func show_status(message: String):
	root.get_node("StatusLabel").text = message


func update_city():
	if GameManager.current_city == null:
		return

	root.get_node("CityLabel").text = "Город: " + GameManager.current_city.city_name

	if GameManager.current_item:
		root.get_node("ItemNameLabel").text = "Товар: " + GameManager.current_item.item_name
		root.get_node("ItemPriceLabel").text = "Цена: " + str(TradeManager.calculate_price()) + " монет"


func update_inventory_label():
	var text := "Инвентарь:\n"
	for item_name in GameManager.inventory:
		text += item_name + " x" + str(GameManager.inventory[item_name]) + "\n"

	root.get_node("InventoryLabel").text = text

func _ready():
	root = get_parent()
	GameManager.ui_manager = self
	refresh_all()
