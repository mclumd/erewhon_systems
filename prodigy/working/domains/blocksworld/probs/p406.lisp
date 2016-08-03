(setf (current-problem)
  (create-problem
    (name p406)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))