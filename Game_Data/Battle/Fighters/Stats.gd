extends Resource
class_name Stats

@export var HP = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_HP :String = "1.0"
@export var SP = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_SP :String = "1.0"
@export var ATK = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_ATK :String = "1.0"
@export var DEF = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_DEF :String = "1.0"
@export var INT = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_INT :String = "1.0"
## How many beats to wait before it's turn
@export var WAIT = 8
##How many beats it takes to lose a turn
@export var DRAIN = 16
##How many beats it takes to get back up after knockdown
@export var BREAK = 8
##How many beats this stalls hp and sp scrolling for
@export var STALL = 8
@export var EVA = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_EVA :String = "1.0"
@export var ACU = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_ACU :String = "1.0"
@export var CRT = 100
@export_enum(	"0.8",
	'0.9',
	'1.0',
	'1.1',
	'1.2',
	'1.3') var growth_CRT :String = "1.0"

