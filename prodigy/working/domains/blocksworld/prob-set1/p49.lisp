(setf (current-problem)
  (create-problem
    (name p49)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockF)
          (on-table blockF)
))))