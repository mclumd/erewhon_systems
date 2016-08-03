(setf (current-problem)
  (create-problem
    (name p890)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on-table blockC)
))))