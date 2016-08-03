;; Time-stamp: <Mon Jan 13 17:19:05 EST 1997 ferguson>

(when (not (find-package :display-kb))
  (load "display-kb-def"))
(in-package :display-kb)

;; set up additions we need to handle the user

(defconstant +highlight-types+ '( :mentioned :congested :goal :cross :point
                                 :heavy-traffic :terminal-repair :bad-weather :ice-storm
				 :snow :heavy-snow :lake-effect-snow :rain :heavy-rain :freezing-rain :storms :heavy-storms :fog
                                 :floods :insurrection :secession :plague :zealots :ufo 
                                 :delegation :convention :constitution :junket :devastation :nuclear-accident
                                 :track-repair))

(defparameter *color-list* '(lightblue pink green yellow white turquoise palegreen orange)
  "Colors the user might name. Need 2x as many as there are engines.")

(defparameter *score-colors* '(gold gold gold gold gold gold)
  "Additional colors only used by scoring. Need at least as many as there are engines.")

(defun type-for-highlight (highlight-level)
  (case highlight-level
    (:mentioned
     '(:color hack::white :type hack::rectangle))
    (:congested
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:heavy-traffic
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:ice-storm
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:snow
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:heavy-snow
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:lake-effect-snow
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:rain
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:heavy-rain
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:freezing-rain
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:storms
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:heavy-storms
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:fog
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:terminal-repair
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:bad-weather
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:floods
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:insurrection
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:secession
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:plague
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:zealots
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:ufo
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:delegation
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:convention
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:constitution
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:junket
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:devastation
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:nuclear-accident
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:track-repair
     '((:color hack::red :type hack::object)
       (:color hack::white :type hack::object :flash 5)))
    (:cross
     '(:color hack::violetred :type hack::object :flash t))
    (:point
     '(:color hack::orange :type hack::object :flash 10))
    (:goal
     '((:color hack::yellow :type hack::circle)
       (:color hack::gold :type hack::object :flash 5)))))
