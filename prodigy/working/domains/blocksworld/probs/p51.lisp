(setf (current-problem)
  (create-problem
    (name p51)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))