(setf (current-problem)
  (create-problem
    (name p508)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockF)
          (on blockF blockB)
          (on blockB blockD)
          (on-table blockD)
          (clear blockA)
          (on blockA blockG)
          (on-table blockG)
          (clear blockE)
          (on blockE blockH)
          (on-table blockH)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockB)
          (on blockB blockF)
          (on blockF blockG)
          (on-table blockG)
          (clear blockA)
          (on blockA blockH)
          (on-table blockH)
))))