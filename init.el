(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")
                         ("org" . "http://elpa.emacs-china.org/org/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;;;;;;;;;;;;;;;;;;;; only first init use ;;;;;;;;;;;;;;;;;;;;

(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; (eval-when-compile
;;   require 'use-package)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (DeepBrain)))
 '(custom-safe-themes
   (quote
    ("7ba45f2860c5357b9e4b1ec8e1f5cf1aa61d3ce3d46236f3cfac7ffbb6746321" "6f9af507f40ee46c4fcc9d813d3145a8c5f1b5ab7ce6c989879a9fa38b4d68e5" default)))
 '(package-selected-packages
   (quote
    (doom-themes doom-modeline imenu-list lsp-python-ms lsp-ui auto-package-update lsp-ivy flycheck lsp-treemacs treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil dap-hydra yaml-mode yasnippet-snippets diminish evil-mc evil-matchit evil-goggles evil-escape evil-surround evil dap-java dap-mode lsp-java company-lsp lsp-mode yasnippet whitespace-cleanup-mode whitespace-cleanup general wgrep expand-region undo-tree which-key evil-nerd-commenter ace-pinyin key-seq youdao-dictionary smex magit company-flx company counsel-projectile counsel-tramp ivy-hydra hydra avy counsel ivy use-package))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "SF Mono" :foundry "nil" :slant normal :weight light :height 161 :width normal)))))



