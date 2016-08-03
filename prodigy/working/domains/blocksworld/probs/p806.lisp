(setf (current-problem)
  (create-problem
    (name p806)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on-table blockG)
))))