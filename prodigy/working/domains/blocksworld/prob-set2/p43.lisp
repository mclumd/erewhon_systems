(setf (current-problem)
  (create-problem
    (name p43)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockD)
          (on-table blockD)
          (clear blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on-table blockH)
))))