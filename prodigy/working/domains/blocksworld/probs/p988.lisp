(setf (current-problem)
  (create-problem
    (name p988)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))))