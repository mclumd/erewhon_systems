(setf (current-problem)
  (create-problem
    (name p409)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on-table blockH)
))))