extends Node2D


const savedata_path := "user://savedata"
const min_vol := -80
const max_vol := -7


onready var counter := $Counter as Label
onready var audio_player := $AudioStreamPlayer as AudioStreamPlayer
onready var tween := $Tween as Tween


var count := 0 setget set_count


func set_count(val : int) -> void:
	counter.text = str(val)
	count = val


func load_count() -> void:
	var file := File.new()
	if not file.file_exists(savedata_path):
		set_count(0)
		return
	var err := file.open(savedata_path, File.READ)
	if err != OK:
		push_error("Failed to open " + savedata_path + " in read mode")
	else:
		set_count(file.get_32())
	file.close()


func audio_fade_in() -> void:
	audio_player.play()
	var res := tween.interpolate_property(audio_player, "volume_db", -80, -7, 0.5)
	if not res:
		push_error("Failed to configure tween of audio player")
		return
	res = tween.start()
	if not res:
		push_error("Failed to start tween of audio player")


func _ready() -> void:
	load_count()
	audio_fade_in()


func _on_DecrementButton_button_up():
	set_count(count - 1)


func _on_IncrementButton_button_up():
	set_count(count + 1)


func save_count() -> void:
	var file := File.new()
	var err := file.open(savedata_path, File.WRITE)
	if err != OK:
		push_error("Failed to open " + savedata_path + " in write mode")
	file.store_32(count)
	file.close()


func _on_QuitButton_button_up():
	save_count()
	get_tree().quit()


func _on_HSlider_value_changed(value):
	audio_player.volume_db = abs(max_vol - min_vol) * (value / 100) + min_vol
