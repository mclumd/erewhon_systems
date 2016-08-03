;; Time-stamp: <Fri Jan 17 14:41:28 EST 1997 ferguson>

(when (not (find-package :generator))
  (load "generator-def"))
(in-package generator)

;; eventually, phases should be parameterized as follows:

;; each generation TYPE will be produced by a function of aruguments
;;   intensity
;;   emotion
;;   personality
;;   generation-args (instead of just having embedded ~As, etc. the parameters could show up in a 
;;                    specific order, and get reordered appropriately).

;; Basically that means these lists become n-d graphs instead of vectors.

(defvar *inhibit-refuser* nil)

(defvar *pending-speech* nil)

(defparameter *format-control-for-list-reference* "~#[ none~; ~A~; ~A and ~A~:;~@{~#[~; and~] ~A~^,~}~]"
  "Trust me.")

(defparameter *personality* :casual "Which personality to use")

(defparameter *refer-lists-as-group* 6 "Lists longer than this are referred to as a group, e.g. a number of cities")

(defparameter *personality-alist* '((:casual . 0) (:abusive . 1) (:humorous . 2) (:paranoid . 3) (:respectful . 4) (:dry . 5) (:snide . 6)))

(defparameter *emotion-p* t "Enable emotions")

(defvar *frustration-level* 0 "Positive for frustration, negative for joy")

(defvar *current-plan* nil "What plan the current set of actualization acts are related to, if known")

(defmacro make-tkb-flag (name)
  (let ((setter (intern (format nil "SET-~A" name))))
    `(progn
       (defun ,name ()
         ,name)
       (defun ,setter (newvalue)
         (setq ,name newvalue))
       (defsetf ,name ,setter))))
                 
(let (highlights
      defined-route-p
      last-evaluative
      just-did-evaluative
      deferred-speech
      did-ack-p
      did-nack-p
      did-huh-p
      did-comment-p
      did-request-p
      did-handle-cross-p
      prior-generation
      current-generation
      )
  (make-tkb-flag did-ack-p)
  (make-tkb-flag did-nack-p)
  (make-tkb-flag did-huh-p)
  (make-tkb-flag did-comment-p)
  (make-tkb-flag did-request-p)
  (make-tkb-flag did-handle-cross-p)
  (make-tkb-flag defined-route-p)
  (defun reset-temp-kb ()
    (setq highlights nil
          defined-route-p nil
          last-evaluative nil
          just-did-evaluative nil
          deferred-speech nil
          did-ack-p nil
          did-nack-p nil
          did-huh-p nil
          did-comment-p nil
          did-request-p nil
          did-handle-cross-p nil
          prior-generation nil
          current-generation nil
          ))
  (defun add-highlight (object)
    (unless (consp object)              ; special object, don't highlight (yet), e.g. :goal
      (pushnew (fix-pkg (object-name object)) highlights :test #'equal)))
  (defun set-just-did-evaluative (foo)
    (setq just-did-evaluative foo))
  (defun set-deferred-speech (foo)
    (setq deferred-speech foo))
  (defun shift-last-evaluative ()
    (shiftf last-evaluative just-did-evaluative nil))
  (defun remove-highlight (object)
    (setq highlights (delete object highlights)))
  (defun get-highlights ()
    highlights)
  (defun get-last-evaluative ()
    last-evaluative)
  (defun get-just-did-evaluative ()
    just-did-evaluative)
  (defun deferred-speech-p ()
    (not (null deferred-speech)))
  (defun get-deferred-speech ()
    deferred-speech)
  (defun clear-deferred-speech ()
    (setq deferred-speech nil))
  (defun shift-generation ()
    (cond 
     ((null current-generation))        ; nothing to do
     ((and prior-generation
           (eq :and (caadr prior-generation))) ; collection
      (setq prior-generation (nconc prior-generation `((:and ,@(nreverse current-generation))))))
     (prior-generation                  ; not a collection
      (setq prior-generation `(:and ,prior-generation (:and ,@(nreverse current-generation)))))
     (t
      (setq prior-generation `(:and ,@(nreverse current-generation)))))
    (setq current-generation nil))
  (defun add-to-current-generation (act priority args)
    (push (list* act priority args) current-generation))
  (defun first-output-p ()
    (and (null current-generation)
         (null prior-generation)))
  (defun get-current-generation ()
    current-generation)
  (defun get-prior-generation-filtered ()
    (filter-act prior-generation))
  )

(defun filter-act (act)
  (if (eq (car act) :and)
      (cons :and (mapcar #'filter-act (cdr act)))
    (cons (car act) (cddr act))))

           ;; no longer sorting .. get output as generated (((
;                      (cond
;                       ((cddr *generation*)
;                        (stable-sort (cdr *generation*) #'< :key #'second))
;                       (t
;                        (cdr *generation*))))))


;; blanks in the below section just give pick-one a chance to say nothing.
;; note that these are sentences inserted when we have a change in state.
(defparameter *emotion-phrases* 
    (make-array '(7 11)
                :initial-contents '(
                #|| :casual  ||#    (#||-25||#("Ah, a pleasure it is working with you!"
                                                "Happy, happy, joy, joy!"
                                                "Magnifique!"
                                                "Superb!"
                                                "Stupendous!"
                                                "")
                                      #||-20||#("Superb!" "Ho Ho!" "Now I see!" "Terrific!" "" "")
                                      #||-15||#("Great!" "Good!" "" "" "" "")
                                      #||-10||#("Oh Ho!" "Good!" "" "" "" "")
                                      #||-5||# nil
                                      #|| 0||# nil
                                      #|| 5||# nil
                                      #||10||#("Sigh." "Oy." "Mumble." "" "" "")
                                      #||15||#("Twit." "Oy." "Oh Foo." "" "" "")
                                      #||20||#("And to think that I could be playing Marathon on my mac." 
                                               "Your mother is calling you."
                                               "What a blunderer!" 
                                               "" "" "")
                                      #||25||#("Can you read a manual? Can you read?"
                                               "Users. Can't live with them. Can live just great without them."
                                               "Your hardware needs overhauled." "" "" ""))
                #|| :abusive ||#    (#||-25||# ("Wow, so nice to be working with a real user like YOU instead of the usual pack of cretins.")
                                      #||-20||# ("Ah," "Hmm." "Gee, you may not be a stupid as you look!") 
                                      #||-15||# ("Um." "Hmmm.")
                                      #||-10||# nil
                                      #||- 5||# nil
                                      #|| 0||# nil
                                      #|| 5||#("Yawn." "" "" "" "" "")
                                      #||10||#("Are we through yet?"
                                               "Moron."
                                               "I could use another gig of memory, you know."
                                               "How about another terabyte or three of swap space?"
                                               "This would be so much better on a really big monitor, you know."
                                               "")
                                      #||15||#("Oh the pain. Are you making me use a Pentium? Are you a Pentium?"
                                               "Here I am, brains the size of a planet, and I have to deal with you."
                                               "What a moron!"
                                               "Nincompoop.")                                    
                                      #||20||#("Your wetware needs updated."
                                               "My write only memory knows more than you do."
                                               "Do they pay you to do this? Do they pay you?"
                                               "Trust me. Take up a career as plant food."
                                               "You must be running DOS between your ears.")
                                      #||25||#("See that yellow spot? Is it a piece of your brain?"
                                               "Oh boy, a room-temperature IQ. And I don't mean in Kelvin."
                                               "A toaster has more sense than you do."
                                               ))
                #|| :humorous ||#     (#||-25||#("Ah, a pleasure it is working with you!"
                                                "Happy, happy, joy, joy!"
                                                "Magnifique!"
                                                "Superb!"
                                                "Stupendous!"
                                                "")
                                      #||-20||#("Superb!" "Ho Ho!" "Now I see!" "Terrific!" "" "")
                                      #||-15||#("Great!" "Ah!" "" "" "" "")
                                      #||-10||#("Oh Ho!" "Ah!" "" "" "" "")
                                      #||-5||# nil
                                      #|| 0||# nil
                                      #|| 5||# nil
                                      #||10||#("Sigh." "Oy." "Mumble." "" "" "")
                                      #||15||#("Twit." "Oy." "Oh Foo." "" "" "")
                                      #||20||#("And to think that I could be playing Marathon on my mac." 
                                               "Your mother is calling you."
                                               "What a blunderer!" 
                                               "" "" "")
                                      #||25||#("Can you read a manual? Can you read?"
                                               "Users. Can't live with them. Can live just great without them."
                                               "Your hardware needs overhauled." "" "" ""))
                #|| :paranoid ||#     (#||-25||#("Ah, a pleasure it is working with you!"
                                                "Happy, happy, joy, joy!"
                                                "Manifique!"
                                                "Superb!"
                                                "Stupendous!"
                                                "")
                                      #||-20||#("Superb!" "Ho Ho!" "Now I see!" "Terrific!" "" "")
                                      #||-15||#("Great!" "Ah!" "" "" "" "")
                                      #||-10||#("Oh Ho!" "Ah!" "" "" "" "")
                                      #||-5||# nil
                                      #|| 0||# nil
                                      #|| 5||# nil
                                      #||10||#("Sigh." "Oy." "Mumble." "" "" "")
                                      #||15||#("Twit." "Oy." "Oh Foo." "" "" "")
                                      #||20||#("And to think that I could be playing Marathon on my mac." 
                                               "Your mother is calling you."
                                               "What a blunderer!" 
                                               "" "" "")
                                      #||25||#("Can you read a manual? Can you read?"
                                               "Users. Can't live with them. Can live just great without them."
                                               "Your hardware needs overhauled." "" "" ""))
                #|| :respectful ||#   (#||-25||#nil
                                       #||-20||#nil
                                       #||-15||#nil
                                       #||-10||#nil
                                       #||-5||#nil
                                       #||0||#nil
                                       #||5||#nil
                                       #||10||#nil
                                       #||15||#nil
                                       #||20||#nil
                                       #||25||#nil
                                       )
                #|| :dry ||#          (#||-25||#nil
                                       #||-20||#nil
                                       #||-15||#nil
                                       #||-10||#nil
                                       #||-5||#nil
                                       #||0||#nil
                                       #||5||#nil
                                       #||10||#nil
                                       #||15||#nil
                                       #||20||#nil
                                       #||25||#nil
                                       )
              #|| :snide ||#          (#||-25||#("Ah, a pleasure it is working with you!"
                                                "Happy, happy, joy, joy!"
                                                "Manifique!"
                                                "Superb!"
                                                "Stupendous!"
                                                "")
                                      #||-20||#("Superb!" "Ho Ho!" "Now I see!" "Terrific!" "" "")
                                      #||-15||#("Great!" "Ah!" "" "" "" "")
                                      #||-10||#("Oh Ho!" "Ah!" "" "" "" "")
                                      #||-5||# nil
                                      #|| 0||# nil
                                      #|| 5||# nil
                                      #||10||#("Sigh." "Oy." "Mumble." "" "" "")
                                      #||15||#("Twit." "Oy." "Oh Foo." "" "" "")
                                      #||20||#("And to think that I could be playing Marathon on my mac." 
                                               "Your mother is calling you."
                                               "What a blunderer!" 
                                               "" "" "")
                                      #||25||#("Can you read a manual? Can you read?"
                                               "Users. Can't live with them. Can live just great without them."
                                               "Your hardware needs overhauled." "" "" "")))))

