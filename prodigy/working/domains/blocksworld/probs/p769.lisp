(setf (current-problem)
  (create-problem
    (name p769)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on-table blockB)
))))