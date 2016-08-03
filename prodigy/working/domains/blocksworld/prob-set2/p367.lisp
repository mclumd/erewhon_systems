(setf (current-problem)
  (create-problem
    (name p367)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on-table blockD)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
))))