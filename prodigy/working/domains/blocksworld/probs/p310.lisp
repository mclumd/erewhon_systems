(setf (current-problem)
  (create-problem
    (name p310)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockA)
          (on blockA blockC)
          (on blockC blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockB)
          (on-table blockB)
))))