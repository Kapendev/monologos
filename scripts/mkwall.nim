# Creates a level script for godot that has walls.
# Reads a txt file and for every 1 in the file, a wall is created.

# File format:
  # widthxheight
  # 000
  # 010
  # 000

import os, strutils, strformat

const base = """extends Node

# event: art|music|scene|lines
# enemy: art|code|time

onready var game := $GameLevel

func _ready():
	game.win = Vector2(0, 0)
	game.player = Lib.new_actor(Vector2(0, 0))
"""

when isMainModule:
  let args = commandLineParams()
  if args.len() == 1:
    var file = args[0]
    var script = base
    var isFirst = true
    var x, y = 0
    for line in file.lines:
      if isFirst:
        let size = line.split('x')
        script.add(&"\tgame.grid = Lib.GameGrid.new({size[0]}, {size[1]})\n")
        isFirst = false
      else:
        x = 0
        for i, val in line:
          if val == '1':
            script.add(&"\tgame.grid.add_wall(Vector2({x}, {y}))\n")
          x += 1
        y += 1
    script.add("\tgame.grid.add_actor(game.player)\n\tgame.init()")
    writeFile(file.changeFileExt(".gd"), script)
  else:
    echo "mkwall file"
