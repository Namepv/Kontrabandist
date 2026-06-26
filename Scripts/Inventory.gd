extends Node

func get_total_cargo() -> int:
	var total := 0

	for amount in GameManager.inventory.values():
		total += amount

	return total


func has_space(amount: int = 1) -> bool:
	return get_total_cargo() + amount <= GameManager.cargo_capacity


func add_item(item_name: String, amount: int = 1):

	if !GameManager.inventory.has(item_name):
		GameManager.inventory[item_name] = 0

	GameManager.inventory[item_name] += amount


func remove_item(item_name: String, amount: int = 1):

	if !GameManager.inventory.has(item_name):
		return

	GameManager.inventory[item_name] -= amount

	if GameManager.inventory[item_name] <= 0:
		GameManager.inventory.erase(item_name)


func clear():
	GameManager.inventory.clear()
