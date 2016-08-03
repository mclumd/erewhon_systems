(setf (current-problem)
  (create-problem
    (name p59)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on-table blockB)
))))