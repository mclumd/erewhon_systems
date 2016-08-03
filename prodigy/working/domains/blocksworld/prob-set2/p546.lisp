(setf (current-problem)
  (create-problem
    (name p546)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockB)
          (on blockB blockG)
          (on-table blockG)
          (clear blockH)
          (on blockH blockA)
          (on blockA blockE)
          (on-table blockE)
          (clear blockF)
          (on blockF blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockC)
          (on blockC blockA)
          (on blockA blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on-table blockG)
))))