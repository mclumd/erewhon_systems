(setf (current-problem)
  (create-problem
    (name p116)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on-table blockA)
))))