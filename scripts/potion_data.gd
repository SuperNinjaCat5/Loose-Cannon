extends Resource
class_name Potion_Data

@export var name: String = "potion-name"
@export  var mass: int = 1.0
@export  var sprite_path: String = "res://assets/bottles/bottle1.png"
@export  var liquid_color: Color = Color("Magenta")
@export var sprite_id: int = -1
const maxID = 6

@export var ingredients: Array[Ingredient] = []

func randomizeSprite():
	var dir = DirAccess.open("res://assets/bottles/sprites")
	if dir:
		var i = RandomNumberGenerator.new().randi_range(1,maxID)
		sprite_path = "res://assets/bottles/sprites/bottle" + str(i) + ".png"
		
		print("Picked: ",sprite_path)
		sprite_id = i
	else:
		print("no dir in randomizeSprite()")

func randomizeColor():
	liquid_color = Color(randf(),randf(),randf())

func findColor(): # SET MODIFERS FIRST!!!
	for i in ingredients:
		liquid_color = liquid_color.blend(i.color)
		
#func getBottleID() -> int: # CHANGE IF YOU USE MORE THAN 6 BOTTLES
	#for id in range(maxID):
		#if sprite_path.ends_with(str(id) + ".png"):
			#return id
	#return -1
			
	
