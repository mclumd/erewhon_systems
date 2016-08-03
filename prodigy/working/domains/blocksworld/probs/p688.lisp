(setf (current-problem)
  (create-problem
    (name p688)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
))))