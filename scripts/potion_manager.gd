class_name Potion_Manager
extends Node

var held_potions: Array[Potion_Data] = []

signal held_potions_changed()

func create_potion(ingredients: Array[Ingredient]):
	var p = Potion_Data.new()
	p.ingredients = ingredients
	p.randomizeSprite()
	p.findColor()
	
	held_potions.append(p)
	held_potions_changed.emit()

func yoink_potion(index: int) -> Potion_Data: # WILL REMOVE POTION!!!
	if index > held_potions.size(): 
		printerr("Took an index higher than held")
		return Potion_Data.new()
	
	var potion = held_potions.get(index)
	held_potions.remove_at(index)
	held_potions_changed.emit()
	
	return potion

func remove_potion(index: int):
	if index > held_potions.size(): 
		printerr("Removed an index higher than held")
		return
	
	held_potions.remove_at(index)
	held_potions_changed.emit()
	
func get_potion(index: int) -> Potion_Data:
	if index > held_potions.size(): 
		printerr("Getted an index higher than held")
		return Potion_Data.new()
	return held_potions.get(index)
	
func numberof_potions() -> int:
	return held_potions.size()
	
