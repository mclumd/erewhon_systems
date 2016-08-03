(setf (current-problem)
  (create-problem
    (name p187)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on-table blockH)
))))