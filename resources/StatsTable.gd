extends Resource

const Stats = preload("res://resources/Stats.gd")
const CharactersType = preload("res://CharactersType.gd")

var data = {
	"player": Stats.new(100), 
	"mob": Stats.new(100),
#	CharactersType.Character: Stats.new(10)
}

func _init():
	print(data)

	
