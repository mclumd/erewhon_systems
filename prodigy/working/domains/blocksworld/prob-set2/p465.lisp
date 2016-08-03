(setf (current-problem)
  (create-problem
    (name p465)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on-table blockG)
))))