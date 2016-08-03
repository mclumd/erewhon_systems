(setf (current-problem)
  (create-problem
    (name p159)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockH)
          (on blockH blockD)
          (on-table blockD)
))))