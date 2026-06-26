extends Node

func buy_item():

	if GameManager.current_item == null:
		UIManager.show_status("Товар не найден")
		return

	if GameManager.money < GameManager.current_city.food_price:
		UIManager.show_status("Недостаточно денег!")
		return

	if !Inventory.has_space():
		UIManager.show_status("Транспорт заполнен")
		return

	GameManager.money -= GameManager.current_city.food_price

	Inventory.add_item(GameManager.current_item.item_name)

	UIManager.refresh_all()

	UIManager.show_status("Куплено: " + GameManager.current_item.item_name)


func sell_item():

	if GameManager.current_item == null:
		UIManager.show_status("Товар не найден")
		return

	if !GameManager.inventory.has(GameManager.current_item.item_name):
		UIManager.show_status("Нет товара")
		return

	Inventory.remove_item(GameManager.current_item.item_name)

	GameManager.money += GameManager.current_city.food_price

	UIManager.refresh_all()

	UIManager.show_status("Продано: " + GameManager.current_item.item_name)


func change_city():

	if GameManager.current_city == GameManager.north_city:
		GameManager.current_city = GameManager.south_city
	else:
		GameManager.current_city = GameManager.north_city

	UIManager.update_city()