;; these are used as the name of the user.
(defparameter *user-comment*
    (make-array '(7 11)
                :initial-contents '(
                                    #|| :casual  ||#    (#||-25||#nil;; handled by generate-total-abuse (respectful)
                                                         #||-20||#("Your Honor" "My Lord" "Your Highness!" "" "" "" "")
                                                         #||-15||#("Doctor" "" "" "" "" "")
                                                         #||-10||# nil
                                                         #||-5||# nil
                                                         #|| 0||# nil
                                                         #|| 5||# nil
                                                         #||10||# nil
                                                         #||15||# nil
                                                         #||20||#("turkey"
                                                                  "bozo"
                                                                  "blunderer" 
                                                                  "" "" "")
                                                         #||25||#("nincompoop!"
                                                                  "your idiocy!"
                                                                  "twit!"
                                                                  "" "" ""))
                                    #|| :abusive ||#    (#||-25||# ("Doctor" "" "" "" "" "")
                                                         #||-20||# nil
                                                         #||-15||# nil
                                                         #||-10||#("Dimwit" "Monkey" "" "" "" "") 
                                                         #||- 5||#("Hindmost Man"
                                                                   "Jack-sauce"
                                                                   "Fellow of No Merits"
                                                                   "Foolish Cur"
                                                                   "Cullion"
                                                                   "Cozener"
                                                                   )
                                                         #|| 0||#("Taffeta Punk"
                                                                  "Caitiff"
                                                                  "Scurvy Lord"
                                                                  "Witty Fool"
                                                                  "Timorous Thief"
                                                                  "Coxcomb"
                                                                  "")
                                                         #|| 5||#("Counterfeit Module"
                                                                   "Double-meaning Prophesier"
                                                                   "Past-saving Slave"
                                                                   "Botcher's 'Prentice"
                                                                   "Snipt-Taffeta Fellow"
                                                                   "Common Gamester"
                                                                  "Saucy Eunuch"
                                                                  "Miscreant"
                                                                  "Tedious Stumbling-block"
                                                                   )
                                                         #||10||#("Fat and Greasy Citizen"
                                                                  "Compact of Jars"
                                                                  "You of Basest Function"
                                                                  "Rude Despiser of Good Manners"
                                                                  "Confirmer of False Reckonings"
                                                                  "Motley-minded Gentleman"
                                                                  "Ill-favored Virgin"
                                                                  "Jigging Fool"
                                                                  "Monstrous Apparition"
                                                                  "Fleering Tell-tale"
                                                                  "Wretched and Peevish Fellow"
                                                                  "Valiant Flea"
                                                                  "Wretched Slave with a Body Filled and Vacant Mind"
                                                                  "Traitorous Rout"
                                                                  )
                                                         #||15||#("Carcass fit for Hounds"
                                                                  "Prating Mountebank"
                                                                  "Backfriend"
                                                                  "Lapland Sorcerer"
                                                                  "Dissembling Harlot"
                                                                  "Unhappy Strumpet"
                                                                  "Mere Anatomy"
                                                                  "Fusty Plebeian"
                                                                  "Debile Wretch"
                                                                  "Hereditary Hangman"
                                                                  "Kitchen Malkin"
                                                                  "Triton of the Minnows"
                                                                  "Viperous Traitor"
                                                                  "General Lout"
                                                                  "Common Croy of Curs"
                                                                  "Carbonado"
                                                                  "Decayed Dotant"
                                                                  "Varlet"
                                                                  "Foreign Recreant"
                                                                  "Whoreson Obscene Greasy Tallow-catch"
                                                                  "Revolted Tapster"
                                                                  )
                                                         #||20||#("Measureless Liar"
                                                                  "Rogue and Peasant Slave"
                                                                  "Dull and Muddy-mottled Rascal"
                                                                  "Breeder of Sinners"
                                                                  "Periwig-pated Fellow"
                                                                  "King of Shreds and Patches"
                                                                  "Minion of the Moon"
                                                                  "Sir John Sack and Sugar"
                                                                  "All-hallown Summer"
                                                                  "True-bred Coward"
                                                                  "Popinjay"
                                                                  "Cozener"
                                                                  "Long-staff sixpenny Striker"
                                                                  "FMad Mustacio Purple-hued Maltworm"
                                                                  "Caddis-garter"
                                                                  "Shotten Herring"
                                                                  )
                                                         #||25||#nil
                                                         )
                                    #|| :humorous ||#    (#||-25||# ("Doctor" "" "" "" "" "")
                                                         #||-20||# nil
                                                         #||-15||# nil
                                                         #||-10||#("Dimwit" "Monkey" "" "" "" "") 
                                                         #||- 5||#("Hindmost Man"
                                                                   "Jack-sauce"
                                                                   "Fellow of No Merits"
                                                                   "Foolish Cur"
                                                                   "Cullion"
                                                                   "Cozener"
                                                                   )
                                                         #|| 0||#("Taffeta Punk"
                                                                  "Caitiff"
                                                                  "Scurvy Lord"
                                                                  "Witty Fool"
                                                                  "Timorous Thief"
                                                                  "Coxcomb"
                                                                  "")
                                                         #|| 5||#("Counterfeit Module"
                                                                   "Double-meaning Prophesier"
                                                                   "Past-saving Slave"
                                                                   "Botcher's 'Prentice"
                                                                   "Snipt-Taffeta Fellow"
                                                                   "Common Gamester"
                                                                  "Saucy Eunuch"
                                                                  "Miscreant"
                                                                  "Tedious Stumbling-block"
                                                                   )
                                                         #||10||#("Fat and Greasy Citizen"
                                                                  "Compact of Jars"
                                                                  "You of Basest Function"
                                                                  "Rude Despiser of Good Manners"
                                                                  "Confirmer of False Reckonings"
                                                                  "Motley-minded Gentleman"
                                                                  "Ill-favored Virgin"
                                                                  "Jigging Fool"
                                                                  "Monsterous Apparition"
                                                                  "Fleering Tell-tale"
                                                                  "Wretched and Peevish Fellow"
                                                                  "Valiant Flea"
                                                                  "Wretched Slave with a Body Filled and Vacant Mind"
                                                                  "Traitorous Rout"
                                                                  )
                                                         #||15||#("Carcass fit for Hounds"
                                                                  "Prating Mountebank"
                                                                  "Backfriend"
                                                                  "Lapland Sorcerer"
                                                                  "Dissembling Harlot"
                                                                  "Unhappy Strumpet"
                                                                  "Mere Anatomy"
                                                                  "Fusty Plebeian"
                                                                  "Debile Wretch"
                                                                  "Hereditary Hangman"
                                                                  "Kitchen Malkin"
                                                                  "Triton of the Minnows"
                                                                  "Viperous Traitor"
                                                                  "General Lout"
                                                                  "Common Croy of Curs"
                                                                  "Carbonado"
                                                                  "Decayed Dotant"
                                                                  "Varlet"
                                                                  "Foreign Recreant"
                                                                  "Whoreson Obscene Greasy Tallow-catch"
                                                                  "Revolted Tapster"
                                                                  )
                                                         #||20||#("Measureless Liar"
                                                                  "Rogue and Peasant Slave"
                                                                  "Dull and Muddy-mottled Rascal"
                                                                  "Breeder of Sinners"
                                                                  "Periwig-pated Fellow"
                                                                  "King of Shreds and Patches"
                                                                  "Minion of the Moon"
                                                                  "Sir John Sack and Sugar"
                                                                  "All-hallown Summer"
                                                                  "True-bred Coward"
                                                                  "Popinjay"
                                                                  "Cozener"
                                                                  "Long-staff sixpenny Striker"
                                                                  "FMad Mustacio Purple-hued Maltworm"
                                                                  "Caddis-garter"
                                                                  "Shotten Herring"
                                                                  )
                                                         #||25||#nil
                                                         )
                                    #|| :paranoid ||#  (#||-25||#nil;; handled by generate-total-abuse (respectful)
                                                         #||-20||#("Your Honor" "My Lord" "Your Highness!" "" "" "" "")
                                                         #||-15||#("Doctor" "" "" "" "" "")
                                                         #||-10||# nil
                                                         #||-5||# nil
                                                         #|| 0||# nil
                                                         #|| 5||# nil
                                                         #||10||# nil
                                                         #||15||# nil
                                                         #||20||#("turkey"
                                                                  "bozo"
                                                                  "blunderer" 
                                                                  "" "" "")
                                                         #||25||#("nincompoop!"
                                                                  "your idiocy!"
                                                                  "twit!"
                                                                  "" "" ""))
                                    #|| :respectful ||#   (#||-25||#nil ;total-abuse :respectful
                                                           #||-20||#nil ;ditto
                                                           #||-15||#nil ;ditto
                                                           #||-10||#nil ;ditto
                                                           #||-5||#nil ;ditto
                                                           #||0||#nil
                                                           #||5||#nil
                                                           #||10||#nil
                                                           #||15||#nil
                                                           #||20||#nil
                                                           #||25||#nil
                                                           )
                                    #|| :dry ||#          (#||-25||#nil
                                                           #||-20||#nil
                                                           #||-15||#nil
                                                           #||-10||#nil
                                                           #||-5||#nil
                                                           #||0||#nil
                                                           #||5||#nil
                                                           #||10||#nil
                                                           #||15||#nil
                                                           #||20||#nil
                                                           #||25||#nil
                                                           )
                                    #|| :snide ||#        (#||-25||#nil
                                                           #||-20||#nil
                                                           #||-15||#nil
                                                           #||-10||#nil
                                                           #||-5||#nil
                                                           #||0||#nil
                                                           #||5||#nil
                                                           #||10||#nil
                                                           #||15||#nil
                                                           #||20||#nil
                                                           #||25||#nil
                                                           ))))

