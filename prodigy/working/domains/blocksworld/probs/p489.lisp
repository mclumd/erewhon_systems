(setf (current-problem)
  (create-problem
    (name p489)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on blockB blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockH)
          (on-table blockH)
))))