;;;;;;;;;;;;;;;;; only need with Windows System ;;;;;;;;;;;;;;;;;;;;;
(when (string-equal system-type "windows-nt")
  (dolist (charset '(kana han cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family "Microsoft YaHei" :size 16))))

;; 不限制换行符且不拆分单词换行
;; (global-visual-line-mode t)

;; 当一行显示不下时会自动拆分行，在行尾会显示箭头，可选显示样式如下：
;; ("default" . nil)
;; ("no-fringes" . 0)
;; ("right-only" . (0 . nil)
;; ("left-only" . (nil . 0)
;; ("half-width" . (4 . 4)
;; ("minimal" . (1 . 1)
(fringe-mode '(1 . 1))

;; 完全关闭声音或闪屏提醒
(setq ring-bell-function 'ignore)

;; insert mode use emacs keybinding (must be in all evil before)
;; (setq evil-disable-insert-state-bindings t)

;; evil-mode disable TAB and C-i evil-jump-forward function (must be in all evil before)
;; (setq evil-want-C-i-jump nil)

;; defalias function
;; (defalias 'split-window-below 'split-window-right)
(defalias 'yes-or-no-p 'y-or-n-p)

;; 修改 evil undo 粒度，类似 emacs 按每步 undo
;; (setq evil-want-fine-undo t)

;; 关闭启动页面
(setq inhibit-startup-screen t)

;; split window always right not below
;; (setq split-width-threshold 0)
;; (setq split-height-threshold nil)

;; (setq display-buffer-in-side-window t)

;; disable sound Notifications
(setq ring-bell-function 'ignore)

;; Hide tool bar
(tool-bar-mode -1)

;; Hide scroll bar
(toggle-scroll-bar -1)

;; Hide memu bar
(toggle-menu-bar-mode-from-frame -1)

;; stop create backup~ files
(setq make-backup-files nil)

;; stopo createing #autosave# files
(setq auto-save-default nil)

;; maximum frame on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; 选中内容可以被新内容替换掉
(delete-selection-mode t)

;; 自动补全括号
(electric-pair-mode t)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))


;;;;;;;;;;;;;;;;;; use-package ;;;;;;;;;;;;;;;;;;;;

(use-package smex :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-disable-insert-state-bindings t)          ;; insert mode use emacs keybinding (must be in all evil before)
  (setq evil-want-C-i-jump nil)                        ;; evil-mode disable TAB and C-i evil-jump-forward function (must be in all evil before)
  (setq evil-want-fine-undo t)                         ;; 修改 evil undo 粒度，类似 emacs 按每步 undo
  :config (evil-mode t))

(use-package counsel
  :ensure t
  :no-require t
  :diminish ivy-mode
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-on-del-error-function nil
        projectile-completion-system 'ivy
        ;; counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
        counsel-grep-base-command "rg -i -M 120 --heading --line-number --color never '%s' %s")
  (setq counsel-find-file-ignore-regexp "\\.projectile\\'")
  :bind (("\C-s" . swiper-isearch)
         ("\C-r" . swiper-isearch-backward)
         ;; ("C-r" . counsel-minibuffer-history)
         ("C-c C-r" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f1> i" . counsel-info-lookup-symbol)
         ("<f1> u" . counsel-unicode-char)
         ("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c k" . counsel-ag)
         ("C-c l" . counsel-locate)
         ("C-S-o" . counsel-rhythmbox)))

(use-package projectile
  :ensure t
  :no-require t
  ;; :diminish abbrev
  :diminish projectile-mode)

(use-package avy
  :ensure t
  :bind (("M-'" . avy-goto-char)
         ("M-g M-g" . avy-goto-line)))

(use-package hydra
  :ensure t
  :config
  (defhydra hydra-move
    (:body-pre ())
    "move"
    ("<escape>" nil)
    ("q" nil)
    ("n" next-line)
    ("p" previous-line)
    ("f" forward-char)
    ("b" backward-char)
    ("a" beginning-of-line)
    ("e" move-end-of-line)
    ("v" scroll-up-command)
    ;; Cnonverting M-v to V here by analogy.
    ("V" scroll-down-command)
    ;; ("j" avy-goto-char-timer)
    ("j" avy-goto-char-2)
    ("C-l" recenter-top-bottom)
    ("SPC" set-mark-command)
    ("x" exchange-point-and-mark "exchange point")
    ("w" kill-ring-save)
    ("y" yank)
    ("," beginning-of-buffer)
    ("." end-of-buffer)
    ("[" backward-paragraph)
    ("]" forward-paragraph))
  (defhydra hydra-scroll
    (:body-pre ())
    "Scroll Up&Down"
    ("f" scroll-up-command)
    ("e" evil-scroll-up)
    ("d" evil-scroll-down)
    ("b" scroll-down-command)
    ("u" evil-scroll-up)
    ("C-l" recenter-top-bottom)
    ("," beginning-of-buffer)
    ("." end-of-buffer)
    ("q" nil)))

(use-package ivy-hydra :ensure t)

(use-package counsel-tramp
  :ensure t
  :config
  ((string-equal system-type "darwin")
   (setq tramp-default-method "sshx"))
  ((string-equal system-type "windows-nt")
   (setq tramp-default-method "plink"))
  ((string-equal system-type "gnu/linux")
   (setq tramp-default-method "sshx"))
  (setq make-backup-file nil
        create-loockfiles nil)
  :bind ("C-x p" . counsel-tramp))

(use-package counsel-projectile
  :ensure t
  :config (counsel-projectile-mode t))

(use-package company
  :ensure t
  :no-require t
  :diminish company-mode
  :init (add-hook 'after-init-hook #'global-company-mode)
  :config
  (setq company-tooltip-align-annotations t
        company-transformers '(company-sort-by-occurrence)
        company-selection-wrap-around t
        company-dabbrev-ignore-case nil
        company-dabbrev-code-ignore-case nil
        company-dabbrev-code-ignore-case nil)
  (eval-after-load "company"
    (company-flx-mode +1))
  :bind
  (:map company-active-map
        (("\C-n" . company-select-next)
         ("\C-p" . company-select-previous)
         ("<tab>" . company-complete-common-or-cycle)
         ("TAB" . company-complete-common-or-cycle)
         ("S-TAB" . company-select-previous)
         ("<backtab>" . company-select-previous)
         )
        )
  )

(use-package company-flx :ensure t)
(use-package magit :ensure t)
(use-package youdao-dictionary :ensure t)
(use-package key-seq
  :ensure t
  :config
  (key-chord-mode t)
  (setq key-chord-two-keys-delay 0.3))
(use-package ace-pinyin
  :ensure t
  :no-require t
  :diminish ace-pinyin-mode
  :config (ace-pinyin-global-mode t))
(use-package which-key
  :ensure t
  :no-require t
  :diminish which-key-mode
  :config
  (which-key-mode t)
  (setq which-key-idle-delay 2.0))
(use-package undo-tree
  :ensure t
  :no-require t
  :diminish undo-tree-mode
  :config (global-undo-tree-mode t))
(use-package expand-region :ensure t)
(use-package wgrep :ensure t)
(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (nmap
   :prefix "SPC"
   :states '(normal visual)
   "<SPC>" 'counsel-M-x
   "<tab>" 'myfunc-switch-to-previous-buffer
   "bn"    'myfunc-next-user-buffer
   ;; "bi"    'counsel-imenu
   "bi"    'imenu-list-smart-toggle
   "kb"    'kill-buffer
   "bd"    'kill-this-buffer
   "bb"    'ivy-switch-buffer
   ;; "bp"    'counsel-projectile-switch-to-buffer
   "jc"    'avy-goto-char-2
   "jj"    'avy-goto-char-timer
   "fr"    'counsel-recentf
   "cy"    'evilnc-copy-and-comment-lines
   "cl"    'evilnc-quick-comment-or-uncomment-to-the-line
   "cp"    'evilnc-comment-or-uncomment-paragraphs
   "qq"    'save-buffers-kill-terminal
   "v"     'er/expand-region
   "ss"    'counsel-rg
   "nr"    'narrow-to-region
   "nd"    'narrow-to-defun
   "np"    'narrow-to-page
   "nw"    'widen
   "of"    'hydra-scroll/body
   "ob"    'hydra-scroll/body
   "md"    'bookmark-delete
   "mb"    'counsel-bookmark
   "fs"    'save-buffer
   "ff"    'counsel-find-file
   "fy"    'myfunc-copy-file-path
   "fe"    'myfunc-open-in-sublime
   "fd"    'myfunc-show-in-desktop
   "p"    'counsel-projectile-find-file
   "1"     'delete-other-windows
   ;; "2"     'split-window-right
   "2"     '(lambda () (interactive)(split-window-right) (other-window 1))
   "3"     'switch-to-buffer-other-window
   "4"     'find-file-other-window
   "0"     'delete-window
   ;; "lc"    'lsp-ui-doc-hide
   ;; "ls"    'lsp-ui-doc-show
   "tt"   'treemacs-select-window
   "t1"   'treemacs-delete-other-windows
   ;; "tt"   'treemacs
   "tb"   'treemacs-bookmark
   "tf"   'treemacs-find-file
   "tg"   'treemacs-find-tag
   "p"    'projectile-command-map))
(use-package whitespace-cleanup-mode
  :ensure t
  :no-require t
  :diminish whitespace-cleanup-mode
  :diminish eldoc-mode
  :config (global-whitespace-cleanup-mode t))
(use-package json
  :ensure t
  :config (add-hook 'json-mode-hook 'hs-minor-mode))
(use-package yasnippet
  :ensure t
  :no-require t
  :diminish yas-minor-mode
  :config
  (yas-global-mode t)
  ;; (setq yas-snippet-dirs
  ;;    '("~/.emacs.d/personal/yasnippet"))
  )
;; (require cc-mode)
(use-package lsp-mode
  :diminish lsp-mode
  :ensure t)
(use-package company-lsp
  :ensure t
  :config
  (company-lsp t)
  (push 'company-lsp company-backends))
(use-package lsp-ui
  :ensure t
  :config
  (lsp-ui-mode t)
  ;; (lsp-ui-doc-mode -1)
  (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-code-actions nil)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-sideline-update-mode 'point)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-max-width 80)
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-symbol-highlighting nil)  ;; 关闭当前光标下相同字符串高亮显示，经常显示串行（Windows），所以关闭。
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'java-mode-hook 'flycheck-mode))
(use-package lsp-java
  :ensure t
  :after lsp
  :config
  (add-hook 'java-mode-hook 'lsp))
(use-package lsp-ivy :ensure t)
(use-package flycheck
  :ensure t
  ;; :init
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (setq flycheck-highlighting-mode 'symbols)
  (setq flycheck-indication-mode 'left-fringe))

(use-package dap-mode
  :ensure t
  :config
  (dap-mode t)
  (dap-ui-mode t)
  (add-hook 'dap-stopped-hook
          (lambda (arg) (call-interactively #'dap-hydra))))
(use-package dap-java
  :after (lsp-java))
(use-package lsp-python-ms
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp))))  ;; or lsp-deferred
(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode t))
(use-package evil-escape
  :ensure t
  :no-require t
  :diminish evil-escape-mode
  :config
  (evil-escape-mode t)
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.15))
(use-package evil-goggles
  :ensure t
  :no-require t
  :diminish evil-goggles-mode
  :config (evil-goggles-mode t))
(use-package evil-matchit
  :ensure t
  :config (global-evil-matchit-mode t))
(use-package evil-mc
  :ensure t
  ;; :config (global-evil-mc-mode 1)
  )
(use-package evil-nerd-commenter
  :ensure t
  ;; :config (evilnc-default-hotkeys t)
  ;; :general (general-nmap "SPC ;" 'evilnc-comment-operator)   ;; general 设置快捷键不能正常工作。只能在此设置才工作
  :general (general-nmap "gc" 'evilnc-comment-operator)   ;; general 设置快捷键不能正常工作。只能在此设置才工作
  :bind (("C-;" . evilnc-comment-or-uncomment-lines)
         ;; ("C-c ;" . evilnc-comment-or-uncomment-lines)
         ("C-c y" . evilnc-copy-and-comment-lines)
         ("C-c p" . evilnc-comment-or-uncomment-paragraphs)))
(use-package yasnippet-snippets :ensure t)

(use-package treemacs
  :ensure t
  :defer t
  ;; :init
  ;; (with-eval-after-load 'winum
  ;;   (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
treemacs-file-event-delay              5000
          ;; treemacs-file-extension-regex          treemacs-last-period-regex-value
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;; (treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ;; ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package lsp-treemacs
  :after treemacs
  :ensure t
  :config
  (lsp-treemacs-sync-mode 1)
  (lsp-metals-treeview-enable t)
  (setq lsp-metals-treeview-show-when-views-received t))
;; (use-package auto-package-update
;;   :ensure t
;;   :config
;;   (setq auto-package-update-delete-old-versions t)
;;   (setq auto-package-update-hide-results t)
;;   (auto-package-update-maybe))

(use-package imenu-list :ensure t)

;; (use-package exec-path-from-shell
;;   :ensure t
;;   :init
;;   (exec-path-from-shell-initialize))

(use-package doom-modeline
      :ensure t
      ;; :hook (after-init . doom-modeline-mode)
      )

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; (load-theme 'doom-one t)
  )

;;   ;; Enable flashing mode-line on errors
;;   ;; (doom-themes-visual-bell-config)
  
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;   (doom-themes-treemacs-config)
  
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))


;;;; 改为 use-package 中实现
;; (use-package diminish
;;   :ensure t
;;   :config
;;   (when (require 'diminish nil 'noerror)
;;     (eval-after-load "company"
;;       ;; '(diminish 'company-mode (if (display-graphic-p) " ❃" " *")))
;;       '(diminish 'company-mode))
;;     (eval-after-load "ivy"
;;       '(diminish 'ivy-mode))
;;     (eval-after-load "yasnippet"
;;       '(diminish 'yas-minor-mode))
;;     (eval-after-load "which-key"
;;       '(diminish 'which-key-mode))
;;     (eval-after-load "ace-pinyin"
;;       '(diminish 'ace-pinyin-mode))
;;     (eval-after-load "undo-tree"
;;       '(diminish 'undo-tree-mode))
;;     (eval-after-load "evil-goggles"
;;       '(diminish 'evil-goggles-mode))
;;     (eval-after-load "Eldoc"
;;       '(diminish 'eldoc-mode))
;;     (eval-after-load "Global-Eldoc"
;;     '(diminish 'global-eldoc-mode))
;;     (eval-after-load "evil-escape"
;;     '(diminish 'evil-escape-mode))
;;     (eval-after-load "visual-line"
;;       '(diminish 'visual-line-mode))
;;     ;; (eval-after-load "WSC! whitespace-cleanup-mode"
;;     ;;   '(diminish 'whitespace-cleanup-mode))
;;     (eval-after-load "whitespace-cleanup-mode"
;;       '(diminish 'whitespace-cleanup-mode))
;;     (eval-after-load "Projectile"
;;       '(diminish 'projectile-mode))
;;     ))


