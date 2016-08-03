(setf (current-problem)
  (create-problem
    (name p181)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
))))