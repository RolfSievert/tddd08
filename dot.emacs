;;; SICSTUS Prolog mode for GNU emacs. (If you are using xemacs
;;; you are on your own...) First make sure that you have loaded
;;; the module prog/sicstus. That is, give the shell command:
;;;      module add prog/sicstus
;;; Then add the following to your .emacs-file.
(set-variable 'load-path 
    (cons "/home/TDDD08/gnu" load-path))
(autoload 'run-prolog "prolog"
    "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" 
    "Major mode for editing Prolog programs." t)

(setq prolog-system 'sicstus)
(setq auto-mode-alist
      (cons '("\\.pl$" . prolog-mode) auto-mode-alist))

