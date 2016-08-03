(setf (current-problem)
  (create-problem
    (name p572)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))