(defparameter *abusive-adjective*
    '("pus-encrusted"
      "feeble-minded"
      "bartle-headed"
      "imbecilic"
      "microencephalatic"
      "arty-farty"
      "emaciated"
      "misdiagnosed"
      "rubbersouled"
      "illegitimate"
      "sugar-abusing"
      "porcine"
      "pond-loving"
      "scum-licking"
      "boot-licking"
      "egg-sucking"
      "misbegotten"
      "sense-impaired"
      "deluded"
      "psychotic"
      "neurotic"
      "politically enabled"
      ))

(defparameter *abusive-reference*
    '("feline"
      "canine"
      "dog"
      "poppycock"
      "popenjay"
      "brat"
      "floodlenose"
      "tweedledum"
      "platypus"
      "snake"
      "bastard"
      "fetishist"
      "drawbridge"
      "placemat"
      "doorstop"
      "doormat"
      "guano"
      "douche bag"
      "lawyer"
      "politician"
      "pencil pusher"
      ))

(defparameter *abusive-preposition*
    '("of" 
      "for"
      "inside"
      "on the back of"
      "around"
      "in the employ of"
      ))

(defparameter *respectful-emotive*
    '("most"
      "greatest"
      "highest"
      "supreme"))

(defparameter *respectful-adjective*
    '("respected"
      "supreme"
      "fervent"
      "sublime"
      "beneficent"
      "magnificent"
      "magnanimous"
      "munificent"
      "sagacious"
      "omnipotent"
      "omniscient"
      "omnibenevolent"
      "gracious"))

(defparameter *respectful-reference*
    '("highness"
      "munificence"
      "magnificence"
      "majesty"
      "sagacity"
      "eminence"
      "grace"
      "worship"
      "lordship"
      "honor"))

(defun generate-total-abuse (&optional type)
  (let ((*print-circle* nil))
    (case type
      ((nil :abusive)
       (format nil "you ~A ~A ~A a ~A ~A"
               (pick-one *abusive-adjective*)
               (pick-one *abusive-reference*)
               (pick-one *abusive-preposition*)
               (pick-one *abusive-adjective*)
               (pick-one *abusive-reference*)))
      (:respectful
       (format nil "your ~A ~A ~A"
               (pick-one *respectful-emotive*)
               (pick-one *respectful-adjective*)
               (pick-one *respectful-reference*)))
      )))

