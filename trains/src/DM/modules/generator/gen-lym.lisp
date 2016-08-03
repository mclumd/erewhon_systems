;; Time-stamp: <Mon Jan 13 17:24:29 EST 1997 ferguson>

(when (not (find-package :generator))
  (load "generator-def"))
(in-package generator)

(set-syntax :lymphocyte)

(in-rulebase :generate)

(add-rule [0 whoa *
             [?_]     ; otherwise
             utility= 1
             produces= (progn (gen-wazzawump)
                              (log-warning :actualization "Generator: can't handle input: ~S" *input*))])

(add-rule [0 greet-p *
             [^type=sa-greet
              ^semantics=?sem]
             utility= 20
             produces= (gen-greeting ?sem)])

(add-rule [0 close *
             [^type=sa-close]
             utility= 20
             produces= (gen-close)])

(add-rule [0 restart *
             [^type=sa-restart]
             utility= 20
             produces= (gen-restart)])

(add-rule [0 wait *
             [^type=sa-wait]
             utility= 20
             produces= (gen-sayformat t :answer "Hold on....")])

(add-rule [0 bwa *
             [^type=sa-nolo-comprendez
              ($if (future-huh-p))] ; let that error have priority over this one.
             utility= 10                ; lower than a huh, which is a subtype.
             produces= (gen-handle-annoyance "no understanding")])

(add-rule [0 bwa-0 bwa
             [^type=sa-nolo-comprendez
              ($if (or (eq (get-last-evaluative) :confirm)
                       (future-close-p)
                       (future-restart-p)
                       (future-progress-p)))]
              utility= 11
              produces= (gen-handle-annoyance "misunderstanding")])

(add-rule [0 bwa-1 bwa
             [^type=sa-nolo-comprendez
              ^action=nil]
             utility= 9
             produces= (progn (gen-huh) ; say something.
                              (gen-handle-annoyance "no understanding"))])

(add-rule [0 bwa-x bwa
             [^type=sa-nolo-comprendez
              ^action=?act@t-non-null
              ^semantics=?sem]
             utility= 8
             produces= (gen-module-complaint ?act ?sem)]) ; say something about the nasty module

(add-rule [0 bwa-x1 bwa
             [^type=sa-nolo-comprendez
              ^action=?act@t-non-null
              ^semantics=?sem
              ($if (future-nolo-p))]
             utility= 9
             produces= (gen-module-complaint-defer ?act ?sem)])

(add-rule [0 point *
             [^type=sa-point-with-mouse
              ^focus=?focus]
             utility= 20
             produces= (gen-point ?focus)])
          
#||
(eval-when (load eval)
  (lym:trace-lym-rule huh))
||#

(add-rule [0 yn-question *
             [^type=sa-yn-question
              ^semantics=:existance
              ($if (not hack::*game-in-progress*))] ; waiting around for another luser
             utility= 20
             produces= (gen-sayone :question *no-game-existance-texts*)])

(add-rule [0 yn-question-1 yn-question
             [^type=sa-yn-question
              ^semantics=:existance
              ($if hack::*game-in-progress*)] ; the system is running
             utility= 20
             produces= (progn
                         (gen-sayone :question *existance-texts*) ; note that it's a bug that the DM doesn't know the content of this...
                         (unless (and user::*debug*
                                      (equal (hack::real-user-name) "miller")) ; debugging, so don't count silence.
                           (gen-handle-annoyance "silence")))])

(add-rule [0 yn-question-2 yn-question
             [^type=sa-yn-question
              ^semantics=:quit]
             utility= 20
             produces= (progn
                         (add-gen :dialogue-box :question-x "QUIT" "Are you really finished?")
                         (gen-sayformat t :question "Please confirm that you are done, using the dialogue box."))])

(add-rule [0 yn-question-3 yn-question
             [^type=sa-yn-question
              ^semantics=:restart]
             utility= 20
             produces= (progn
                         (add-gen :dialogue-box :question-x "RESTART" "Do you really want to start over?")
                         (gen-sayformat t :question "Please confirm that you wish to restart, using the dialogue box."))])

(add-rule [0 yn-question-4 yn-question
             [^type=sa-yn-question
              ^objects=?obs
              ^semantics=:new-goal]
             utility= 20
             produces= (gen-ask-about-new-goal ?obs)])

(add-rule [0 wh-question *
             [^type=sa-wh-question
              ^semantics=:so-what]      ; nothing to do, and we didn't have a plan to prompt.
             utility= 20
             produces= (gen-prompt)])   ; keep the discourse moving

