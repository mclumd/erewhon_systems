(setf (current-problem)
  (create-problem
    (name p36)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockC)
          (on blockC blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on-table blockC)
))))