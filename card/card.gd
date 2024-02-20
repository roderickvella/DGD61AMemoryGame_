extends TextureButton

var card_type :int #Type of card (used to match pairs)
var front_texture: Texture #texture for the front side
var back_texture: Texture #texture for the back side
var is_flipped = false #flag to check if the card is flipped
var is_clickable =true #flag to control if the card can be clicked

signal card_flipped #signal emitted when teh card is flipped

# Called when the node enters the scene tree for the first time.
func _ready():	
	render_card()

func render_card():
	if(is_flipped):		
		texture_normal=front_texture #show front texture if flipped
	else:
		texture_normal=back_texture	

func flip_card():
	is_flipped = !is_flipped #toggle the flipped state
	is_clickable = !is_clickable #toggle the clickable state
	render_card()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():	
	print_debug("broadcast signal to interested parties")
	if(is_clickable):
		emit_signal("card_flipped",self) #emit the signal indicating that this card
		#has been flipped
	
	
