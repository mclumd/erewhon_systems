(setf (current-problem)
  (create-problem
    (name p20)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on-table blockB)
))))