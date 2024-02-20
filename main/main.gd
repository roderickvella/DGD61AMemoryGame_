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
	#connect the 'card_flipped' signal from each card to a handler function
	for card in grid.get_children():
		card.card_flipped.connect(_on_card_flipped)

func _on_card_flipped(card)	:
	if not can_flip: #if flipping is not allowed, return immediately
		return	
	card.flip_card()
	flipped_cards.append(card) #add the flipped card to the list
	
	if(flipped_cards.size() == 2): #if two cards are flipped check for a match
		can_flip =false
		check_match()
		
func check_match():
	#this delay is done so that the user can see the flipped cards before
	#unflipping again
	await get_tree().create_timer(0.2).timeout #wait for 0.2 seconds 
	
	if(flipped_cards[0].card_type == flipped_cards[1].card_type):
		print_debug("we've got a match")
		match_count +=1 
		flipped_cards[0].is_clickable = false
		flipped_cards[1].is_clickable =false
		
		if(check_win()):
			label.text = "You Won!"
		
	else:
		print("no match between cards")	
		flipped_cards[0].flip_card()
		flipped_cards[1].flip_card()
		flipped_cards[0].is_clickable =true
		flipped_cards[1].is_clickable =true
	
	flipped_cards.clear() #clear the list of flipped cards (so that player
	#can continue playing)
	can_flip =true #user is allowed to continue playing the game
	
		
func check_win():
	#return true if all pairs are matched	
	return (match_count == card_scenes_list.size()/2)
	
	
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
