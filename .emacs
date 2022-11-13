(require 'package)

; list the repositories containing them
(setq package-archives '(
  ("elpa" . "http://tromey.com/elpa/")
  ("melpa" . "https://melpa.org/packages/")))

; list the packages you want
(setq package-list '(proof-general evil))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; join the dark side
(evil-mode 1)

; set the default theme
(load-theme 'tango-dark t)

; remove annoying =>
(setq overlay-arrow-string "")