(setf (current-problem)
  (create-problem
    (name p324)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on-table blockG)
))))