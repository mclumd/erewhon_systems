(setf (current-problem)
  (create-problem
    (name p481)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockD)
          (on blockD blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockH)
          (on blockH blockG)
          (on-table blockG)
))))