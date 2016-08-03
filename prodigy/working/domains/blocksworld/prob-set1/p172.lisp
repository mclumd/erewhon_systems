(setf (current-problem)
  (create-problem
    (name p172)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
))))