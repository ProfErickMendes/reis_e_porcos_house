extends Node2D

# Variável para controlar se o nível foi completado
var nivel_completado = false

# --- NOVAS VARIÁVEIS PARA CONTAR DIAMANTES ---
var total_diamantes = 0
var diamantes_coletados = 0
# ---------------------------------------------

@onready var area_chegada: Area2D = $Area_chegada
@onready var portas_animation: AnimatedSprite2D = $Area_chegada/portas_animation

func _ready():
    print("Level 1 iniciado!")
    
    # --- LÓGICA DE CONTAR E CONECTAR OS DIAMANTES ---
    
    # 1. Conta quantos nós estão no grupo "Diamantes"
    total_diamantes = get_tree().get_nodes_in_group("Diamantes").size()
    print("Total de diamantes no nível: ", total_diamantes)
    
    # 2. Se não houver diamantes, libera a porta imediatamente
    if total_diamantes == 0:
        nivel_completado = true
        print("Nenhum diamante no nível. Porta liberada.")
        return # Sai da função _ready

    # 3. Faz um loop por cada diamante e conecta seu sinal
    for diamante in get_tree().get_nodes_in_group("Diamantes"):
        # Conecta o sinal "diamante_coletado" (do Diamante.gd)
        # a uma nova função "_on_diamante_coletado" (aqui no Level.gd)
        diamante.diamante_coletado.connect(_on_diamante_coletado)
        
    # -------------------------------------------------
        
    # Conecta o sinal de quando algo entra na área de chegada
    area_chegada.body_entered.connect(_on_area_chegada_body_entered)

# --- NOVA FUNÇÃO PARA OUVIR O SINAL DO DIAMANTE ---
func _on_diamante_coletado():
    diamantes_coletados += 1
    print("Diamantes coletados: ", diamantes_coletados, " / ", total_diamantes)
    
    # Verifica se todos foram coletados
    if diamantes_coletados == total_diamantes:
        print("TODOS OS DIAMANTES COLETADOS! A porta está aberta.")
        nivel_completado = true
        # Você pode adicionar um som ou animação de "porta destrancada" aqui
# ----------------------------------------------------
    
# Função chamada quando um corpo entra na área de chegada 
func _on_area_chegada_body_entered(_body):
    # Esta função agora vai funcionar como esperado!
    if _body.name == "Player" and nivel_completado == true:
        
        print("Level 1 completado! Carregando Level 2...")
        portas_animation.play("abrindo")
        portas_animation.animation_finished
        
        # Aguarda 1 segundo antes de trocar de cena
        await get_tree().create_timer(4.0).timeout
        
        
        
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