(add-rule [0 ambiguous *
             [^type=sa-ambiguous
              ^expected-type=?expected
              ^object=?object]
             utility= 30                ; higher than a huh, which is a supertype.
             produces= (gen-ambiguous ?expected ?object)])

(add-rule [0 expressive-apology *
             [^type=sa-expressive
              ^semantics= :apology-acceptance]
             utility= 20
             produces= (gen-sayone :expressive *apology-acceptance-texts*)])

(add-rule [0 expressive-apology-1 expressive-apology
             [^type=sa-expressive
              ^semantics= :apology-refusal]
             utility= 20
             produces= (gen-sayone :expressive *apology-refusal-texts*)])

(add-rule [0 expressive-welcome *
             [^type=sa-expressive
              ^semantics= :welcome]
             utility= 20
             produces= (gen-sayone :expressive *youre-welcome-texts*)])

(add-rule [0 expressive-ah *
             [^type=sa-expressive
              ^semantics= :ah]
             utility= 20
             produces= (gen-sayone :expressive *ah-texts*)])

(add-rule [0 expressive-feh *
             [^type=sa-expressive
              ^semantics= :feh]
             utility= 20
             produces= (gen-sayone :expressive *feh-texts*)])

(add-rule [0 expressive-fooey *
             [^type=sa-expressive
              ^semantics= :fooey]
             utility= 20
             produces= (gen-sayone :expressive *fooey-texts*)])

(add-rule [0 expressive-good *
             [^type=sa-expressive
              ^semantics= :good]
             utility= 20
             produces= (gen-sayone :expressive *good-texts*)])

(add-rule [0 suggest *
             [^type=sa-suggest
              ^semantics=:help-with-input]
             utility= 20
             produces= (gen-sayone :huh *help-with-input-texts*)])

(add-rule [0 suggest *
             [^type=sa-suggest
              ^mode=:written
              ^semantics=:help-with-input]
             utility= 25
             produces= (gen-sayone :huh *help-with-written-input-texts*)])

(add-rule [0 huh *
             [^type=sa-huh
              ^plan=?plan
              ($if (future-route-p ?plan))]
             utility= 20
             produces= (gen-fake-huh)])

(add-rule [0 huh-1 huh
             [^type=sa-huh
              ^expected-type=?exp
              ^object=?object
              ($if (member ?exp '( :no-route :bad-route :bad-delete)))]
             utility= 19
             produces= (gen-bad-route ?object ?exp)])

(add-rule [0 huh-2 huh
             [^type=sa-huh
              ^object=?object
              ^expected-type=:engine]
             utility= 19
             produces= (gen-bad-engine-location ?object)])

(add-rule [0 huh-3 huh
             [^type=sa-huh
              ^focus=?focus
              ^expected-type=:goal]
             utility= 19
             produces= (gen-bad-goal ?focus)])

(add-rule [0 huh-3a huh
             [^type=sa-huh
              ^focus=?focus
              ^expected-type=:destination]
             utility= 19
             produces= (gen-bad-goal ?focus)]) ; not really the same, but what the hell.

(add-rule [0 huh-4 huh
             [^type=sa-huh
              ^object=?object
              ^expected-type=:unknown
              ^semantics=?sem]
             utility= 19
             produces= (gen-unknown-answer ?object ?sem)])

(add-rule [0 huh-4a huh
             [^type=sa-huh
              ^expected-type=:question-elipsis-too-hard]
             utility= 19
             produces= (gen-too-hard-answer :question-elipsis-too-hard)])

(add-rule [0 huh-5 huh
             [^type=sa-huh
              ^focus=?focus
              ^expected-type=:constraint]
             utility= 19
             produces= (gen-bad-constraint ?focus)])

(add-rule [0 huh-6 huh
             [^type=sa-huh
              ^focus=?focus
              ^expected-type=:unique-engine]
             utility= 19
             produces= (gen-reused-engine ?focus)])

(add-rule [0 request *
             [^type=sa-request
              ^defs=?act
              ($if (eqmemb :restart ?act))]
             utility= 20
             produces= (gen-restart (eqmemb :new-scenario ?act))])

(add-rule [0 warn *
             [^type=sa-warn
              ^defs=?action
              ^objects=?objects
              ^semantics=?sem]
             utility= 20
             produces= (gen-warn ?action ?objects ?sem (future-warn-p))])

(add-rule [0 (elaborate ?focus ?sem ?action ?confirm-state) *
             [^type=sa-elaborate
              ^focus=?focus
              ^semantics=?sem
              ^defs=?action]
             postmatch= ((?confirm-state *confirm-state*))])

(add-rule [0 (elaborate-1 ?focus ?sem ?action ?confirm-state) elaborate
             [^type=sa-confirm
              ^focus=?focus
              ^defs=?action
              ^semantics=?sem]
             postmatch= ((?confirm-state :confirm))])

(add-rule [0 (elaborate-2 ?focus ?sem ?action ?confirm-state) elaborate
             [^type=sa-reject
              ^focus=?focus
              ^defs=?action
              ^semantics=?sem]
             postmatch= ((?confirm-state :reject))])

(add-rule [1 (elab ?elab-type ?elab-args ?redundant-p ?remaining-input-p ?future-huh-p) *
             [elaborate^sem=?sem@t-non-null
              elaborate^action=?action]
             postmatch= ((?elab-type (car ?sem))
                         (?elab-args (cdr ?sem))
                         (?redundant-p (eq ?action :redundant))
                         (?remaining-input-p (not (null *remaining-input*)))
                         (?future-huh-p (future-reject-p)))])

#||
(eval-when (load eval)
  (lym:trace-lym-rule warn elaborate elab))
||#

(add-rule [2 elab-focus *
             [elaborate^focus=?focus
              elab^elab-type=:new-focus
              elab^redundant-p=?redundant-p
              elab^remaining-input-p=?remaining-input-p
              elab^future-huh-p=?future-huh-p
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-new-focus ?focus ?redundant-p ?remaining-input-p ?future-huh-p))])

(add-rule [2 elab-correction *
             [elab^elab-type=:correction
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-correction))])

(add-rule [2 elab-route-extension *
             [elaborate^focus=?focus
              elab^elab-type=:route-extension
              elab^elab-args=?elab-args
              elab^redundant-p=?redundant-p
              elab^remaining-input-p=?remaining-input-p
              elab^future-huh-p=?future-huh-p
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-route-extension ?focus ?elab-args ?redundant-p ?remaining-input-p ?future-huh-p))])

