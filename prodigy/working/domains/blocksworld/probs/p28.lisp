(setf (current-problem)
  (create-problem
    (name p28)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockG)
          (on-table blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
))))