extends Node

const RAYCAST_RANGE = 300.0

const LAUGHING_SCORE_ADDED:int = 5

# Input control names
const INPUT_UP:String = "up"
const INPUT_DOWN:String = "down"
const INPUT_LEFT:String = "left"
const INPUT_RIGHT:String = "right"
const INPUT_POOP:String = "poop"

const WORLD_LAYER := 1
const PLAYER_LAYER := 2
const VILLAGEOIS_LAYER := 4
const FLIC_LAYER := 8
const VILLAGEOIS_BASE_LAYER := 16
const POOP_LAYER := 32
const LAUGH_LAYER := 64


# Groups names
const GROUP_WALK_ON_POOP:String = "walk_on_poop"


# MSG STATE
const MSG_REASON:String = "reason"

const PREVIOUS_DIRECTION: String = "previous_direction"

const PLAYER_LAST_POSITION: String = "player_laster_position"

const REACTION_LAUGHING := "laughing"
const REACTION_CHATTING1 := "chatting1"
const REACTION_CHATTING2 := "chatting2"
const REACTION_CHATTING3 := "chatting3"
const REACTION_ALERT := "alert"
const REACTION_SERMENTING := "sermenting"
const REACTION_LOOKING_AROUND := "looking_around"
