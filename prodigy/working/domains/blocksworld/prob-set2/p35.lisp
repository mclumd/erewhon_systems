(setf (current-problem)
  (create-problem
    (name p35)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockF)
          (clear blockG)
          (on blockG blockH)
          (on-table blockH)
          (clear blockE)
          (on blockE blockD)
          (on-table blockD)
          (clear blockB)
          (on blockB blockA)
          (on blockA blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on blockC blockB)
          (on blockB blockG)
          (on-table blockG)
))))