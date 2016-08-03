(setf (current-problem)
  (create-problem
    (name p324)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockA)
          (on-table blockA)
))))