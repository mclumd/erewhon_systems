(setf (current-problem)
  (create-problem
    (name p37)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))