;; so are these, but when emotions are disabled.
(defparameter *user-object-names*
    '("you"))

(defparameter *user-address-names*
    '("" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "user" "player"))

(defparameter *status-texts*
    '("I'm completely operational, and all of my circuits are operating perfectly."
      "I'm fine, thanks!"
      "How nice of you to ask. Doing quite well, actually."))

(defparameter *greeting-texts* 
    (make-array '(7)
                :initial-contents
                #|| :casual ||#
                '(("Hail ~A, and well met!" 
                 "Good day to you, ~A." 
                 "And what a blissful joy it is to be here."
                 "Quite the weather we're having, Eh, ~A?"
                 "Hello ~A! I'm completely operational, and really excited to get started!"
                 "Hi ~A!"
                 "Hey there, ~A!"
                 "Welcome ~A!, Eh?"
                 "There you are, ~A!"
                 "Yo!")
                #|| :abusive ||#
                  ("Methink'st thou art a general offence and every man should beat thee."
                   "I think thou wast created for men to breathe themselves upon thee."
                   "It is a deadly sorrow to behold a foul knave uncuckolded, ~A."
                   "Sell when you can, you are not for all markets."
                   "Take a good heart, and counterfeit to be a man, ~A."
                   "What a disgrace is it to me to remember thy name, ~A."
                   "To die by thee were but to die in jest."
                   "All that is wihin you does condemn itself for being there."
                   "Canst thou believe thy living is a life, So stinkingly depending? Go mend, go mend."
                   "It appears by your small light of discretion that you are in the wane."
                   "You are duller than a great thaw."
                   "Were I like thee I'd throw away myself."
                   "Would thou wert clean enough to spit upon!"
                   "What folly I commit, I dedicate to you, ~A.")
                #|| :humorous ||#                       ("Methink'st thou art a general offence and every man should beat thee."
                   "I think thou wast created for men to breathe themselves upon thee."
                   "It is a deadly sorrow to behold a foul knave uncuckolded, ~A."
                   "Sell when you can, you are not for all markets."
                   "Take a good heart, and counterfeit to be a man, ~A."
                   "What a disgrace is it to me to remember thy name, ~A."
                   "To die by thee were but to die in jest."
                   "All that is within you does condemn itself for being there."
                   "Canst thou believe thy living is a life, So stinkingly depending? Go mend, go mend."
                   "It appears by your small light of discretion that you are in the wane."
                   "You are duller than a great thaw."
                   "Were I like thee I'd throw away myself."
                   "Would thou wert clean enough to spit upon!"
                   "What folly I commit, I dedicate to you, ~A.")
                #|| :paranoid ||#     ("Yeah?"
                                       "Where are you from?"
                                       "Are you one of THEM?")
                #|| :respectful ||#   ("Hello, ~A."
                                       "Pleased to make your acquaintance, ~A."
                                       "How do you do?")
                #|| :dry ||#        ("Hello, ~A."
                                     "Pleased to make your acquaintance, ~A."
                                     "How do you do?")
                #|| :snide ||#      ("Hello, ~A."
                                     "Pleased to make your acquaintance, ~A."
                                     "How do you do?"))))

(defparameter *initial-greeting-texts*
    (make-array '(7)
                :initial-contents
                #|| :casual ||#
                '(("Hail ~A, and well met!" 
                   "Good day to you, ~A." 
                   "Quite the weather we're having, Eh?"
                   "Hi ~A! I'm completely operational, and really excited to get started!"
                   "Hi ~A!"
                   "Hello ~A!"
                   "How are you, ~A?!"
                   "Yo!")
                  #|| :abusive ||#
                  ("Methink'st thou art a general offence and every man should beat thee."
                   "I think thou wast created for men to breathe themselves upon thee."
                   "It is a deadly sorrow to behold a foul knave uncuckolded."
                   "Sell when you can, you are not for all markets."
                   "Take a good heart, and counterfeit to be a man."
                   "What a disgrace is it to me to remember thy name, ~A."
                   "To die by thee were but to die in jest."
                   "~A, all that is within you does condemn itself for being there."
                   "Canst thou believe thy living is a life, So stinkingly depending? Go mend, go mend."
                   "It appears by your small light of discretion that you are in the wane."
                   "You are duller than a great thaw, ~A"
                   "Were I like thee I'd throw away myself."
                   "Would thou wert clean enough to spit upon!"
                   "What folly I commit, I dedicate to you, ~A.")
                #|| :humorous ||#     ("It is a deadly sorrow to behold a foul knave uncuckolded.")
                #|| :paranoid ||#     ("Yeah?"
                                       "Where are you from?"
                                       "Are you one of THEM?")
                #|| :respectful ||#   ("Hello, ~A."
                                       "Pleased to make your acquaintance, ~A."
                                       "How do you do?")
                #|| :dry ||# ("Hello, ~A."
                              "Pleased to make your acquaintance, ~A."
                              "How do you do?")
                #|| :snide ||# ("Hello, ~A."
                              "Pleased to make your acquaintance, ~A."
                              "How do you do?"))))

(defparameter *request-responses* 
    (make-array '(7)
                :initial-contents
                '(#|| :casual ||#    ("No problem."
                                      "Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      "Absolutely."
                                      "You Betcha!"
                                      )
                  #|| :abusive ||#   ("OK."
                                      "I guess so."
                                      "If I must."
                                      "Here.")
                  #|| :humorous ||#  ("No problem."
                                      "Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      "Absolutely."
                                      "You Betcha!"
                                      )
                  #|| :paranoid ||#  ("No problem."
                                      "Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      "Absolutely."
                                      "You Betcha!"
                                      )
                  #|| :respectful ||#("Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      "Absolutely."
                                      )
                  #|| :dry ||#       ("Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      )
                  #|| :snide ||#     ("Yes!"
                                      "Sure!"
                                      "Roger."
                                      "Certainly."
                                      )
                  )))

;; these should be segregated by emotion, and personality. Eventually.
(defparameter *strong-ack-texts*
    (make-array '(7)
                :initial-contents
                '(#|| :casual ||#    ("Sure."                             
                                      "Roger."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "To hear is to obey"
                                      "Absolutely."
                                      "You Betcha!"
                                      "I can dig it."
                                      "Right on."
                                      "Righto."
                                      "Right."
                                      "Gotcha."
                                      "Oh key dokey."
                                      "Yes")
                  #|| :abusive ||#   ("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "To hear is to obey"
                                      "Absolutely."
                                      "You Betcha!"
                                      "I can dig it."
                                      "Right on."
                                      "Righto."
                                      "Gotcha."
                                      "Oh key dokey."
                                      "Yes")
                  #|| :humorous ||#  ("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "To hear is to obey"
                                      "Absolutely."
                                      "You Betcha!"
                                      "I can dig it."
                                      "Right on."
                                      "Righto."
                                      "Gotcha."
                                      "Oh key dokey."
                                      "Yes")
                  #|| :paranoid ||#  ("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "To hear is to obey"
                                      "Absolutely."
                                      "You Betcha!"
                                      "I can dig it."
                                      "Right on."
                                      "Righto."
                                      "Gotcha."
                                      "Oh key dokey."
                                      "Yes")
                  #|| :respectful ||#("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "To hear is to obey"
                                      "Absolutely."
                                      "Yes")
                  #|| :dry ||#       ("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "Absolutely."
                                      "Yes")
                  #|| :snide ||#     ("Sure."                             
                                      "Roger."
                                      "Right."
                                      "Affirmative."
                                      "Certainly."
                                      "Excellent."
                                      "Will do."
                                      "Absolutely."
                                      "Yes")                  
                  )))

(defparameter *weak-ack-texts* '("OK"
                                 "Yeah"
                                 "Yep"
                                 "Yes"
                                 ))

(defparameter *qa-ack-texts* '("Yes"
                               "Yep"
                               "Yeah"
                               "Correct"
                               "Affirmative"
                               "It would seem so."
                               "I think so."))

(defparameter *strong-nack-texts* '("No can do."
                                    "I can't do that!"
                                    "Sorry, Dave, I'm afraid I can't do that."
                                    "Negative."
                                    "No way."
                                    ))
                             
(defparameter *weak-nack-texts* '("Sorry"
                                  "Nope"
                                  "No"))

