(setf (current-problem)
  (create-problem
    (name p268)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockH)
          (on blockH blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on blockD blockB)
          (on blockB blockC)
          (on blockC blockF)
          (on-table blockF)
))))