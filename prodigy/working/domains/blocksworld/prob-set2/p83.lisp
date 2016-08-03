(setf (current-problem)
  (create-problem
    (name p83)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockF)
          (on-table blockF)
))))