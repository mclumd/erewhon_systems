(setf (current-problem)
  (create-problem
    (name p337)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
          (clear blockH)
          (on blockH blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on-table blockH)
))))