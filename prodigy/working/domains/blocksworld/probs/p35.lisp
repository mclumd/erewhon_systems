(setf (current-problem)
  (create-problem
    (name p35)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockB)
          (clear blockE)
          (on blockE blockC)
          (on blockC blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockA)
          (on blockA blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockB)
          (on-table blockB)
))))