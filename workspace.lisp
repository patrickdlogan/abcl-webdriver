;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This file is a collection of 'workspace' code for exploring Armed
;; Bear Common Lisp, lisp-unit, and WebDriver for testing
;; browser-based applications.
;; 
;; Copyright (c) 2011, Patrick D. Logan
;; All rights reserved.
;;
;; See COPYING for more information. The license is the "new and
;; simplified BSD license" See
;; http://www.opensource.org/licenses/bsd-license

(ql:quickload "lisp-unit")
(use-package 'lisp-unit)

(defun make-html-unit-driver (&key enable-javascript)
  "Return a new instance of org.openqa.selenium.HtmlUnitDriver"
  (if enable-javascript
      (let ((caps (jstatic "htmlUnitWithJavascript" "org.openqa.selenium.remote.DesiredCapabilities")))
	(jnew "org.openqa.selenium.htmlunit.HtmlUnitDriver" caps))
    (jnew "org.openqa.selenium.htmlunit.HtmlUnitDriver")))

(defun load-page (driver url)
  "Use the given driver to HTTP GET the url. The result is loaded into the driver's browser."
  (jcall "get" driver url))

(defun find-element-by-tag (driver tag)
  "Return an element with the given HTML tag name on the driver's current page."
  (jcall "findElement" driver (jstatic "tagName" "org.openqa.selenium.By" tag)))

(defun get-text (elem)
  "Return the inner text of the given element."
  (jcall "getText" elem))

(defun exec-script (driver script)
  "Return the result of executing the javascript string in the page that is currently loaded in the driver. The script should terminate with a return statement or the result will be null."
  (jcall "executeScript" driver script (jnew-array "java.lang.Object" 0)))

(define-test test-my-max
  (assert-equal "Moo Foo" (let* ((driver (make-html-unit-driver))
				 (elem   (progn (load-page driver "http://localhost:8000")
						(find-element-by-tag driver "h1"))))
			    (get-text elem))))

(define-test test-javascript
  (assert-equal 5 (let* ((driver (make-html-unit-driver :enable-javascript t)))
		    (load-page driver "http://localhost:8000")
		    (exec-script driver "return 2 + 3"))))

;(run-tests)
