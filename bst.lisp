(defstruct (tree-node 
  (:conc-name nil)
  (:constructor tn))
  key ; root node of branch
  (left nil)
  (right nil))

; (fstring "~a.dot" 'symbol) -> "SYMBOL.dot"
(defun fstring (&rest args)
  (let ((str (make-array 0 :element-type 'character :fill-pointer 0)))
    (apply 'format (cons str args))
    str))

; recursively write tree nodes to file in .dot format
(defun write-children (tree file)
  (flet ((try-write-child (child)
          (when child
            (progn
              (format file "  ~a -> ~a;~%" (key tree) (key child))
              (write-children child file)))))
    (try-write-child (left tree))
    (try-write-child (right tree))))
  
; renders and appends a tree to a file as a .dot digraph
(defun render-to-file (tree filename &optional (graphname "g"))
  (with-open-file (outfile (fstring "~a.dot" filename)
                  :direction :output
                  :if-exists :append
                  :if-does-not-exist :create)
    (format outfile "digraph ~a {~%  center = true~%" graphname)
    (write-children tree outfile)
    (format outfile "}~%~%")))



; testing
(defvar *t1*
  (tn :key 'a
    :left (tn :key 'b
            :left (tn :key 'd)) 
    :right (tn :key 'c)))

(defvar *t2*
  (tn :key 'a
    :left (tn :key 'b
            :left (tn :key 'd)
            :right (tn :key 'e)) 
    :right (tn :key 'c)))

(defvar *t3*
  (tn :key 'a
    :left (tn :key 'b
            :left (tn :key 'd)
            :right (tn :key 'e)) 
    :right (tn :key 'c
            :left (tn :key 'f))))

(show-tree *t1* "tst" 'g1)
(show-tree *t2* "tst" 'g2)
(show-tree *t3* "tst" 'g3)