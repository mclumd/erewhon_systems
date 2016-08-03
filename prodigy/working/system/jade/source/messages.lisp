(in-package "FRONT-END")

;;; ****************************** FILE ******************************
;;;
;;;			      MESSAGES.LISP
;;;
;;; File contains the code that defines a message data type for the
;;; Prodigy-ForMAT front end.
;;;


;;;;;; HISTORY
;;;
;;; 17jun98 Created this file to contain the message specific code that used to
;;; be in file front-end.lisp. [cox]
;;;


(defvar *messages* nil)
(defvar *message-counter* 0)


#+original
(defclass message ()
  ((id :initform (incf *message-counter*) :initarg :id :accessor id)
   (title :initform "" :initarg :title :accessor title)
   (status :initform :active :initarg :status :accessor status)
   ))


;;; Clint Hyde of BBN changed the class definition and I added the
;;; displayed-2-user slot. [cox]
;;;
(defclass message ()
  ((id :initform (incf *message-counter*) :initarg :id :accessor id)
   (title :initform "" :initarg :title :accessor title)
   (args :initform () :initarg :args :Accessor args)
   (status :initform :active :initarg :status :accessor status)
   (displayed-2-user :initform () :initarg :displayed-2-user :accessor displayed-2-user
		     :documentation 
		     "Added to mark when the message is displayed to the Prodigy user so that it is not repeated. [16jun98 cox]"
		     )
   ))


;;; I do not know what Steve Coley originally had in mind for this class.
;;;
(defclass prodigy-message (message)
  ()
  )


(defun find-message (id)
  (find id *messages* :test #'(lambda (id o) (eq (id o) id)))
  )


(defun find-message-by-text (text)
  (find text *messages* :test #'(lambda (str o) (string= (title o) str)))
  )


#+original 
(defun make-message (&key id title (status :active))
  (let ((m (make-instance 'prodigy-message
			  :title (or title "")
			  :status status
			  :id (or id (incf *message-counter*)))))
    (push m *messages*)
    m
    ))


;;; Changed by Clint Hyde.
;;;
(defun make-message (&key id title (status :active) args displayed-2-user)
  (let ((m (make-instance 'prodigy-message
	     :title (or title "")
	     :args args
	     :status status
	     :displayed-2-user displayed-2-user
	     :id (or id (incf *message-counter*)))))
    (push m *messages*)
    m
    ))


#+original
(defun coerce-to-message (text)
  (or (find-message-by-text text)
      (make-message :title text))
  )


;;; Changed by Clint Hyde.
;;;
(defun coerce-to-message (text &optional args)
  (or (find-message-by-text text)
      (make-message :title text :args args)
      )
  )

;;;
;;; Function dummy-msg creates a dummy message without a status so that it will
;;; be removed in get-prodigy-response. The function that creates it will be
;;; used for side-effect only, and does not need to send a message to
;;; ForMAT. The id is explicitly set to -1 so that it will not increment the
;;; message counter. The displayed-2-user slot is set to t so that it will not
;;; be displayed. [cox]
;;;
(defun dummy-msg ()
  (make-message :status nil :id -1 :displayed-2-user t)
  )



