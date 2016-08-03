(setf (current-problem)
  (create-problem
    (name p916)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))))