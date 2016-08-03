(setf (current-problem)
  (create-problem
    (name p104)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on-table blockF)
))))