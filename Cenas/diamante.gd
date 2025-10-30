extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal diamante_coletado
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
    


func _on_body_entered(body: Node2D) -> void:
     
    if body.is_in_group("Player"):
        print("Coletado")
        diamante_coletado.emit() 
        queue_free()
