extends Node2D

@export var current_item: ItemData
@export var north_city: CityData
@export var south_city: CityData


func _ready():
	GameManager.current_item = current_item
	GameManager.north_city = north_city
	GameManager.south_city = south_city

	GameManager.current_city = GameManager.north_city
	print(GameManager.current_city)
	GameManager.ui_manager.refresh_all()


func _on_button_plus_pressed():
	GameManager.money += 100
	GameManager.ui_manager.update_balance_label()


func _on_button_minus_pressed():
	if GameManager.money >= 100:
		GameManager.money -= 100

	GameManager.ui_manager.update_balance_label()


func _on_btn_buy_pressed():
	TradeManager.buy_item()


func _on_btn_sell_pressed():
	TradeManager.sell_item()


func _on_btn_change_city_pressed():
	TradeManager.change_city()
