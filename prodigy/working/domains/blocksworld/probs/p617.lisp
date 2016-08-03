(setf (current-problem)
  (create-problem
    (name p617)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on-table blockA)
          (clear blockF)
          (on-table blockF)
          (clear blockH)
          (on-table blockH)
          (clear blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockB)
          (on blockB blockE)
          (on-table blockE)
))))