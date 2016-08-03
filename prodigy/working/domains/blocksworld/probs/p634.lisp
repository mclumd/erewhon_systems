(setf (current-problem)
  (create-problem
    (name p634)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockB)
          (on blockB blockD)
          (on-table blockD)
))))