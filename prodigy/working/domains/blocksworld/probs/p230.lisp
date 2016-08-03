(setf (current-problem)
  (create-problem
    (name p230)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockD)
          (on blockD blockH)
          (on blockH blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on blockB blockG)
          (on blockG blockE)
          (on blockE blockA)
          (on blockA blockF)
          (on blockF blockH)
          (on-table blockH)
))))