(setf (current-problem)
  (create-problem
    (name p197)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockF)
          (on blockF blockC)
          (on-table blockC)
))))