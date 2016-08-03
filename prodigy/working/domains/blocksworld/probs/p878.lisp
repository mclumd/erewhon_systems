(setf (current-problem)
  (create-problem
    (name p878)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on blockA blockB)
          (on blockB blockD)
          (on blockD blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
))))