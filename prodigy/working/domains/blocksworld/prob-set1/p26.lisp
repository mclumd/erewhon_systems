(setf (current-problem)
  (create-problem
    (name p26)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on-table blockE)
))))