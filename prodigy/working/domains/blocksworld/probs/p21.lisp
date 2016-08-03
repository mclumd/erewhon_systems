(setf (current-problem)
  (create-problem
    (name p21)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))