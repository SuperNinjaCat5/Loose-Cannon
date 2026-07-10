extends Resource
class_name Potion_Data

var name: String = "potion-name"
var mass: int = 1.0
var sprite_path: String = "res://assets/bottles/bottle1.png"
var liquid_color: Color = Color("Magenta")
const maxID = 6

var ingredients: Array[Ingredient] = []

func randomizeSprite():
	var dir = DirAccess.open("res://assets/bottles/sprites")
	if dir:
		var max_random_num = dir.get_files().size()
		var i = RandomNumberGenerator.new().randi_range(1,max_random_num)
		sprite_path = dir.get_files().get(i).path_join("res://assets/bottles/sprites")

func randomizeColor():
	liquid_color = Color(randf(),randf(),randf())

func findColor(): # SET MODIFERS FIRST!!!
	for i in ingredients:
		liquid_color = liquid_color.blend(i.color)
		
func getBottleID() -> int: # CHANGE IF YOU USE MORE THAN 6 BOTTLES
	for id in range(maxID):
		if sprite_path.ends_with(str(id) + ".png"):
			return id
	return -1
			
	
