;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
      ("ORG"    . "https://orgmode.org/elpa/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities
      '(("ORG"    . 20)
        ("nongnu" . 16)
      ("MELPA"        . 12)
      ("MELPA Stable" . 8)
        ("GNU ELPA"     . 4)))
)


;; Fix gnu package archive verification in Emacs 26.2 by disabling broken TLS 1.3 support
;;  per https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/
(if (and (= emacs-major-version 26) (= emacs-minor-version 2))
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; List the packages you want.
(setq package-list '(helm
                     use-package
                     auctex
                     auctex-lua
                     auctex-cluttex
                     auctex-latexmk
                     org
                     tabbar
                     exec-path-from-shell
                     cff
                     srefactor
                     ein
                     ess
                     ess-view
                     ess-R-data-view
                     ess-r-insert-obj
                     ess-smart-equals
                     ess-view-data
                     ess-smart-underscore
                     geiser-mit
                     polymode
                     poly-markdown
                     poly-R
                     auto-complete
                     auto-complete-auctex
                     auto-complete-clang
                     auto-complete-c-headers
                     paradox
                     company
                     company-auctex
                     company-bibtex
                     dash
                     smex
                     flymake
                     evil
                     yasnippet
                     yasnippet-snippets
                     bm
                     smartparens
                     yafolding
                     magit
                     magit-find-file
                     markdown-mode
                     markdown-toc
                     neotree
                     imenu-list
                     key-combo
                     hydra
                     flycheck
                     flycheck-julia
                     flycheck-aspell
                     flycheck-irony
                     elpy
                     dumb-jump
                     jedi
                     anaconda-mode
                     web-mode
                     monokai-theme
                     molokai-theme
                     solarized-theme
                     gotham-theme
                     leuven-theme
                     flatui-theme
                     spacemacs-theme))

;; Activate all the packages (in particular autoloads).
(package-initialize)

;; Fetch the list of packages available.
(unless package-archive-contents
  (package-refresh-contents))

;; Install the missing packages.
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; (setq python-shell-interpreter "/home/yannik/miniconda3/envs/ykp/bin/python")

;; No, we do not need the splash screen
(setq inhibit-startup-screen t)

;;; Nice options to have On by default
;;;
(mouse-wheel-mode t)      ; activate mouse scrolling
(global-font-lock-mode t)   ; syntax highlighting
(transient-mark-mode t)     ; sane select (mark) mode
(delete-selection-mode t)   ; entry deletes marked text
(show-paren-mode t)     ; match parentheses
(add-hook 'text-mode-hook 'turn-on-auto-fill) ; wrap long lines in text mode

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(minesweeper gameoflife chess sudoku poker 2048-game)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Install the missing packages.
(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))
;;----------------------------------------------------------------------
;; helm.
;; http://tuhdo.github.io/helm-intro.html