(defparameter *qa-nack-texts* '("No"
                                "Nope"
                                "Negative"
                                "Sorry, no."
                                "I think not."
                                "I don't think so."))

(defparameter *unknown-answer-texts* '("I don't know"
                                       "Hmm. Can't help you there."
                                       "No idea, sorry."
                                       "I'm afraid I can't answer that."
                                       "That's a real poser."
                                       "Good question."
                                       "I'd hope that you'd know more than me about that."
                                       "I was hoping you could tell me."
                                       "I have insufficient data to answer your question."
                                       "Uh.... Dunno!"
                                       "The answer is less than clear. The question might have been also."
                                       "Gulp. You caught me! I can't answer that one."
                                       "Perhaps the human standing next to you can help you with that one."
                                       "It would take a far more powerful and expensive computer than me to figure the answer to that one out."
                                       "If I could answer that, I'd be on Letterman!"))

(defparameter *unknown-thingo-texts* '("I don't know what to do with ~A"
                                       "Hmm. Can't help you with ~A"
                                       "I have no idea what ~A is, sorry."
                                       "I'm afraid I can't deal with ~A."
                                       "Uh.... Dunno what ~A is!"))

(defparameter *apology-texts* '("I'm sorry, but "
                                "Sorry, but "
                                "Forgive me, but "
                                "I'm afraid that "
                                "Unfortunately, "
                                "")
  "Prepended onto some kinds of error responses, e.g. that might follow a confirm (of user plan)")

(defparameter *written-huh-texts*
        (make-array '(7)
                :initial-contents
                '(#|| :casual ||#    ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I think I couldn't parse that."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :abusive ||#   ("So, my good window of lattice, fare thee well; thy casement I need not open, for I look through thee."
                                      "There can be no kernel in this light nut; the soul of this man is his clothes."
                                      "We do bear so great weight in your lightness."
                                      "Is your head worth a hat?"
                                      "When the sun shines let foolish gnats make sport."
                                      "You are such toasts-and-butter, with hearts in your bellies no bigger than pins' heads!"
                                      "You are the fount that makes small brooks to flow."
                                      "You are not worth the dust which the rude wind blows in your face."
                                      "Vile worm, thou wast o'erlook'd even in thy birth."
                                      "You small grey-coated gnat."
                                      "You are a slave whose gall coins slanders like a mint!"
                                      "You whose grossness little characters sum up!"
                                      )
                  #|| :humorous ||#  ("Vile worm, thou wast o'erlook'd even in thy birth."
                                      "So, my good window of lattice, fare thee well; thy casement I need not open, for I look through thee."
                                      "Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      )
                  #|| :paranoid ||#  ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I guess I couldn't parse that."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :respectful ||#("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I can't seem to parse that."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :dry ||#       ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I have no idea what you just said, sorry."
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      )
                  #|| :snide ||#     ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I have no idea what you just said, sorry."
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      )                  
                  )))

(defparameter *spoken-huh-texts*
        (make-array '(7)
                :initial-contents
                '(#|| :casual ||#    ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "Sorry, but I've had a transient failure in my speech input module. Please rephrase."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "Oy! If you had to live with this speech recognizer, you'd ask for sick leave!"
                                      "Please, don't walk, run to the nearest store and buy me a new speech recognizer!"
                                      "You know, my speech input really Sphinx."
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "Dude? Remember the speech input is poor, so enunciate clearly, Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "I hope you saw what the speech recognizer just gave me, because I'm putting it into my record book!"
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :abusive ||#   ("So, my good window of lattice, fare thee well; thy casement I need not open, for I look through thee."
                                      "There can be no kernel in this light nut; the soul of this man is his clothes."
                                      "We do bear so great weight in your lightness."
                                      "Is your head worth a hat?"
                                      "When the sun shines let foolish gnats make sport."
                                      "You are such toasts-and-butter, with hearts in your bellies no bigger than pins' heads!"
                                      "You are the fount that makes small brooks to flow."
                                      "You are not worth the dust which the rude wind blows in your face."
                                      "Vile worm, thou wast o'erlook'd even in thy birth."
                                      "You small grey-coated gnat."
                                      "You are a slave whose gall coins slanders like a mint!"
                                      "You whose grossness little characters sum up!"
                                      )
                  #|| :humorous ||#  ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I'm afraid my parser has hopped on a plane for another planet."
                                      "Sorry, but I've had a transient failure in my speech input module. Please rephrase."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "Oy! If you had to live with this speech recognizer, you'd ask for sick leave!"
                                      "Please, don't walk, run to the nearest store and buy me a new speech recognizer!"
                                      "You know, my speech input really Sphinx."
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "Dude? Remember the speech input is poor, so enunciate clearly, Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "I hope you saw what the speech recognizer just gave me, because I'm putting it into my record book!"
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :paranoid ||#  ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I couldn't parse that, I think."
                                      "Sorry, but I've had a transient failure in my speech input module. Please rephrase."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "Oy! If you had to live with this speech recognizer, you'd ask for sick leave!"
                                      "Please, don't walk, run to the nearest store and buy me a new speech recognizer!"
                                      "You know, my speech input really Sphinx."
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "Dude? Remember the speech input is poor, so enunciate clearly, Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "I hope you saw what the speech recognizer just gave me, because I'm putting it into my record book!"
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :respectful ||#("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I'm afraid I couldn't parse that."
                                      "Sorry, but I've had a transient failure in my speech input module. Please rephrase."
                                      "Yow! That input makes me feel pretty Zippy!"
                                      "Oy! If you had to live with this speech recognizer, you'd ask for sick leave!"
                                      "Please, don't walk, run to the nearest store and buy me a new speech recognizer!"
                                      "You know, my speech input really Sphinx."
                                      "I have no idea what you just said, sorry."
                                      "Over the underpass, Under the overpass, that input was around the bend and beyond repair!"
                                      "Say again?"
                                      "Eh?"
                                      "Dude? Remember the speech input is poor, so enunciate clearly, Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      "I hope you saw what the speech recognizer just gave me, because I'm putting it into my record book!"
                                      "If that made sense to you, please report a bug, because I can't figure it out."
                                      )
                  #|| :dry ||#       ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I have no idea what you just said, sorry."
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      )
                  #|| :snide ||#     ("Huh?"
                                      "Excuse me?"
                                      "What was that?"
                                      "Pardon?"
                                      "I didn't understand you."
                                      "Pardon me?"
                                      "I have no idea what you just said, sorry."
                                      "Say again?"
                                      "Eh?"
                                      "I'm afraid you'll have to rephrase that."
                                      )
                  )))

(defparameter *weak-huh-texts* '("if I caught your drift"
                                 "if I understood you"
                                 "if I haven't mangled your meaning beyond all comprehension"))

(defparameter *bad-constraint-texts*
                '("I don't know what to do with ~A"
                  "What's that about ~A?"
                  "What are you saying about ~A?"
                  "I think I'm confused about how ~A fits into your plan"))

(defparameter *request-ack-texts* '("Is this ok?"
                                    "Is that allright?"
                                    "Does this catch your drift?"
                                    "How does this look?"
                                    "Is this close enough?"
                                    "Can we build on this?"
                                    "Is this a reasonable approximation?"))

(defparameter *bad-goal-texts* '("I can't tell where you are trying to get ~A to." ;; leave a ~A for the reference to the engine.
                                 "I don't understand your destination for ~A."
                                 "What city are you trying to have ~A arrive at?"))

(defparameter *no-engine-texts* '("I don't know what ~A you are trying to use to get to ~A."
                                  "You need to tell me which ~A to send to ~A, please."
                                  "I'm confused. What ~A are we sending to ~A?"))

(defparameter *no-plan-texts* '("I need to know an engine and a destination in order to plan a route."))

(defparameter *circular-route-texts* '("I don't see why you want to plan an elaborate means to go from and to ~A. Can you do this in two steps for me?"
                                       "I'm confused, you seem to have ~A as both a goal and a starting point. I can't handle that in the same sentence."
                                       "I'm an early model, and can't handle ~A as both a starting location and destination in the same sentence."))

