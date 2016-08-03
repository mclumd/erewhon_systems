(setf (current-problem)
  (create-problem
    (name p289)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockA)
          (on blockA blockF)
          (on blockF blockD)
          (on blockD blockE)
          (on-table blockE)
))))