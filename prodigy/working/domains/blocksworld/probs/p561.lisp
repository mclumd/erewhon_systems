(setf (current-problem)
  (create-problem
    (name p561)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockB)
          (on blockB blockF)
          (on-table blockF)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockE)
          (on-table blockE)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockE)
          (on blockE blockC)
          (on blockC blockD)
          (on blockD blockB)
          (on blockB blockF)
          (on-table blockF)
))))