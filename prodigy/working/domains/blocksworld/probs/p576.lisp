(setf (current-problem)
  (create-problem
    (name p576)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockB)
          (on blockB blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on-table blockE)
          (clear blockD)
          (on blockD blockA)
          (on blockA blockB)
          (on blockB blockH)
          (on blockH blockF)
          (on blockF blockG)
          (on-table blockG)
))))