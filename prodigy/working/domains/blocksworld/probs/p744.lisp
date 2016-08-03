(setf (current-problem)
  (create-problem
    (name p744)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockG)
          (on-table blockG)
))))