extends Node

@export var BGM_bus:String = "BGM"
@export var SE_bus:String = "SE"

@onready var _music_player : AudioStreamPlayer = $MusicPlayer

var _fading:bool = false
var _tween:Tween = null

var BGM_bus_index = AudioServer.get_bus_index(BGM_bus)
var SE_bus_index = AudioServer.get_bus_index(SE_bus)

func play_music(stream:AudioStream, fade_in_time:float=0.25) -> void:
	return # en attendant d'avoir un bouton pour couper la musique
	# If the same music is already playing, don't do anything
	if _music_player.stream == stream:
		return

	if _music_player.playing and not _fading:
		await FadeOutMusic(0.5)
	elif _music_player.playing and _fading:
		_tween.kill()
		_fading = false
	# print("[AUDIO] START")
	_music_player.stream = stream
	_music_player.volume_db = AudioServer.get_bus_volume_db(BGM_bus_index) - 100
	_music_player.play()
	_tween = get_tree().create_tween()
	_fading = true
	_tween.tween_property(_music_player, "volume_db", AudioServer.get_bus_volume_db(BGM_bus_index), fade_in_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	# print("[AUDIO] Fading in music from %sdb to %sdb in %s seconds" % [_music_player.volume_db, AudioServer.get_bus_volume_db(BGM_bus_index), fade_in_time])
	await _tween.finished
	_fading = false


func play_sound_effect(stream:AudioStream) -> void:
	var sound_player:AudioStreamPlayer = AudioStreamPlayer.new()
	sound_player.stream = stream
	sound_player.bus = SE_bus
	sound_player.finished.connect(sound_player.queue_free)
	add_child(sound_player)
	sound_player.play()

func MusicIsPlaying() -> bool:
	return _music_player.playing

func StopMusic() -> void:
	_music_player.stop()
	

func FadeOutMusic(duration:float = 1.5) -> void:
	_tween = get_tree().create_tween()
	_fading = true
	_tween.tween_property(_music_player, "volume_db", -100, duration).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)

	await _tween.finished
	_music_player.stop()
	_fading = false
