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

(defun make-html-unit-driver ()
  "Return a new instance of org.openqa.selenium.HtmlUnitDriver"
  (jnew "org.openqa.selenium.htmlunit.HtmlUnitDriver"))

(defun load-page (driver url)
  "Use the given driver to HTTP GET the url. The result is loaded into the driver's browser."
  (jcall "get" driver url))