;;;;;;;;;;;;; Custom Package Funtions ;;;;;;;;;;;;;;

(define-key lsp-ui-mode-map
    [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map
    [remap xref-find-references] #'lsp-ui-peek-find-references)

;; 关闭光标闪烁
(blink-cursor-mode 0)

;; (setq projectile-globally-ignored-files (append '("*.txt" "*.o" "*.so" "*.project") projectile-globally-ignored-files))
;; (add-to-list 'projectile-globally-ignored-directories "target")

;; (dap-register-debug-template "My Runner"
;;                              (list :type "java"
;;                                    :request "launch"
;;                                    :args ""
;;                                    :vmArgs "-ea"
;;                                    :projectName"demo"
;;                                    :mainClass "com.monster.demo.DemoApplication"))

(dap-register-debug-template "Java Run Demo"
                             (list :type "java"
                                   :request "launch"
                                   :args ""
                                   :cwd nil
                                   :stopOnEntry :json-false
                                   :host "localhost"
                                   :request "launch"
                                   :modulePaths (vector)
                                   :classPaths nil
                                   :name "Run Configuration"
                                   :projectName "demo"
                                   :mainClass "com.monster.demo.DemoApplication"))


;; (require 'lsp-java-boot)

;; to enable the lenses
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)

;; 保存时将 tab 转成空格
(add-hook 'before-save-hook (lambda () (untabify (point-min) (point-max))))
;; (add-hook 'window-size-change-functions 'my-set-mini-window-height)

;; imenu-list 模式关闭 evil 使用 emacs 按键绑定
(add-to-list 'evil-insert-state-modes 'imenu-list-major-mode)
(setq imenu-list-focus-after-activation t)
(setq imenu-list-size 0.2)

;; (when (version<= "26.0.50" emacs-version )
;;   (global-display-line-numbers-mode))


;;;;;;;;;;;;;;;;; Keybinding ;;;;;;;;;;;;;;;;;

;; unkeybinding
(global-unset-key (kbd "C-\\"))
(global-unset-key (kbd "C-z"))

;; key-seq
(key-seq-define-global ";s" 'save-buffer)
(key-seq-define-global ";b" 'ivy-switch-buffer)
(key-seq-define-global ";d" 'kill-this-buffer)
(key-seq-define-global ";r" 'counsel-recentf)
(key-seq-define-global ";x" 'counsel-M-x)
(key-seq-define-global ";f" 'counsel-find-file)
(key-seq-define-global ";w" 'kill-ring-save)
(key-seq-define-global ";n" 'hydra-move/body)
(key-seq-define-global ";p" 'hydra-move/body)
(key-seq-define-global ";-" '"_")
(key-seq-define-global ";j" 'avy-goto-char-2)
(key-seq-define-global ";v" 'er/expand-region)
(key-seq-define-global ";1" 'delete-other-windows)
(key-seq-define-global ";2" 'split-window-right)
(key-seq-define-global ";3" 'switch-to-buffer-other-window)
(key-seq-define-global ";4" 'find-file-other-window)
(key-seq-define-global ";0" 'delete-window)
(key-seq-define-global ";e" 'counsel-bookmark)
(key-seq-define-global ";g" 'avy-goto-char-timer)
(key-seq-define-global ";p" 'projectile-command-map)
(key-seq-define-global ";i" 'imenu-list-smart-toggle)

(general-define-key
 :states 'normal
 "C-e"   'end-of-line
 "C-y"  #'yank
 "C-w"  #'kill-ring-save
 "C-o"  #'open-line
 "C-m"  #'newline
 "<DEL>" 'evil-delete-backward-char-and-join
 "gs"    'counsel-rg
 "gL"    'lsp-ui-doc-show
 "gl"    'lsp-ui-doc-hide
 "gt"    'xref-find-definitions
 ","     'evil-repeat-find-char-reverse
 "gh"    'hs-toggle-hiding
 )

(general-define-key
 :states 'visual
 "C-e"   'end-of-line
 "C-y"  #'yank
 "C-w"  #'kill-ring-save
 "C-o"  #'open-line
 "C-m"  #'newline
 )


(general-define-key
 "C-h"     'delete-backward-char
 "M-o"     'other-window
 "C-S-b"   'backward-sexp
 "C-S-f"   'forward-sexp
 "C-S-k"   'kill-sexp
 "<C-S-backspace>" 'backward-kill-sexp
 "C-S-SPC" 'mark-sexp
 "C-w" 'kill-ring-save
 "M-w" 'kill-region
 "M-x" 'counsel-M-x
 ;; "C-x C-f" 'counsel-find-file
 "C-c C-b" 'counsel-bookmark
 "C-c C-d" 'bookmark-delete
 ;; "M-g M-g" 'avy-goto-line
 ;; "C-;" '(evilnc-comment-or-uncomment-lines :which-key "comment lines")
 ;; "M-'" 'avy-goto-char                        ;avy
 "C-'" 'company-yasnippet
 ;; "M-g M-g" 'avy-goto-line            ;avy
 ;; "C-/" 'undo-tree-undo                       ;undo-tree
 ;; "C-?" 'undo-tree-redo                       ;undo-tree
 ;; "C-x u" 'undo-tree-visualizer-mode  ;undo-tree
 "M-;" 'my-comment-dwim
 "M-n" 'myfunc-new-empty-buffer
 "M-p" 'mark-paragraph
 ;; "M-[" 'backward-paragraph
 ;; "M-]" 'forward-paragraph
 "M-1"     'delete-other-windows
 "M-2"     '(lambda () (interactive)(split-window-right) (other-window 1))
 "M-3"     'switch-to-buffer-other-window
 "M-4"     'find-file-other-window
 "M-0"     'delete-window
 "M-/"     'completion-at-point
 )


;;;;;;;;;;;;;;; My Function ;;;;;;;;;;;;;;;

;; my funcation
(defun my-comment-dwim ()
  "Like `comment-dwim', but toggle comment if cursor is not at end of line.

URL `http://ergoemacs.org/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
  (interactive)
  (if (region-active-p)
      (comment-dwim nil)
    (let (($lbp (line-beginning-position))
          ($lep (line-end-position)))
      (if (eq $lbp $lep)
          (progn
            (comment-dwim nil))
        (if (eq (point) $lep)
            (progn
              (comment-dwim nil))
          (progn
            (comment-or-uncomment-region $lbp $lep)
            (forward-line )))))))

(defun myfunc-new-empty-buffer ()
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))


(defun myfunc-copy-file-path (&optional @dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
Result is full path.
If `universal-argument' is called first, copy only the dir path.

If in dired, copy the file/dir cursor is on, or marked files.

If a buffer is not file and not dired, copy value of `default-directory' (which is usually the “current” dir when that buffer was created)

URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
Version 2017-09-01"
  (interactive "P")
  (let (($fpath
         (if (string-equal major-mode 'dired-mode)
             (progn
               (let (($result (mapconcat 'identity (dired-get-marked-files) "\n")))
                 (if (equal (length $result) 0)
                     (progn default-directory )
                   (progn $result))))
           (if (buffer-file-name)
               (buffer-file-name)
             (expand-file-name default-directory)))))
    (kill-new
     (if @dir-path-only-p
         (progn
           (message "%s" (file-name-directory $fpath))
           (file-name-directory $fpath))
       (progn
         (message "%s" $fpath)
         $fpath )))))


(defun myfunc-next-user-buffer ()
  "Switch to the next user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (myfunc-user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))


(defun myfunc-previous-user-buffer ()
  "Switch to the previous user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (myfunc-user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))


(defun myfunc-user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
Typically, if buffer name starts with *, it's not considered a user buffer.
This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
You can override this function to get your idea of “user buffer”.
version 2016-06-18"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t
      )))

(defun myfunc-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))


(defun myfunc-open-in-sublime ()
  "Open the current file or `dired' marked files in Mac's TextEdit.
This command is for macOS only.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2017-11-21"
  (interactive)
  (let* (
         ($file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (format "subl \"%s\"" $fpath))) $file-list))))))


(defun myfunc-show-in-desktop ()
  "Show current file in desktop.
 (Mac Finder, Windows Explorer, Linux file manager)
 This command can be called when in a file or in `dired'.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2018-09-29"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name) default-directory )))
    (cond
     ((string-equal system-type "windows-nt")
      (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" $path t t)))
     ((string-equal system-type "darwin")
      (if (eq major-mode 'dired-mode)
          (let (($files (dired-get-marked-files )))
            (if (eq (length $files) 0)
                (progn
                  (shell-command
                   (concat "open " default-directory)))
              (progn
                (shell-command
                 (concat "open -R " (shell-quote-argument (car (dired-get-marked-files ))))))))
        (shell-command
         (concat "open -R " $path))))
     ((string-equal system-type "gnu/linux")
      (let (
            (process-connection-type nil)
            (openFileProgram (if (file-exists-p "/usr/bin/gvfs-open")
                                 "/usr/bin/gvfs-open"
                               "/usr/bin/xdg-open")))
        (start-process "" nil openFileProgram $path))
      ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. eg with nautilus
      ))))

(defun sql-indent-string ()
  "Indents the string under the cursor as SQL."
  (interactive)
  (save-excursion
    (er/mark-inside-quotes)
    (let* ((text (buffer-substring-no-properties (region-beginning) (region-end)))
           (pos (region-beginning))
           (column (progn (goto-char pos) (current-column)))
           (formatted-text (with-temp-buffer
                             (insert text)
                             (delete-trailing-whitespace)
                             (sql-indent-buffer)
                             (replace-string "\n" (concat "\n" (make-string column (string-to-char " "))) nil (point-min) (point-max))
                             (buffer-string))))
      (delete-region (region-beginning) (region-end))
      (goto-char pos)
      (insert formatted-text))))

;;;;;;;;;;;; System Enable Funtion ;;;;;;;;;;;;;


(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
