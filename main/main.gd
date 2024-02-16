extends Control

#List to store the card scenes
var card_scenes_list = []
#list to keep track of the flipped cards
var flipped_cards = []
#flag to control if a card can be flipped
var can_flip = true
var match_count = 0 #counter for the number of matched pairs

@onready var label = $Background/Label #label node reference
@onready var grid = $Background/CenterContainer/Grid #grid node reference


# Called when the node enters the scene tree for the first time.
func _ready():
	create_cards()
	
func create_cards():
	#load back texture
	var back_texture = preload("res://images/background.png")
	
	#load front textures
	var front_textures = [
		preload("res://images/cat.png"),
		preload("res://images/cow.png"), 
		preload("res://images/dog.png"), 
		preload("res://images/giraffe.png"), 
		preload("res://images/pig.png"), 
		preload("res://images/monkey.png") 
	]
	
	#load the card scene
	var card_scene = preload("res://card/card.tscn")
	
	for i in range(front_textures.size()): #loop for the number of animals
		for j in range(0,2): #loop 2 times (two animals of each)
			var card_instance = card_scene.instantiate() #instantiate the card
			card_instance.card_type = i #set card type
			card_instance.front_texture = front_textures[i] #set front texture
			card_instance.back_texture = back_texture #set back texture
			
			card_scenes_list.append(card_instance)#add card to the list
	
	card_scenes_list.shuffle() #shuffle for randomness
	
	#add each card in the list as a child to the grid
	for c_scene in card_scenes_list:
		grid.add_child(c_scene)
	
	
			
			
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
