(setf (current-problem)
  (create-problem
    (name p962)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockG)
          (on-table blockG)
          (clear blockA)
          (on-table blockA)
          (clear blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockB)
          (on-table blockB)
))))