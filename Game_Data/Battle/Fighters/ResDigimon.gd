extends ResActor
class_name ResDigimon
@export var type = Attack.Type.Neutral
@export var stats:Stats
@export var level:int = 1
@export var starting_health:int = 100
@export var attacks:Array[Attack]
@export var sprite_normal:Texture2D
@export var sprite_hurt:Texture2D
@export var sprite_special:Texture2D
@export var sprite_attack:Texture2D
@export var sprite_magic:Texture2D
@export var sprite_special_magic:Texture2D
@export var sprite_special_attack:Texture2D
@export var sprite_win:Texture2D
