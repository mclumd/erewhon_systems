(setf (current-problem)
  (create-problem
    (name p102)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockE)
          (on blockE blockA)
          (on blockA blockG)
          (on blockG blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockB)
          (on blockB blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))))