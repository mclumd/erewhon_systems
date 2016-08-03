(setf (current-problem)
      (create-problem
       (name parts3)
       (objects
        (object-is milling-machine1 MILLING-MACHINE)
	(object-is lathe1 LATHE)
	(object-is circular-saw1 CIRCULAR-SAW)
	(object-is friction-saw1 FRICTION-SAW)
	(object-is band-saw1 BAND-SAW)
	(object-is grinder1 GRINDER)
	(object-is saw-attachment1 SAW-BAND)
	(object-is rough-toolbit1 ROUGH-TOOLBIT)
	(object-is finish-toolbit1 FINISH-TOOLBIT)
	(object-is soft-grinding-wheel1 GRINDING-WHEEL)
	(object-is hard-grinding-wheel1 GRINDING-WHEEL)
	(object-is abrasive-cloth1 ABRASIVE-CLOTH)
        (object-is vise1 VISE)
	(object-is v-block1 V-BLOCK)
	(object-is 4-jaw-chuck1 4-JAW-CHUCK)
	(object-is magnetic-chuck1 MAGNETIC-CHUCK)
	(object-is milling-cutter1 PLAIN-MILL)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(objects-are part1 PART))
       (state
	(and 
	 (always-true)
	 (material-of-abrasive-cloth abrasive-cloth1 EMERY)
	 (hardness-of-wheel hard-grinding-wheel1 HARD)
	 (grit-of-wheel hard-grinding-wheel1 COARSE-GRIT)
	 (hardness-of-wheel soft-grinding-wheel1 SOFT)
	 (grit-of-wheel soft-grinding-wheel1 COARSE-GRIT)	 
	 (material-of part1 BRASS)
	 (alloy-of part1 non-ferrous)
	 (hardness-of part1 soft)
;	 (material-of part2 STEEL)
;	 (material-of part3 BRASS)	 
	 (size-of part1 LENGTH 5)
	 (size-of part1 DIAMETER 3)
;	 (size-of part2 LENGTH 5)
;	 (size-of part2 DIAMETER 3)
;	 (size-of part3 LENGTH 5)
;	 (size-of part3 DIAMETER 3)

	 (surface-finish-side part1 side1 ROUGH-MILL)
;	 (surface-finish-side part2 side1 ROUGH-MILL)
;	 (surface-finish-side part3 side1 ROUGH-MILL)
	 ))
       (goal
	()
        (and (size-of part1 LENGTH 5)
             (size-of part1 DIAMETER 2.999)
;             (size-of part2 LENGTH 5)
;             (size-of part2 DIAMETER 2)
;             (size-of part3 LENGTH 5)
;             (size-of part3 DIAMETER 2.999)
             (surface-finish-quality-side part1 side1 GROUND)
;             (surface-finish-quality-side part2 side1 GROUND)
;             (surface-finish-quality-side part3 side1 GROUND)
	))))


#|
Solution:
  1. <add-any-cutting-fluid grinder1 soluble-oil>
  2. <put-holding-device-in-grinder grinder1 magnetic-chuck1>
  3. <put-on-machine-table grinder1 part3>
  4. <clean part3>
  5. <hold-with-magnetic-chuck grinder1 magnetic-chuck1 part3 side1>
  6. <put-wheel-in-grinder grinder1 grinding-wheel1>
  7. <rough-grind-with-hard-wheel grinder1 part3 grinding-wheel1 magnetic-chuck1 side1 diameter 2.998>
  8. <add-any-cutting-fluid grinder1 soluble-oil>
  9. <release-from-holding-device grinder1 magnetic-chuck1 part3 side1>
  10. <remove-from-machine-table grinder1 part3>
  11. <put-on-machine-table grinder1 part2>
  12. <clean part2>
  13. <hold-with-magnetic-chuck grinder1 magnetic-chuck1 part2 side1>
  14. <rough-grind-with-hard-wheel grinder1 part2 grinding-wheel1 magnetic-chuck1 side1 diameter 2>
  15. <add-any-cutting-fluid grinder1 soluble-oil>
  16. <release-from-holding-device grinder1 magnetic-chuck1 part2 side1>
  17. <remove-from-machine-table grinder1 part2>
  18. <put-on-machine-table grinder1 part1>
  19. <clean part1>
  20. <hold-with-magnetic-chuck grinder1 magnetic-chuck1 part1 side1>
  21. <rough-grind-with-hard-wheel grinder1 part1 grinding-wheel1 magnetic-chuck1 side1 diameter 2.998>

|#