extends Node

const RAYCAST_RANGE = 300.0

# Input control names
const INPUT_UP:String = "up"
const INPUT_DOWN:String = "down"
const INPUT_LEFT:String = "left"
const INPUT_RIGHT:String = "right"
const INPUT_POOP:String = "poop"

const WORLD_LAYER := 1
const PLAYER_LAYER := 2
const PNJ_LAYER := 4
const FLIC_LAYER := 8
const PNJ_BASE_LAYER := 16
const POOP_LAYER := 32
const LAUGH_LAYER := 64


# Groups names
const GROUP_WALK_ON_POOP:String = "walk_on_poop"


# MSG STATE
const MSG_REASON:String = "reason"

const PREVIOUS_DIRECTION: String = "previous_direction"
