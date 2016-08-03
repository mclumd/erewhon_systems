(setf (current-problem)
  (create-problem
    (name p406)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))