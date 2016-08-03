(setf (current-problem)
  (create-problem
    (name p525)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))