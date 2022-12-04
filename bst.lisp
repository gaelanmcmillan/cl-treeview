; BST implementation in lisp

; (defun bst-insert (value head))

; (:conc-name nil) allows us to use slots without prefixes,
; i.e (left *node*) instead of (tree-left *node*)
(defstruct (tree-node 
  (:conc-name nil)
  (:constructor tn))
  key ; root node of branch
  (left nil)
  (right nil))

(defun fstring (&rest args)
  (let ((str (make-array 0 :element-type 'character :fill-pointer 0)))
    (apply 'format (cons str args))
    str))

(defun write-children (tree file)
  (flet ((try-write-child (child)
          (when child
            (progn
              (format file "  ~a -> ~a;~%" (key tree) (key child))
              (write-children child file)))))
    (try-write-child (left tree))
    (try-write-child (right tree))))
  
(defun show-tree (tree filename &optional (graphname 'g))
  (with-open-file (outfile filename
                  :direction :output
                  :if-exists :append
                  :if-does-not-exist :create)
    (format outfile "digraph ~a {~%" graphname)
    (write-children tree outfile)
    (format outfile "}~%")))

(defvar *t*
  (tn :key 'a
    :left (tn :key 'b
            :left (tn :key 'd)) 
    :right (tn :key 'c)))

(show-tree *t* "test1.dot" 'g2)
(show-tree *t* "test1.dot" 'g3)