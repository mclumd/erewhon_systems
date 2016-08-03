(setf (current-problem)
  (create-problem
    (name p89)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on-table blockH)
          (clear blockF)
          (on-table blockF)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
))))