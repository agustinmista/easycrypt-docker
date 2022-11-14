(require 'package)

; list the repositories containing them
(setq package-archives '(
  ("elpa" . "http://tromey.com/elpa/")
  ("melpa" . "https://melpa.org/packages/")))

; list the packages you want
(setq package-list '(
  proof-general
  which-key
  evil))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

; use short questions instead of yes-or-no ones
(fset 'yes-or-no-p 'y-or-n-p)

; disable Emacs splash screen and startup echo message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

; disable Proof General's splash screen
(setq proof-splash-enable nil)

; remove annoying =>
(setq overlay-arrow-string "")

; set the default theme
(load-theme 'tango-dark t)

; enable which-key mode
(which-key-mode 1)

; join the dark side
(evil-mode 1)
