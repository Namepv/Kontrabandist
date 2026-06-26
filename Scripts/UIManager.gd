extends Node

func refresh_all():

	update_balance_label()
	update_inventory_label()
	update_city()
	update_cargo_label()


func update_balance_label():

	$MoneyLabel.text = "Баланс: " + str(GameManager.money)


func update_cargo_label():

	$CargoLabel.text = "Груз: " + str(Inventory.get_total_cargo()) + "/" + str(GameManager.cargo_capacity)


func show_status(message: String):

	$StatusLabel.text = message


func update_city():

	if GameManager.current_city == null:
		return

	$CityLabel.text = "Город: " + GameManager.current_city.city_name

	if GameManager.current_item:
		$ItemNameLabel.text = "Товар: " + GameManager.current_item.item_name
		$ItemPriceLabel.text = "Цена: " + str(GameManager.current_city.food_price) + " монет"


func update_inventory_label():

	var text := "Инвентарь:\n"

	for item_name in GameManager.inventory:
		text += item_name + " x" + str(GameManager.inventory[item_name]) + "\n"

	$InventoryLabel.text = text
