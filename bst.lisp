(load "stringutils.lisp")
(load "treeview.lisp")

(defstruct (tree-node 
  (:conc-name nil)
  (:constructor tn))
  key ; root node of branch
  (left nil)
  (right nil))

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

(render-to-file *t1* "tst" 'g1)
(render-to-file *t2* "tst" 'g2)
(render-to-file *t3* "tst" 'g3)