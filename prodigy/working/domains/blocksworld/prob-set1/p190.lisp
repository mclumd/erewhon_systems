(setf (current-problem)
  (create-problem
    (name p190)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on-table blockD)
))))