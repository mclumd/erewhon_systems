(setf (current-problem)
  (create-problem
    (name p162)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on-table blockG)
))))