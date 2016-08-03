(setf (current-problem)
  (create-problem
    (name p106)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on blockH blockC)
          (on-table blockC)
))))