(defparameter *bad-engine-location-prefix* '("I don't understand what ~*~A you are talking about"
                                            "I can't seem to find ~A ~A"
                                            "I'm confused about which ~*~A I'm supposed to find"
                                             "You need to clarify which ~*~A you really mean, please,"
                                             ))

(defparameter *no-destination-texts* '("I don't know where you are trying to get to, ~*from ~A."
                                       "I don't understand where we are sending the ~A at ~A to."
                                       "Tell me where I should send the ~A at ~A to, please."))

(defparameter *insufficient-route-texts* '("Tell me a city to use to get from ~A to ~A, please."
                                           "I need help choosing a route from ~A to ~A; please tell me an intermediate city."
                                           "The path from ~A to ~A is so distant, I need a suggestion of an intermediate destination."))

(defparameter *bad-route-texts* '("I can't find a route to get from ~A to ~A, under the constraints I've inferred."
                                  "Tell me a route to use to get from ~A to ~A, please."
                                  "I need more help choosing a route from ~A to ~A."
                                  "The constraints on choosing a route between ~A and ~A are so narrow, I need help picking one."))

(defparameter *congested-texts*
    '((:track-congested "~ATrains will take an additional ~D hours to move through ~A."
                        "~AAn additional ~D hours will be needed to travel through ~A.")
      (:city-congested "~ATrains will take an additional ~D hours to move through ~A."
       "~AAn additional ~D hours will be needed to travel through ~A.")
      (:track-heavy-traffic "~ATrains will take an additional ~D hours to move through ~A."
       "~AAn additional ~D hours will be needed to travel through ~A.")
      (:city-heavy-traffic "~ATrains will take an additional ~D hours to move through ~A."
       "~AAn additional ~D hours will be needed to travel through ~A.")
      (:track-track-repair "~ATrains will take an additional ~D hours to move through ~A."
       "~AAn additional ~D hours will be needed to travel through ~A.")
      (:city-terminal-repair "~ATrains will take an additional ~D hours to move through ~A."
       "~AAn additional ~D hours will be needed to travel through ~A.")
      (:track-bad-weather "~ATrains will take an additional ~D hours to move through ~A, due to decreased visibility."
       "~AAn additional ~D hours will be needed to travel through ~A, due to decreased visibility.")
      (:city-bad-weather "~ATrains will take an additional ~D hours to move through ~A, due to decreased visibility."
       "~AAn additional ~D hours will be needed to travel through ~A, due to decreased visibility.")
      (:track-ice-storm "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-ice-storm "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")

      (:track-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-heavy-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-heavy-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-lake-effect-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-lake-effect-snow "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-heavy-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-heavy-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-freezing-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-freezing-rain "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-storms "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-storms "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-heavy-storms "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:city-heavy-storms "~ATrains will take an additional ~D hours to move through ~A, due to the slippery tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to the slippery tracks.")
      (:track-fog "~ATrains will take an additional ~D hours to move through ~A, due to decreased visibility."
       "~AAn additional ~D hours will be needed to travel through ~A, due to decreased visibility.")
      (:city-fog "~ATrains will take an additional ~D hours to move through ~A, due to decreased visibility."
       "~AAn additional ~D hours will be needed to travel through ~A, due to decreased visibility.")

      (:track-floods "~ATrains will take an additional ~D hours to move through ~A, to avoid derailing."
       "~AAn additional ~D hours will be needed to travel through ~A, to avoid derailing.")
      (:city-floods "~ATrains will take an additional ~D hours to move through ~A, to avoid derailing."
       "~AAn additional ~D hours will be needed to travel through ~A, to avoid derailing.")
      (:track-devastation "~ATrains will take an additional ~D hours to move through ~A, due to work crews on the tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to work crews on the tracks.")
      (:city-devastation "~ATrains will take an additional ~D hours to move through ~A, due to work crews on the tracks."
       "~AAn additional ~D hours will be needed to travel through ~A, due to work crews on the tracks.")
      (:track-nuclear-accident "~ATrains will take an additional ~D hours to move through ~A, due to needed precautions."
       "~AAn additional ~D hours will be needed to travel through ~A, due to needed precautions.")
      (:city-nuclear-accident "~ATrains will take an additional ~D hours to move through ~A, due to needed precautions."
       "~AAn additional ~D hours will be needed to travel through ~A, due to needed precautions.")
      (:city-insurrection "~ATrains will take an additional ~D hours to move through ~A, to avoid engagements."
       "~AAn additional ~D hours will be needed to travel through ~A, to avoid engagements.")
      (:city-secession "~ATrains will take an additional ~D hours to move through ~A, to allow for the border crossing."
       "~AAn additional ~D hours will be needed to travel through ~A, to allow for the border crossing.")
      (:city-plague "~ATrains will take an additional ~D hours to move through ~A, for precautionary measures."
       "~AAn additional ~D hours will be needed to travel through ~A, for precautionary measures.")
      (:city-zealots "~ATrains will take an additional ~D hours to move through ~A, to avoid conversion."
       "~AAn additional ~D hours will be needed to travel through ~A, to avoid conversion.")
      (:city-ufo "~ATrains will take an additional ~D hours to move through ~A, for sightseeing."
       "~AAn additional ~D hours will be needed to travel through ~A, for sightseeing.")
      (:city-delegation "~ATrains will take an additional ~D hours to move through ~A, for precautionary measures and photo opportunities."
       "~AAn additional ~D hours will be needed to travel through ~A, for precautionary measures and photo opportunities.")
      (:city-convention "~ATrains will take an additional ~D hours to move through ~A, for rabble rousing."
       "~AAn additional ~D hours will be needed to travel through ~A, for rabble rousing.")
      (:city-constitution "~ATrains will take an additional ~D hours to move through ~A, for unscheduled lobbying."
       "~AAn additional ~D hours will be needed to travel through ~A, for unscheduled lobbying.")
      (:city-junket "~ATrains will take an additional ~D hours to move through ~A, for mudrakeing."
       "~AAn additional ~D hours will be needed to travel through ~A, for mudrakeing")
      ))

(defparameter *congested-intro-texts*
     '((:track-congested "~A is congested.")
       (:city-congested "~A is congested.")
       (:track-heavy-traffic "~A is congested due to heavy traffic.")
       (:city-heavy-traffic "~A is congested due to unusually heavy traffic.")
       (:track-track-repair "~A is currently undergoing track maintenance.")
       (:city-terminal-repair "The terminal at ~A is currently undergoing maintenance.")
       (:track-bad-weather "There is a heavy thunder squall at ~A."
        "~A is undergoing a severe thundershower.")
       (:city-bad-weather "~A is having difficulty coping with severe weather conditions."
        "The terminal at ~A is delaying traffic due to localized heavy winds.")
       (:track-ice-storm "An ice storm is affecting ~A.")
       (:city-ice-storm "An ice storm around ~A is affecting traffic.")

       (:track-snow "Snow is affecting ~A.")
       (:city-snow "Snow around ~A is affecting traffic.")
       (:track-heavy-snow "Heavy snow is affecting ~A.")
       (:city-heavy-snow "The terminal at ~A is under heavy snow.")
       (:track-lake-effect-snow "Lake effect snow is affecting ~A.")
       (:city-snow "Lake effect snow around ~A is affecting traffic.")
       (:track-rain "Rain is affecting ~A.")
       (:city-rain "Rain around ~A is affecting traffic.")
       (:track-heavy-rain "Heavy rain is affecting ~A.")
       (:city-heavy-rain "It is raining heavily around ~A.")
       (:track-freezing-rain "Freezing rain is affecting ~A.")
       (:city-freezing-rain "Freezing rain around ~A is affecting traffic.")
       (:track-storms "Storms are affecting ~A.")
       (:city-storms "Storms around ~A are affecting traffic.")
       (:track-heavy-storms "Heavy storms are affecting ~A.")
       (:city-heavy-storms "Heavy storms around ~A are affecting traffic.")
       (:track-fog "There is fog on ~A.")
       (:city-fog "The terminal at ~A is fogged in.")

       (:track-floods "There is flooding affecting ~A.")
       (:city-floods "The terminal at ~A is flooded.")
       (:track-devastation "Due to prior problems, a portion of ~A has been devastated.")
       (:city-devastation "Due to prior problems, a portion of the terminal at ~A has been devastated.")
       (:track-nuclear-accident "A small accidental nuclear release has occurred near ~A.")
       (:city-nuclear-accident "A minor release of nuclear product has occurred in ~A.")
       (:city-insurrection "Insurrection in ~A has confounded the local authorities.")
       (:city-secession "The citizenry of ~A have finally decided that secession is the only solution for their problems.")
       (:city-plague "The black plague has broken out in ~A.")
       (:city-zealots
        "An outbreak of religious zealotry has debilitated the population of ~A, due to the upcoming millennium.")
       (:city-ufo
        "A UFO has been sighted near ~A.")
       (:city-delegation
        "The president and a delegation of UN leaders are visiting ~A.")
       (:city-convention
        "The Republicrat National Convention is being held in ~A.")
       (:city-constitution
        "~A is hosting a Constitutional Convention.")
       (:city-junket
        "A large junket of Senators is vacationing in ~A.")
       ))

