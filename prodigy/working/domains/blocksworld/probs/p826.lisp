(setf (current-problem)
  (create-problem
    (name p826)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on-table blockE)
          (clear blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockF)
          (on blockF blockG)
          (on blockG blockH)
          (on-table blockH)
))))