(add-rule [2 elab-goal *
             [elab^elab-type=:goal
              elab^elab-args=?elab-args
              elab^redundant-p=?redundant-p
              elab^remaining-input-p=?remaining-input-p
              elab^future-huh-p=?future-huh-p
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-goal ?elab-args ?redundant-p ?remaining-input-p ?future-huh-p))])

(add-rule [2 elab-goal-delete *
             [elab^elab-type=:goal-delete
              elab^elab-args=?plans]
             utility= 20
             produces= (add-gen :unhighlight-plan-objects :unhighlight (car ?plans))])

(add-rule [2 elab-yn-q *
             [elaborate^focus=?focus
              elab^elab-type=:yn-question-answer
              elab^elab-args=?elab-args
              elab^redundant-p=?redundant-p
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-qa ?focus t ?elab-args ?redundant-p (eq *confirm-state* :reject)))])

(add-rule [2 elab-q *
             [elaborate^focus=?focus
              elab^elab-type=:question-answer
              elab^elab-args=?elab-args
              elab^redundant-p=?redundant-p
              elaborate^confirm-state=?confirm-state]
             utility= 20
             produces= (progn
                         (if ?confirm-state
                             (setq *confirm-state* ?confirm-state))
                         (gen-handle-qa ?focus nil ?elab-args ?redundant-p (eq *confirm-state* :reject)))])

#||
(eval-when (load eval)
  (lym:trace-lym-rule confirm reject))
||#

(add-rule [0 confirm *
             [^type=sa-confirm
              ^semantics=nil]
             utility= 20
             produces= (progn
                         (setq *confirm-state* :confirm)
                         (unless (or (future-blarfo-p)
                                     (did-huh-p))
                           (gen-ack (null *remaining-input*))))])

(add-rule [0 confirm-1 confirm
             [^type=sa-confirm
              ^semantics= ( :question-answer)]
             utility= 20
             produces= (progn
                         (setq *confirm-state* :confirm)
                         (gen-ack-qa))])

(add-rule [0 reject *
             [^type=sa-reject
              ^semantics=nil]
             utility= 20
             produces= (progn
                         (setq *confirm-state* :reject)
                         (gen-nack (null *remaining-input*)))])

(add-rule [0 reject-1 reject
             [^type=sa-reject
              ^semantics= ( :question-answer)]
             utility= 20
             produces= (progn
                         (setq *confirm-state* :reject)
                         (gen-nack-qa))])

