(setf (current-problem)
  (create-problem
    (name p346)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on blockG blockA)
          (on blockA blockE)
          (on blockE blockB)
          (on blockB blockF)
          (on-table blockF)
))))