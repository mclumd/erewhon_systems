(setf (current-problem)
  (create-problem
    (name p480)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on-table blockD)
))))