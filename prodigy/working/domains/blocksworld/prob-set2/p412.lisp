(setf (current-problem)
  (create-problem
    (name p412)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockB)
          (on-table blockB)
))))