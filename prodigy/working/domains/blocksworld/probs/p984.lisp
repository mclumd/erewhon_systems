(setf (current-problem)
  (create-problem
    (name p984)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockH)
          (on blockH blockE)
          (on-table blockE)
          (clear blockG)
          (on blockG blockA)
          (on blockA blockC)
          (on-table blockC)
          (clear blockF)
          (on blockF blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockG)
          (on blockG blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockA)
          (on-table blockA)
))))