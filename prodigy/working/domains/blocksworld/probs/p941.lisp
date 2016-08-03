(setf (current-problem)
  (create-problem
    (name p941)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on blockA blockF)
          (on-table blockF)
))))