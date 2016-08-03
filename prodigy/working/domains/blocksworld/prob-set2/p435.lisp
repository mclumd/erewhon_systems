(setf (current-problem)
  (create-problem
    (name p435)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (arm-empty)
          (clear blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))