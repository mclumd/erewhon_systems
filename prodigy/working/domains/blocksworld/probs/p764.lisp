(setf (current-problem)
  (create-problem
    (name p764)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))