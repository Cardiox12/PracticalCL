(defvar *account-numbers* 0)

(defclass bank-account ()
  ((customer-name
     :initarg :customer-name
     :initform (error "Must supply a customer name."))
   (balance
     :initarg :balance
     :initform 0)
   (account-number
     :initform (incf *account-numbers*))
   account-type))

(defmethod initialize-instance :after ((account bank-account) &key)
  (let ((balance (slot-value account 'balance)))
    (setf (slot-value account 'account-type)
          (cond
            ((>= balance 100000)    :gold)
            ((>= balance 50000)     :silver)
            (t                      :bronze)))))

(defmethod initialize-instance :after ((account bank-account) &key opening-bonus%)
  (when opening-bonus%
    (incf (slot-value account 'balance)
          (* (slot-value account 'balance) (/ opening-bonus% 100)))))

#|(defclass checking-account (bank-account) ...)|#

#|(defclass savings-account (bank-account) ...)|#
