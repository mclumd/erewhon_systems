(setf (current-problem)
  (create-problem
    (name p167)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on-table blockB)
))))