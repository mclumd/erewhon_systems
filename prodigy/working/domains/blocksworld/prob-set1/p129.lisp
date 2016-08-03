(setf (current-problem)
  (create-problem
    (name p129)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockA)
          (clear blockE)
          (on-table blockE)
          (clear blockH)
          (on blockH blockG)
          (on blockG blockD)
          (on blockD blockF)
          (on blockF blockC)
          (on blockC blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on blockF blockD)
          (on blockD blockG)
          (on blockG blockH)
          (on blockH blockA)
          (on blockA blockB)
          (on-table blockB)
))))