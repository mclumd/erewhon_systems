(setf (current-problem)
  (create-problem
    (name p906)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockG)
          (on blockG blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
))))