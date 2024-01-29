extends Node2D

#@onready var progress_bar:ProgressBar = $ProgressBar
@export var progress_bar:ProgressBar = null
@export var progress_label:Label = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_value(value:float) -> void:
	progress_bar.set_value_no_signal(value)
	if progress_label:
		progress_label.text = "%.1f" % value
	
func set_max_value(value:float) -> void:
	progress_bar.max_value = value
	
func show_text_progress(_show:bool) -> void:
	if progress_label:
		progress_label.visible = _show
