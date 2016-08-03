(setf (current-problem)
  (create-problem
    (name p718)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on blockG blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on-table blockB)
))))