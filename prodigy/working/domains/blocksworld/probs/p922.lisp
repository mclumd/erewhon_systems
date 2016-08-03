(setf (current-problem)
  (create-problem
    (name p922)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on-table blockH)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
))))