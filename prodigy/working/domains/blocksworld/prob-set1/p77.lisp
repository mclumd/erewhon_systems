(setf (current-problem)
  (create-problem
    (name p77)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on-table blockH)
          (clear blockB)
          (on-table blockB)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockA)
          (on-table blockA)
))))