(setf (current-problem)
  (create-problem
    (name p698)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))