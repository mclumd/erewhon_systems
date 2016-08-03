(setf (current-problem)
  (create-problem
    (name p129)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockD)
          (on-table blockD)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))))