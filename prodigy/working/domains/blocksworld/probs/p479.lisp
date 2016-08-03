(setf (current-problem)
  (create-problem
    (name p479)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockA)
          (on-table blockA)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on-table blockD)
))))