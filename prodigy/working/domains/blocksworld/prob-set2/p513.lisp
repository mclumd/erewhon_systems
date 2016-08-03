(setf (current-problem)
  (create-problem
    (name p513)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockE)
          (on blockE blockB)
          (on-table blockB)
))))