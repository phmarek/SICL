


(loop for i from 0 to 5
      for slots = (subseq '(a b c d e f g h i j k l m n o p)
                          i
                          (+ i 5))
      do (eval `(defclass my-class ()
                  ((version :reader version :allocation :class :initform ,i)
                   (slot0 :accessor slot0 :initform ,i)
                   ,@(mapcar (lambda (slot)
                               `(,slot :accessor ,slot :initform ,i))
                             slots)
                   (last-slot :accessor last-slot :initform 99))))
      do (eval `(defmethod update-instance-for-redefined-class ((inst my-class) added discarded prop-list &rest initargs)
                  (declare (ignore initargs))
                  (format t "version ~d got called for version ~d;~% added ~s~% discarded ~s~% prop ~s~%"
                          ,i
                          (version inst)
                          added
                          discarded
                          prop-list)))
      collect (make-instance 'my-class) into results
      finally (progn
                (mapcar #'identity results)
                (return results)))
