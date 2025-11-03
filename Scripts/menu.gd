extends Control

@onready var botao_play: Button = $VBoxContainer/botao_play
@onready var botao_sair: Button = $VBoxContainer/botao_sair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	botao_play.pressed.connect(_on_botao_play_pressed)
	botao_sair.pressed.connect(_on_botao_sair_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_botao_play_pressed() -> void:
	print("Jogo Iniciado")
	get_tree().change_scene_to_file("res://Cenas/level_1.tscn")


func _on_botao_sair_pressed() -> void:
	print("Jogo Finalizado")
	get_tree().quit()
