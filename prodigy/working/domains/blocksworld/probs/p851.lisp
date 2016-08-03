(setf (current-problem)
  (create-problem
    (name p851)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))))