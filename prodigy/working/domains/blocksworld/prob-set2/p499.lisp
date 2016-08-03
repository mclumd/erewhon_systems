(setf (current-problem)
  (create-problem
    (name p499)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on-table blockD)
))))