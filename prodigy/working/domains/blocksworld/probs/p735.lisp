(setf (current-problem)
  (create-problem
    (name p735)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockE)
          (on blockE blockH)
          (on blockH blockD)
          (on-table blockD)
          (clear blockG)
          (on blockG blockB)
          (on blockB blockF)
          (on blockF blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockD)
          (on blockD blockC)
          (on blockC blockG)
          (on-table blockG)
))))