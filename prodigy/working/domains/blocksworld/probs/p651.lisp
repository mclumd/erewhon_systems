(setf (current-problem)
  (create-problem
    (name p651)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockA)
          (on-table blockA)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockG)
          (on blockG blockC)
          (on blockC blockH)
          (on blockH blockB)
          (on-table blockB)
))))