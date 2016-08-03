(setf (current-problem)
  (create-problem
    (name p100)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on-table blockA)
          (clear blockG)
          (on blockG blockH)
          (on blockH blockE)
          (on blockE blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))))