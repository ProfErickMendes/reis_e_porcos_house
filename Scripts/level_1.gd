extends Node2D

# Variável para controlar se o nível foi completado
var nivel_completado = false

# Referência à área de chegada/meta (Area2D)

@onready var area_chegada: Area2D = $Area_chegada
@onready var portas_animation: AnimatedSprite2D = $Area_chegada/portas_animation



func _ready():
    print("Level 1 iniciado!")
    # Conecta o sinal de quando algo entra na área de chegada
    area_chegada.body_entered.connect(_on_area_chegada_body_entered)
    
# Função chamada quando um corpo entra na área de chegada 
func _on_area_chegada_body_entered(_body):
    # Verifica se quem entrou foi o jogador
    
    if _body.name == "Player" and  nivel_completado == true:
        
        print("Level 1 completado! Carregando Level 2...")
        portas_animation.play("abrindo")
        # Aguarda 1 segundo antes de trocar de cena
        await get_tree().create_timer(3.0).timeout
        portas_animation.play("fechando")
        
        # Carrega o próximo nível
        carregar_proximo_nivel()
func carregar_proximo_nivel():
    get_tree().change_scene_to_file("res://Cenas/level_2.tscn")

# Função para voltar ao menu (pode ser chamada por um botão de pausa)
func voltar_ao_menu():
    get_tree().change_scene_to_file("res://Cenas/menu.tscn")

# Detecta tecla ESC para voltar ao menu
func _input(event):
    if event.is_action_pressed("ui_cancel"):  # ESC por padrão
        print("Voltando ao menu...")
        voltar_ao_menu()


func _on_diamante_body_entered(body: Node2D) -> void:
    
    if body.name == "Player":
        print("Coletado")
        nivel_completado = true
        