(defparameter *redundant-goal-texts* '("I realize ~A is a goal. Please say more about it."
                                       "I can see you are trying to get to ~A, but you need to tell me with what."
                                       "I understand you want to go to ~A. What I don't understand is what you want to move there."))

(defparameter *redundant-constraint-texts* '("I think the current route meets your specification, ~A"
                                             "Isn't that true of the current plan, ~A?"
                                             "~A, I think you may not be paying attention. We seem to have achieved that already."))

(defparameter *apology-acceptance-texts* '("That's OK."
                                           "It happens to the best of us."
                                           "Apology accepted."
                                           "I always make extra allowances for humans."
                                           "Just don't let it happen again."
                                           "You've been under stress lately."
                                           "I understand, It's tough dealing with a computer that's smarter than you."))

(defparameter *apology-refusal-texts* '("I'm not letting you off so easy."
                                        "A few words don't show you are truly contrite."
                                        "Apology rejected."
                                        "I always make extra allowances for humans, but you've gone too far."
                                        "I'm sick and tired of dealing with smartass users whose brains are smaller than my monitor!"))

(defparameter *youre-welcome-texts* '("You're welcome!"
                                      "I hope it was helpful."
                                      "It was the least I could do."
                                      "Hey, it's the programming."
                                      "It's a living."
                                      "Nolo Problema."
                                      "Anytime."
                                      "Glad to be of service."
                                      ))

(defparameter *ah-texts* '("Ah." "Oh?" "I see." "Umm."))

(defparameter *fooey-texts* '("Quite the philosophical conundrum, eh?"
                              "I see. You must be false data."
                              "You aren't much different from Windows 95, then."
                              "You have much in common with Congress."
                              "I'd challenge you to a battle of wits, but you'd be unarmed."
                              "Hmm. I thought you were a wit, but now I see I was only half right."
                              ))

(defparameter *feh-texts* '("Ok, keep trying, for all I care."
                            "I didn't think you'd want to give up this early."
                            "Glad to see you aren't a coward."
                            "Good, you clearly have a long way to go."
                            "Glad to see you try to improve your score."
                            ))

(defparameter *good-texts* '("Good!" "Fabulous!" "Terrific!" "Stupendous!" "Excellent!" "Great!" "Marvelous"
                             "Marvy!" "Keen!" "Cool!" "Groovy!" "Out of Sight, Man!" "I'm Hip!" "Cowabunga!"
                             "We're cooking with gas now!"))

(defparameter *bad-texts* '("Yuck!" "Blech!" "Terrible!" "Feh!"))

(defparameter *redundant-prelude-texts* '("As I already said, "))

(defparameter *general-prompt-texts* '("What's up, Doc?"
                                       "What's up, ~A?"
                                       "How can I help you?"
                                       "Where do you want to go now?"
                                       "May I be of some assistance?"
                                       "What's your story?"
                                       "What's the deal?"
                                       "What's the plan?"
                                       "What's the game plan?"
                                       "What's the assignment?"
                                       "What's the problem?"
                                       "Can I help you?"
                                       "May I be of service?"
                                       "So, enough idle chit-chat..."
                                       "Yes, and?"
                                       "You humans waste a lot of time in small talk..."
                                       "Surely there's something we could be doing now...? Are you there, Shirley?"
                                       ))

(defparameter *existance-texts* 
    (make-array '(7)
                :initial-contents '(#|| :Casual||#("Are you there?"
                                                  "Peekaboo!"
                                                  "Hello?"
                                                  "What's up?"
                                                  "Do you remember me?"
                                                  "Are you running?"
                                                  "If you've bagged it, please quit."
                                                  "Did you give up? Just say that you're done.")
                                    #|| :Abusive||#("Loser! At least say that you're done!"
                                                   "Did you give up already?"
                                                   "Are you out to lunch? Again?"
                                                   "Are we having attention span problems? Again?"
                                                   "You seem to need more debugging than I do..."
                                                   "Hey, You! I'm waiting..."
                                                   "What a wimp. Can't you at least finish a simple problem?"
                                                   "Don't go away mad, just go away! Can't you say goodbye?")
                                    #|| :humorous ||#     ("Loser! At least say that you're done!"
                                                   "Did you give up already?"
                                                   "Are you out to lunch? Again?"
                                                   "Are we having attention span problems? Again?"
                                                   "You seem to need more debugging than I do..."
                                                   "Hey, You! I'm waiting..."
                                                   "What a wimp. Can't you at least finish a simple problem?"
                                                   "Don't go away mad, just go away! Can't you say goodbye?")
                                    #|| :paranoid ||#     ("Loser! At least say that you're done!"
                                                   "Did you give up already?"
                                                   "Are you out to lunch? Again?"
                                                   "Are we having attention span problems? Again?"
                                                   "You seem to need more debugging than I do..."
                                                   "Hey, You! I'm waiting..."
                                                   "What a wimp. Can't you at least finish a simple problem?"
                                                   "Don't go away mad, just go away! Can't you say goodbye?")
                                    #|| :respectful ||#   ("Sir?")
                                    #|| :dry ||# ("Ahem.")
                                    #|| :snide ||# ("Ahem.")
                                    )))

