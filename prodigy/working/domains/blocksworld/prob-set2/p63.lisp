(setf (current-problem)
  (create-problem
    (name p63)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))