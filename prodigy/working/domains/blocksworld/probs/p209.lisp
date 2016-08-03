(setf (current-problem)
  (create-problem
    (name p209)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockF)
          (on blockF blockC)
          (on-table blockC)
))))