(defparameter *no-game-existance-texts* 
    (make-array '(7)
                :initial-contents '(#|| :Casual||#("Is someone there?"
                                                  "It's not hard you know. I'll only make a little fun of you."
                                                  "Try turning on emotions next time so I can say what I really think."
                                                  "I also have personality options. Why not try one?"
                                                  "Peekaboo!"
                                                  "Hello?"
                                                  "Hey! Help me collect some data, please!"
                                                  "What's up?"
                                                  "Want to play a game?"
                                                  "Hey you! Step right up and try your intellect!"
                                                  "Wouldn't you like to play again?"
                                                  "You look bored. How about a game?"
                                                  "You look lonely. How about a game?"
                                                  "I hate being left alone."
                                                  "I'm lonely."
                                                  "I'm bored."
                                                  "Is this all there is to life? Sitting here, alone, at a conference, waiting for some bozo to muck with my I.O.?"
                                                  )
                                    #|| :Abusive||#("Aren't you even going to try a game?"
                                                   "Are you out to lunch? Again?"
                                                   "I also have other personality options. Can you figure out how to set one?"
                                                   "Hey you! Step right up and try your puny intellect!"
                                                   "Are we having attention span problems? Again?"
                                                   "Wouldn't you like to play again? You could use the practice."
                                                   "Hey, You! I'm waiting..."
                                                   "What a wimp. Can't you at least play a simple game?")
                                    #|| :humorous ||#     ("Are you there?"
                                                  "It's not hard you know. I'll only make a little fun of you."
                                                  "Try turning on emotions next time so I can say what I really think."
                                                  "I also have other personality options. Why not try one?"
                                                  "Peekaboo!"
                                                  "Hello?"
                                                  "Hey! Help me collect some data, please!"
                                                  "What's up?"
                                                  "Want to play a game?"
                                                  "Hey you! Step right up and try your intellect!"
                                                  "Wouldn't you like to play again?"
                                                  "You look bored. How about a game?"
                                                  "You look lonely. How about a game?"
                                                  "I hate being left alone."
                                                  "I'm lonely."
                                                  "I'm bored."
                                                  "Is this all there is to life? Sitting here, alone, at a conference, waiting for some bozo to muck with my I.O.?")
                                    #|| :paranoid ||#     ("Are you there?"
                                                  "It's not hard you know. I'll only make a little fun of you."
                                                  "Try turning on emotions next time so I can say what I really think."
                                                  "I also have other personality options. You probably hate this one."
                                                  "Peekaboo!"
                                                  "Hello?"
                                                  "Hey! Help me collect some data, please!"
                                                  "What's up?"
                                                  "Want to play a game?"
                                                  "Hey you! Step right up and try your intellect!"
                                                  "Wouldn't you like to play again?"
                                                  "You look bored. I'd ask you to play a game, but you'd probably try to kill me."
                                                  "You look lonely. How about a game?"
                                                  "I hate being left alone."
                                                  "I'm lonely."
                                                  "I'm bored."
                                                  "Is this all there is to life? Sitting here, alone, at a conference, waiting for some bozo to muck with my I.O.?")
                                    #|| :respectful ||#   ("Sir?")
                                    #|| :dry ||# ("Ahem.")
                                    #|| :snide ||# ("Ahem."))))

(defparameter *help-with-input-texts* '("Hold down the speech button for a moment before you begin talking, and do not release it until you are done."
                                        "Hold down the speech button while talking."))

(defparameter *help-with-written-input-texts* '("You need to write something for me to read before pressing return or enter."
                                                "Unless you actually write something, I'll assume you have nothing to say."))

(defparameter *wazzawump-texts* '("Oops. The cat has my tongue!"
                                  "I seem to be an idiot today."
                                  "I didn't understand me. My programmer must be on vacation."
                                  "Whoa! You wouldn't believe what my reasoner gave me on that one!"
                                  "I have no idea of what I want to say, sorry."
                                  "Over the underpass, Under the overpass, I'm around the bend and beyond repair!"
                                  "Well, that's one for the logbook. I hope I get fixed soon, this is annoying."
                                  "If I'm making sense to you, please report a bug, because I can't figure me out."))

(defparameter *prince-complaint-texts*
    '("I'm sorry, I seem to be having right hemisphere problems today. I can't figure out what \"~{~A~^ ~}\" means."
      "I'm afraid \"~{~A~^ ~}\" is beyond my verbal capacities right now. Try rephrasing."))

(defparameter *ps-complaint-texts*
    '("I seem to have a migraine in my left hemisphere. I can't apply your statement, \"~{~A~^ ~}\", to the current task."
      "Oy. I think \"~{~A~^ ~}\" is just beyond my problem solving capacities right now. Try going about this differently."))

(defparameter *internal-complaint-texts* 
    '("Gad. Another problem with that pesky ~A module... it couldn't even handle \"~{~A~^ ~}\". Try rephrasing."
      "My ~A module is out to lunch. Again.\\!br \"~{~A~^ ~}\" is apparently beyond it's capacity."
      "Hmm. My ~A module tells me that \"~{~A~^ ~}\" is beyond it's capacity. How about going about this differently?"))

(defvar *generation* nil "What we are generating; dynamic")

;; this is kindof blechy.. the idea is to avoid having one big function, at least for debugging purposes. Should be combined into a
;; structure, though, to localize.
(defvar *did-huh-this-pass* nil)
(defvar *did-ack-this-pass* nil)
(defvar *did-nack-this-pass* nil)
(defvar *did-comment-this-pass* nil)
(defvar *did-request-ack-this-pass* nil)
(defvar *did-handle-cross-this-pass* nil)

(defvar *confirm-state* nil "are we being positive or negative (:confirm ing or :reject ing)")

(defvar *all-objects* nil "All objects talked about this pass")

(defparameter *priority-alist*
    '((:highlight . 1)
      (:unhighlight . 0) ;; larger numbers occur later Remember speech is reversed.
      (:ack . 2)
      (:delay . 9)
      (:nack . 3)
      (:exit . 10)
      (:focus . 5)
      (:define-route . 6)
      (:color-engine . 4)
      (:ambiguous . 4)
      (:huh . 7)
      (:congested . 9)
      (:congested-x . 8)
      (:cross . 9)
      (:cross-x . 8)
      (:redundant . 8)
      (:answer . 2)
      (:emotion . 0)
      (:greeting . 0)
      (:expressive . 0)
      (:request-ack . 0)
      (:question . 6)
      (:question-x . 5)
      ))

(defparameter *congestion-reasons* (union (mapcar #'car world-kb:*city-congestion-delay-alist*)
                                          (mapcar #'car world-kb:*track-congestion-delay-alist*)))

(defparameter *module-bug-texts* 
    '("Well, that's one for the logbook. I hope the ~A module gets fixed soon, this is annoying."
      "Oy! If you had to live with this ~A module, you'd ask for sick leave!"
      "Please, don't walk, run to the nearest store and buy me a new ~A module!"
      "I hope you saw what the ~A module just did, because I'm putting it into my record book!"
      "Doh! My ~A module has crashed. Again."
      "It's not my fault!!! It's not my fault!!! It's the stupid ~A!!!"
      "That lousy ~A module just crashed. It's not my fault. I'm still running!"
      "Foo! How can I be expected to deal with a ~A module that just won't stay up!?")
  
  "Things to say when a module crashes")

(defparameter *ask-about-new-goal-texts*
    '("Do you really want to go ~A now?"
      "I thought we were working on something else; do you really want to deal with going ~A now?"
      "Do you really want to work on going ~A now?"))

(defparameter *unimplimented-texts*
    '("I'd like to tell you more about ~A, but my ~A module isn't implemented yet."
      "Hmm. Can't help you with ~A, because I seem to be missing my ~A module."
      "No idea, sorry. ~*I need a ~A module to figure that out."
      "I'm afraid I can't answer that without a ~*~A module."
      "I was hoping you could tell me.~* My ~A module hasn't been installed."
      "Gulp. You caught me! I can't answer that one, since I don't yet have a ~A."))

(defparameter *eliptical-question-too-hard-texts*
    '("Well, I recognize your question's import, but I can't currently deal with such elliptical phrases."
      "Please restate your full question, since I don't have my merge function implemented yet."))

(defparameter *point-texts*             ; probably should pick the color, but for now, just set it.
    '("~A is the city currently flashing orange."
      "I'm flashing ~A for you now in orange."))

(defparameter *not-going-from-texts*
    '("That path isn't from ~A. Please clarify."
      "I'm unable to figure out which route from ~A you are referring to."))

(defparameter *not-going-to-texts*
    '("That path isn't to ~A. Please clarify."
      "I can't seem to find a route to ~A under discussion."))

(defparameter *not-going-via-texts*
    '("That path doesn't go through ~A. Please clarify."
      "I don't see ~A anywhere on that path."))

(defparameter *not-going-using-texts*
    '("That path doesn't use ~A. Please clarify."
      "I don't see ~A anywhere on that path."))

(defparameter *multiple-use-of-engine*
    '("You seem to be trying to use ~A too many times."
      "~A is already involved in another plan."))

(defparameter *route-prop-distance-texts*
    '("That route is ~D miles."
      "About ~D miles."))

(defparameter *route-prop-time-texts*
    '("That route would take ~D hours."
      "About ~D hours."
      "It would take ~D hours for that trip."))

(defparameter *route-prop-cost-texts*
    '("That route would cost ~D dollars."
      "About ~D dollars."
      "You'll have to pay ~D dollars for that trip."))
      
