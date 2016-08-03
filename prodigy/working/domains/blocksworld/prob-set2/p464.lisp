(setf (current-problem)
  (create-problem
    (name p464)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))))