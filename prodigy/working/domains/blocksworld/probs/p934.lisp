(setf (current-problem)
  (create-problem
    (name p934)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
))))