(when (not (package-installed-p 'helm))
 (package-install 'helm))

(require 'helm)
(require 'helm-config)
;; (require 'helm-R)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(when (executable-find "ack-grep")
  (setq helm-grep-default-command
        "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command
        "ack-grep -H --no-group --no-color %e %p %f"))

(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t
      helm-M-x-fuzzy-match                  t
      helm-buffers-fuzzy-matching           t
      helm-recentf-fuzzy-match              t
      helm-locate-fuzzy-match               t
      helm-apropos-fuzzy-match              t
      helm-lisp-fuzzy-completion            t
      helm-semantic-fuzzy-match             t
      helm-imenu-fuzzy-match                t)

(helm-mode 1)
(helm-autoresize-mode t)

(global-set-key (kbd "C-c h")   'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "C-x b")   'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

(add-to-list 'helm-sources-using-default-as-input
             'helm-source-man-pages)

;;----------------------------------------------------------------------
;; Company.

(when (not (package-installed-p 'company))
 (package-install 'company))

(require 'company)
;; (add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay             0.2
      company-minimum-prefix-length  2
      company-require-match          nil
      company-dabbrev-ignore-case    nil
      company-dabbrev-downcase       nil
      company-frontends              '(company-pseudo-tooltip-frontend))

;;----------------------------------------------------------------------

(require 'iso-transl) ;; To work the accents on Sony Vaio.

;;----------------------------------------------------------------------
;; Magit.

(when (not (package-installed-p 'magit))
 (package-install 'magit))

(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;----------------------------------------------------------------------
;; Visible bookmarks. Easy movement.
;; https://marmalade-repo.org/packages/bm

(when (not (package-installed-p 'bm))
 (package-install 'bm))

(require 'bm)

;; Customize the colors by using M-x customize-group RET bm RET
(setq bm-marker 'bm-marker-left)
(setq bm-highlight-style 'bm-highlight-only-fringe)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;;----------------------------------------------------------------------
;; Folding code blocks based on indentation.
;; git clone https://github.com/zenozeng/yafolding.el.git

(when (not (package-installed-p 'yafolding))
 (package-install 'yafolding))

(require 'yafolding)
(global-set-key [?\C-{] #'yafolding-hide-parent-element)
(global-set-key [?\C-}] #'yafolding-toggle-element)

;;----------------------------------------------------------------------
;; Smart Parenthesis.
;; https://github.com/Fuco1/smartparens.

(when (not (package-installed-p 'smartparens))
 (package-install 'smartparens))

(require 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode 1)

(sp-pair "\"" nil :unless '(sp-point-after-word-p))
(sp-pair "'" nil :unless '(sp-point-after-word-p))

;;----------------------------------------------------------------------
;; MarkDown extensions.
;; (IT MUST BE BEFORE LATEX EXTENSIONS.)

;; (when (not (package-installed-p 'markdown-mode))
;;   (package-install 'markdown-mode))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Org-struct minor mode active in markdown mode.
(add-hook 'markdown-mode-hook 'turn-on-orgstruct)
(add-hook 'markdown-mode-hook 'turn-on-orgstruct++)

;; Enable Index at the menu bar with the TOC of markdown document.
(add-hook 'markdown-mode-hook 'imenu-add-menubar-index)
(setq imenu-auto-rescan t)

;; https://leanpub.com/markdown-mode/read -> section 4.6.
(require 'imenu-list)
(setq imenu-list-focus-after-activation t
      imenu-list-auto-resize nil)

;; Uses F10 to toggle the TOC sidebar for easy navigation.
(add-hook 'markdown-mode-hook
          '(lambda()
             (global-set-key (kbd "<f10>") 'imenu-list-smart-toggle)))

;;----------------------------------------------------------------------
;; R+MarkDown extensions (emacs >= 24.3.1).
;; (IT MUST BE BEFORE LATEX EXTENSIONS.)

(when (not (package-installed-p 'polymode))
 (package-install 'polymode))

(use-package poly-markdown
             :ensure t)
(use-package poly-R
             :ensure t)

;; (autoload 'poly-markdown-mode "poly-markdown-mode"
;;   "Major mode for editing R-Markdown files" t)
;; (add-to-list 'auto-mode-alist '("\\.[Rr]md" . poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.[Rr]md" . poly-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))

;;----------------------------------------------------------------------
;; ESS - Emacs Speaks Statistics.
;; http://ess.r-project.org/

(when (not (package-installed-p 'ess))
 (package-install 'ess))


;; Enable sweaving directly within the AUCTeX ecosystem.
(setq-default ess-swv-plug-into-AUCTeX-p t)

(require 'ess-site)

(setq-default ess-dialect "R")
(setq-default inferior-R-args "--no-restore-history --no-save ")

(require 'ess-view)
(setq ess-view--spreadsheet-program "gnumeric")

(defadvice ess-eval-buffer (before really-eval-buffer compile activate)
  "Prevent call ess-eval-buffer by accident, frequently by
   hitting C-c C-b instead of C-c C-n."
  (if (yes-or-no-p
       (format "Are you sure you want to evaluate the %s buffer?"
               buffer-file-name))
      (message "ess-eval-buffer started.")
    (error "ess-eval-buffer canceled!")))

(add-hook
 'ess-mode-hook
 '(lambda()
    (add-hook 'write-contents-functions
        (lambda ()
          (ess-nuke-trailing-whitespace)))
    (setq ess-nuke-trailing-whitespace-p t)
    (ess-toggle-underscore nil)
    (define-key ess-mode-map [?\M--]
      'ess-cycle-assign) ;; `Alt + -'  to cycle `<- | <<- | = ...'.
    (auto-complete-mode 1)
    (company-mode 1)                               ;; (company-mode -1)
    (define-key ess-mode-map [f5] 'company-R-args) ;; F5 do show ARGS.
    (setq ess-indent-with-fancy-comments nil) ;; No indent levels.
    (setq-local comment-add 0)                ;; Single # as default.
    (setq ess-smart-operators t)              ;; Smart comma.
    (setq comint-scroll-to-bottom-on-input t)
    (setq comint-scroll-to-bottom-on-output t)
    (setq comint-move-point-for-output t)))

;; Script and console font lock highlight.
(setq ess-R-font-lock-keywords
      '((ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)))
(setq inferior-R-font-lock-keywords
      '((ess-S-fl-keyword:prompt . t)
        (ess-R-fl-keyword:messages . t)
        (ess-R-fl-keyword:modifiers . t)
        (ess-R-fl-keyword:fun-defs . t)
        (ess-R-fl-keyword:keywords . t)
        (ess-R-fl-keyword:assign-ops . t)
        (ess-R-fl-keyword:constants . t)
        (ess-fl-keyword:matrix-labels . t)
        (ess-fl-keyword:fun-calls . t)
        (ess-fl-keyword:numbers . t)
        (ess-fl-keyword:operators . t)
        (ess-fl-keyword:delimiters . t)
        (ess-fl-keyword:= . t)
        (ess-R-fl-keyword:F&T . t)))

;; Movement across chunks in Rnw files.
(global-set-key (kbd "C-S-<f5>") 'ess-eval-chunk)
(global-set-key (kbd "C-S-<f6>") 'ess-eval-chunk-and-step)
(global-set-key (kbd "C-S-<f7>") 'ess-noweb-next-code-chunk)
(global-set-key (kbd "C-S-<f8>") 'ess-noweb-previous-code-chunk)
(global-set-key (kbd "C-S-<f9>") 'ess-noweb-goto-chunk)

(dolist (mode '(ess-mode-hook lisp-mode-hook))
  (add-hook mode
            '(lambda ()
               (global-set-key (kbd "<M-right>")  'forward-sexp)
               (global-set-key (kbd "<M-left>")   'bakward-sexp)
               (global-set-key (kbd "<M-down>")   'forward-list)
               (global-set-key (kbd "<M-up>")     'backward-list)
               (global-set-key (kbd "<M-S-up>")   'backward-up-list)
               (global-set-key (kbd "<M-S-down>") 'down-list))))

;;----------------------------------------------------------------------
;; Auto complete mode for Emacs.

(when (not (package-installed-p 'auto-complete))
  (package-install 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

(setq ac-auto-start 0
      ac-delay 0.2
      ac-quick-help-delay 1.
      ac-use-fuzzy t
      ac-fuzzy-enable t
      ;; use 'complete when auto-complete is disabled
      tab-always-indent 'complete
      ac-dwim t)

(setq-default ac-sources '(ac-source-abbrev
                           ac-source-dictionary
                           ac-source-words-in-same-mode-buffers))

;; To activate ESS auto-complete for R.
(setq ess-use-auto-complete 'script-only)

;; Change 'ac-complete from ENTER to TAB.
(define-key ac-completing-map "\r" nil)
(define-key ac-completing-map "\t" 'ac-complete)

;;----------------------------------------------------------------------
;; Key combos.
;; https://github.com/emacs-ess/ESS/issues/96

;; (require 'key-combo)
;;
;; (defvar key-combo-ess-default
;;   '((">"  . (" > " " %>% " " %>%\n"))
;;     ("<"  . (" < " " <<- "))
;;     ("$"  . ("$" " %$% "))
;;     ("<>" . " %<>% ")
;;     ("%" . " %")
;;     ("#" . "# ")
;;     ;; ("*"  . ("*" " * "))
;;     ;; ("%" . ("%" "%*%" "%%"))
;;     ;; ("^"  . ("^" " ^ "))
;;     ("/"  . ("/" " %/% " " %% "))
;;     ;; ("~" . " ~ ")
;;     ;; (":" . (":" "::" ":::"))
;;     ;; (":="  . " := ") ; data.table
;;     ("->"  . " -> ")
;;     ("."  . ("." "_" "..."))))
;;
;; (add-hook 'ess-mode-hook
;;           '(lambda() (key-combo-mode t)))
;; (add-hook 'inferior-ess-mode-hook
;;           '(lambda() (key-combo-mode t)))
;;
;; (key-combo-define-hook '(ess-mode-hook inferior-ess-mode-hook)
;;                        'ess-key-combo-load-default
;;                        key-combo-ess-default)

;;----------------------------------------------------------------------
;; Latex extensions.

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; Open Tikz files (pgf and pgs extensions) in Tex mode.
(add-to-list 'auto-mode-alist '("\\.pgf" . latex-mode))
(add-to-list 'auto-mode-alist '("\\.pgs" . latex-mode))

;;;
;;; AUCTeX
;;;
;; Turn on RefTeX for LaTeX documents. Put further RefTeX
;; customizations in your .emacs file.
(add-hook 'LaTeX-mode-hook
    (lambda ()
      (turn-on-reftex)
      (setq reftex-plug-into-AUCTeX t)))

;; Defensive hack to find latex in case the PATH environment variable
;; was not correctly altered at TeX Live installation. Contributed by
;; Rodney Sparapani <rsparapa@mcw.edu>.
(require 'executable)
(if (and (not (executable-find "latex")) (file-exists-p "/usr/texbin"))
    (setq LaTeX-command-style
    '(("" "/usr/texbin/%(PDF)%(latex) %S%(PDFout)"))))

;; Load AUCTeX.
(load "auctex.el" nil t t)

;;----------------------------------------------------------------------
;; Python configuration.

;; Install first: M-x package-list-packages C-s elpy.
(when (not (package-installed-p 'elpy))
  (package-install 'elpy))

(use-package elpy
  :ensure t
  :commands elpy-enable
  :init (with-eval-after-load 'python (elpy-enable))

  :config
  (electric-indent-local-mode -1)
  (delete 'elpy-module-highlight-indentation elpy-modules)
  (delete 'elpy-module-flymake elpy-modules)

  (defun ha/elpy-goto-definition ()
    (interactive)
    (condition-case err
        (elpy-goto-definition)
      ('error (xref-find-definitions (symbol-name (symbol-at-point))))))

  :bind (:map elpy-mode-map ([remap elpy-goto-definition] .
                             ha/elpy-goto-definition)))
(setq python-shell-interpreter "/home/yannik/miniconda3/envs/ykp/bin/python")

;; Seguir: http://tkf.github.io/emacs-jedi/latest/
;;   Terminal : sudo apt-get install virtualenv
;;   Emacs    : M-x package-install RET jedi RET
;;   Emacs    : M-x jedi:install-server RET

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Requires `anaconda-mode' package.
;; https://github.com/proofit404/anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;;----------------------------------------------------------------------
;; Alternatives for highlight indentation:
;; https://github.com/DarthFennec/highlight-indent-guides.
;; https://github.com/antonj/Highlight-Indentation-for-Emacs

;; To disable highlight-indentation for Python do
;;   M-x highlight-indentation-mode.
;; To disable permanently:
;;   M-x customize-variable RET elpy-modules RET
;; and disable checkbox. Apply and save.

;; This uses `highlight-indentation` package.
;; Disable it in Python.
(add-hook 'python-mode-hook
          '(lambda () (highlight-indentation-mode 0)) t)
;; (highlight-indentation-current-column-mode)
;; (set-face-background 'highlight-indentation-face "#990000")

;;----------------------------------------------------------------------
;; Display possible completions at all places
; (use-package ido-completing-read+
;   :ensure t
;   :config
;   ;; This enables ido in all contexts where it could be useful, not just
;   ;; for selecting buffer and file names
;   (ido-mode t)
;   (ido-everywhere t)
;   ;; This allows partial matches, e.g. "uzh" will match "Ustad Zakir Hussain"
;   (setq ido-enable-flex-matching t)
;   (setq ido-use-filename-at-point nil)
;   ;; Includes buffer names of recently opened files, even if they're not open now.
;   (setq ido-use-virtual-buffers t)
;   :diminish nil)
;;----------------------------------------------------------------------
;; Enhance M-x to allow easier execution of commands
(use-package smex
  :ensure t
  ;; Using counsel-M-x for now. Remove this permanently if counsel-M-x works better.
  :disabled t
  :config
  (setq smex-save-file (concat user-emacs-directory ".smex-items"))
  (smex-initialize)
  :bind ("M-x" . smex))
;;----------------------------------------------------------------------
; (when (not (package-installed-p 'geiser-mit))
;  (package-install 'geiser-mit))
; (require 'geiser-mit)

(use-package geiser
  :config
  ;; (setq geiser-default-implementation 'gambit)
  (setq geiser-default-implementation 'mit)
  (setq geiser-active-implementations '(mit))
  ;(setq geiser-repl-default-port 44555) ; For MIT Scheme
  ;(setq geiser-implementations-alist '(((regexp "\\.scm$") mit)
  ;                                     ((regexp "\\.sld") mit)))
  )

;;----------------------------------------------------------------------
(use-package cc-mode
  :mode
  (("\\.h\\'" . c-mode)
   ("\\.c\\'" . c-mode)
   ("\\.hpp\\'" . c++-mode)
   ("\\.cpp\\'" . c++-mode))
  :config
  (add-to-list 'magic-mode-alist
               `(,(lambda ()
                    (and (string= (file-name-extension (or (buffer-file-name) "")) "h")
                         (or (re-search-forward "#include <\\w+>"
                                                magic-mode-regexp-match-limit t)
                             (re-search-forward "\\W\\(class\\|template\\namespace\\)\\W"
                                                magic-mode-regexp-match-limit t)
                             (re-search-forward "std::"
                                                magic-mode-regexp-match-limit t))))
                 . c++-mode))
  (use-package cff :ensure t)
  ;; subword-mode, e.g., someThing is treated as two words
  (add-hook 'c-mode-common-hook '(lambda () (subword-mode 1)))
  (use-package srefactor
    :ensure t)
  (add-hook 'c-mode-hook
            '(lambda ()
               (c-set-style "linux")
               (setq c-basic-offset 8)
               ;; Make TAB equivilent to 8 spaces
               (setq tab-width 8)))
  (defun c-lineup-arglist-tabs-only (ignored)
    "Line up argument lists by tabs, not spaces"
    (let* ((anchor (c-langelem-pos c-syntactic-element))
           (column (c-langelem-2nd-pos c-syntactic-element))
           (offset (- (1+ column) anchor))
           (steps (floor offset c-basic-offset)))
      (* (max steps 1)
         c-basic-offset)))
  
  ;; Add Linux kernel style
  (add-hook 'c-mode-common-hook
            (lambda ()
              (c-add-style "linux-kernel"
                           '("linux" (c-offsets-alist
                                      (arglist-cont-nonempty
                                       c-lineup-gcc-asm-reg
                                       c-lineup-arglist-tabs-only))))))
  
  (defun linux-kernel-development-setup ()
    (let ((filename (buffer-file-name)))
      ;; Enable kernel mode for the appropriate files
      (when (and filename
                 (or (locate-dominating-file filename "Kbuild")
                     (locate-dominating-file filename "Kconfig")
                     (save-excursion (goto-char 0)
                                     (search-forward-regexp "^#include <linux/\\(module\\|kernel\\)\\.h>$" nil t))))
        ;; (setq indent-tabs-mode t)
        ;; (setq show-trailing-whitespace t)
        (c-set-style "linux-kernel")
        (message "Setting up indentation for the linux kernel"))))
  
  (add-hook 'c-mode-hook 'linux-kernel-development-setup)
  (add-hook 'c++-mode-hook
            '(lambda ()
  
               ;; Use stroustrup style
               (c-set-style "stroustrup")
  
               ;; Setting indentation lvel
               (setq c-basic-offset 4)
  
               ;; Make TAB equivilent to 4 spaces
               (setq tab-width 4)
  
               ;; Use spaces to indent instead of tabs.
               (setq indent-tabs-mode nil)
  
               ;; Indent the continuation by 2
               (setq c-continued-statement-offset 2)
  
               ;; Brackets should be at same indentation level as the statements they open
               ;; for example:
               ;;                 if (0)        becomes        if (0)
               ;;                     {                        {
               ;;                        ;                         ;
               ;;                     }                        }
               (c-set-offset 'substatement-open 0)
  
               ;; make open-braces after a case
               (c-set-offset 'case-label '+)
  
               ;; Not indent code inside a namespace
               ;; for example:
               ;;                namespace A {
               ;;
               ;;                int namespace_global_variable;
               ;;
               ;;                class Class {
               ;;
               ;;                Class();
               ;;                //...
               ;;                };
               ;;
               ;;                }
               (c-set-offset 'innamespace 0)
               ))
  (bind-keys :map c-mode-base-map
             ("C-c '" . my/narrow-or-widen-dwim)
             ("C-c C-c" . compile)
             ("C-c C-g" . gdb)
             ("C-c C-o" . cff-find-other-file))
  
  ;; Some keys may override global map add here
  (bind-keys :map c-mode-base-map
             ("M-." . helm-gtags-dwim)
             ("M-," . helm-gtags-pop-stack)))


(defun code-compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
     (let ((file (file-name-nondirectory buffer-file-name)))
       (format "%s -o %s %s"
           (if  (equal (file-name-extension file) "cpp") "g++" "gcc" )
           (file-name-sans-extension file)
           file)))
    (compile compile-command)))

(global-set-key [f9] 'code-compile)

;;----------------------------------------------------------------------

;;; Import the shell environment
;;;
;; Import some shell environment variables into Emacs at launch. Steve
;; Purcell's exec-path-from-shell imports PATH and MANPATH by default;
;; LANG, TEXINPUTS and BIBINPUTS are added here. You can customize
;; 'exec-env-from-shell-variables' in site-start.el or the user's
;; config file.

(when (not (package-installed-p 'exec-path-from-shell))
  (package-install 'exec-path-from-shell))

(require 'exec-path-from-shell)
(nconc exec-path-from-shell-variables '("LANG" "TEXINPUTS" "BIBINPUTS"))
(exec-path-from-shell-initialize)
;;----------------------------------------------------------------------
;;;
;;; tabbar
;;;
;; Start with (tabbar-mode) in ~/.emacs
;; Toggle with (tabbar-mode -1)
;; tabbar v2.2 was cloned from https://github.com/dholm/tabbar
;; tabbar-mode's inclusion in Vincent's distribution is maintained by 
;; Rodney Sparapani <rsparapa@mcw.edu>
(when (not (package-installed-p 'tabbar))
  (package-install 'tabbar))

(require 'tabbar)

(defun tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (list
   (cond
    ((member (buffer-name) '("*GNU Emacs*" "*ESS*" "*Messages*" "*Warnings*"))
     "Bury" )
    ((member (buffer-name) '("*S+6*" "*R*" "*R:2*" "*R:3*" "*R:4*" "*R:5*" "*R:6*" "*R:7*" "*R:8*" "*R:9*"))
     "ESS[R]" ) 
    ((string-match "\*R:.*\*" (buffer-name)) "ESS[R]" ) 
    ((memq major-mode '(ess-help-mode ess-transcript-mode)) "ESS[R]" )
    ((member mode-name '("ESS[LST]")) "ESS[LST]" )
   ((or (get-buffer-process (current-buffer))
         ;; Check if the major mode derives from `comint-mode' or
         ;; `compilation-mode'.
         (tabbar-buffer-mode-derived-p
          major-mode '(comint-mode compilation-mode)))
     "Process" )
    ((member (buffer-name) '("*shell*")) "Process" )
    ((memq major-mode '(Man-mode fundamental-mode)) "Process" )
    ((member (buffer-name) '("*scratch*")) "Emacs-Lisp" )
    ((eq major-mode 'dired-mode) "Dired" )
    ((member (buffer-name) '("*GNU Emacs*")) "Emacs-Lisp" )
    ((memq major-mode '(help-mode apropos-mode Info-mode)) "Emacs-Lisp" )
    ((memq major-mode
           '(rmail-mode
             rmail-edit-mode vm-summary-mode vm-mode mail-mode
             mh-letter-mode mh-show-mode mh-folder-mode
             gnus-summary-mode message-mode gnus-group-mode
             gnus-article-mode score-mode gnus-browse-killed-mode))
     "Mail" )
    ((or     
     (member mode-name '("DocView"))
;             '("LaTeX" "DocView"))
     (member (buffer-name) '("*TeX Help*"))
     (memq major-mode '(plain-tex-mode latex-mode bibtex-mode)))
     "LaTeX" )
    (t
     ;; Return `mode-name' if not blank, `major-mode' otherwise.
     (if (and (stringp mode-name)
              ;; Take care of preserving the match-data because this
              ;; function is called when updating the header line.
              (save-match-data (string-match "[^ ]" mode-name)))
         mode-name
       (symbol-name major-mode))
     ))))
