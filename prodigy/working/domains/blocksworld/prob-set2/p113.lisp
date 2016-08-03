(setf (current-problem)
  (create-problem
    (name p113)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on blockF blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on-table blockH)
))))