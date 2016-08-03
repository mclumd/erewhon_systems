(setf (current-problem)
  (create-problem
    (name p498)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))))