(setf (current-problem)
  (create-problem
    (name p501)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on blockB blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))