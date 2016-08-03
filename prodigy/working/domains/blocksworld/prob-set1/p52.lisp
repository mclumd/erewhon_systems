(setf (current-problem)
  (create-problem
    (name p52)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockG)
          (on-table blockG)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockC)
          (on blockC blockE)
          (on blockE blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))))