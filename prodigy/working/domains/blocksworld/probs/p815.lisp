(setf (current-problem)
  (create-problem
    (name p815)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockA)
          (on blockA blockF)
          (on blockF blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockE)
          (on blockE blockA)
          (on-table blockA)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockB)
          (on-table blockB)
))))