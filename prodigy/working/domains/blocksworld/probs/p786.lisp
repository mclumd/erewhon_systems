(setf (current-problem)
  (create-problem
    (name p786)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockB)
          (on blockB blockC)
          (on blockC blockE)
          (on-table blockE)
))))