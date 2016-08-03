# map.inc - useful setup for a floorplan bitmap
# Authors: Richard Vaughan
# $Id: map.inc,v 1.1 2011/02/21 19:56:29 schmill Exp $

define floorplan model
(
  # sombre, sensible, artistic
  color "gray30"

  # most maps will need a bounding box
  boundary 1

  gui_nose 0
  gui_grid 0
  gui_move 0
  gui_outline 0
  gripper_return 0
  fiducial_return 0
  ranger_return 0.5
)

define zone model
(
  color	"orange"
  size [ 4 4 0.02 ]

  gui_nose 0
  gui_grid 0
  gui_move 1
  gui_outline 0

  # insensible to collision and range sensors
  obstacle_return 0
  ranger_return -1  # transparent to range sensors
)