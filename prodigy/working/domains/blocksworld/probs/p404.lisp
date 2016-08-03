(setf (current-problem)
  (create-problem
    (name p404)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockE)
          (clear blockC)
          (on blockC blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockB)
          (on-table blockB)
          (clear blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockD)
          (on blockD blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))