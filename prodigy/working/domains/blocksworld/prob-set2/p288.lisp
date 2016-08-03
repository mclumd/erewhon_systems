(setf (current-problem)
  (create-problem
    (name p288)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockH)
          (on blockH blockC)
          (on blockC blockD)
          (on blockD blockG)
          (on blockG blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))