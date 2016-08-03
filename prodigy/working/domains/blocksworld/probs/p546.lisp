(setf (current-problem)
  (create-problem
    (name p546)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on blockC blockB)
          (on blockB blockE)
          (on blockE blockA)
          (on blockA blockH)
          (on blockH blockG)
          (on blockG blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockF)
          (on blockF blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockA)
          (on blockA blockD)
          (on blockD blockE)
          (on-table blockE)
))))