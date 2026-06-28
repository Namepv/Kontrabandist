extends Node

func buy_item():

	if GameManager.current_item == null:
		GameManager.ui_manager.show_status("Товар не найден")
		return

	if GameManager.money < calculate_price():
		GameManager.ui_manager.show_status("Недостаточно денег!")
		return

	if !Inventory.has_space():
		GameManager.ui_manager.show_status("Транспорт заполнен")
		return

	GameManager.money -= calculate_price()

	Inventory.add_item(GameManager.current_item.item_name)

	GameManager.ui_manager.refresh_all()

	GameManager.ui_manager.show_status("Куплено: " + GameManager.current_item.item_name)


func sell_item():

	if GameManager.current_item == null:
		GameManager.ui_manager.show_status("Товар не найден")
		return

	if !GameManager.inventory.has(GameManager.current_item.item_name):
		GameManager.ui_manager.show_status("Нет товара")
		return

	Inventory.remove_item(GameManager.current_item.item_name)

	GameManager.money += calculate_price()

	GameManager.ui_manager.refresh_all()

	GameManager.ui_manager.show_status("Продано: " + GameManager.current_item.item_name)


func change_city():

	if GameManager.current_city == GameManager.north_city:
		GameManager.current_city = GameManager.south_city
	else:
		GameManager.current_city = GameManager.north_city

	GameManager.ui_manager.update_city()

func calculate_price() -> int:
	return GameManager.current_city.prices[GameManager.current_item.item_name]
	
