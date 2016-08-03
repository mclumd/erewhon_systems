(setf (current-problem)
  (create-problem
    (name p516)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockG)
          (on blockG blockH)
          (on blockH blockF)
          (on-table blockF)
))))