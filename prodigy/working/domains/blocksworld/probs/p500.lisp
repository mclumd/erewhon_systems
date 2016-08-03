(setf (current-problem)
  (create-problem
    (name p500)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockD)
          (clear blockC)
          (on blockC blockF)
          (on blockF blockA)
          (on blockA blockE)
          (on blockE blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockA)
          (on blockA blockC)
          (on blockC blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockD)
          (on blockD blockF)
          (on blockF blockH)
          (on-table blockH)
))))