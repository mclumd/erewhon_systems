(setf (current-problem)
  (create-problem
    (name p438)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockC)
          (clear blockA)
          (on blockA blockG)
          (on blockG blockD)
          (on blockD blockH)
          (on blockH blockF)
          (on-table blockF)
          (clear blockE)
          (on blockE blockB)
          (on-table blockB)
))
    (goal
      (and
          (clear blockE)
          (on blockE blockH)
          (on blockH blockA)
          (on blockA blockD)
          (on blockD blockF)
          (on blockF blockG)
          (on blockG blockC)
          (on blockC blockB)
          (on-table blockB)
))))