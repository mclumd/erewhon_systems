(setf (current-problem)
  (create-problem
    (name p448)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
))))