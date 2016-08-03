(setf (current-problem)
  (create-problem
    (name p661)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockF)
          (on-table blockF)
          (clear blockA)
          (on-table blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on-table blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockC)
          (on-table blockC)
          (clear blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockC)
          (on-table blockC)
))))