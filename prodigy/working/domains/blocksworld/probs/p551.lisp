(setf (current-problem)
  (create-problem
    (name p551)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockG)
          (clear blockF)
          (on blockF blockA)
          (on-table blockA)
          (clear blockB)
          (on blockB blockH)
          (on-table blockH)
          (clear blockD)
          (on blockD blockE)
          (on blockE blockC)
          (on-table blockC)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockE)
          (on blockE blockG)
          (on-table blockG)
))))