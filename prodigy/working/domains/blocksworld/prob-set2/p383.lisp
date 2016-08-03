(setf (current-problem)
  (create-problem
    (name p383)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on-table blockC)
          (clear blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockG)
          (on-table blockG)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockD)
          (on blockD blockH)
          (on blockH blockE)
          (on blockE blockG)
          (on-table blockG)
))))