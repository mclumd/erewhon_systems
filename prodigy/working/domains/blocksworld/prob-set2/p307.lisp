(setf (current-problem)
  (create-problem
    (name p307)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on blockB blockG)
          (on blockG blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))))