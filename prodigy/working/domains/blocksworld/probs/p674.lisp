(setf (current-problem)
  (create-problem
    (name p674)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockC)
          (on-table blockC)
          (clear blockH)
          (on blockH blockE)
          (on blockE blockA)
          (on blockA blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockF)
          (on-table blockF)
))
    (goal
      (and
          (clear blockB)
          (on blockB blockE)
          (on blockE blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))))