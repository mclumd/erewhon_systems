(setf (current-problem)
  (create-problem
    (name p145)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockD)
          (on-table blockD)
          (clear blockF)
          (on blockF blockH)
          (on-table blockH)
          (clear blockG)
          (on blockG blockB)
          (on-table blockB)
          (clear blockE)
          (on blockE blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockG)
          (on blockG blockF)
          (on-table blockF)
))))