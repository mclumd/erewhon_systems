(setf (current-problem)
  (create-problem
    (name p587)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on-table blockE)
))))