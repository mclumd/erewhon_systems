(setf (current-problem)
  (create-problem
    (name p487)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on-table blockG)
          (clear blockB)
          (on blockB blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockF)
          (on blockF blockA)
          (on-table blockA)
))))