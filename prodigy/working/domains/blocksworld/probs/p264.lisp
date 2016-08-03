(setf (current-problem)
  (create-problem
    (name p264)
    (objects (blockA blockB blockC blockD blockE blockF blockG blockH object))
    (state
      (and
          (holding blockH)
          (clear blockC)
          (on blockC blockE)
          (on blockE blockF)
          (on-table blockF)
          (clear blockG)
          (on blockG blockD)
          (on blockD blockB)
          (on blockB blockA)
          (on-table blockA)
))
    (goal
      (and
          (clear blockH)
          (on blockH blockG)
          (on-table blockG)
          (clear blockD)
          (on blockD blockF)
          (on-table blockF)
))))