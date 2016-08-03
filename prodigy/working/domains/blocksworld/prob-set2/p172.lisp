(setf (current-problem)
  (create-problem
    (name p172)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))