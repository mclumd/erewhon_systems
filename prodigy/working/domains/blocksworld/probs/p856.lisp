(setf (current-problem)
  (create-problem
    (name p856)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on blockF blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on-table blockF)
))))