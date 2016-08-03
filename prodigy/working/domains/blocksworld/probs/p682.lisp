(setf (current-problem)
  (create-problem
    (name p682)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
))))