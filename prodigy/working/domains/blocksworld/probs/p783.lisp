(setf (current-problem)
  (create-problem
    (name p783)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockE)
          (on-table blockE)
          (clear blockA)
          (on blockA blockH)
          (on blockH blockC)
          (on-table blockC)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockH)
          (on blockH blockB)
          (on blockB blockG)
          (on blockG blockF)
          (on-table blockF)
))))