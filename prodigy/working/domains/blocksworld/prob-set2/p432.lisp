(setf (current-problem)
  (create-problem
    (name p432)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockE)
          (on-table blockE)
))))