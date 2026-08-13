;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Franta Bartik"
      user-mail-address "fb@franta.us")
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(when (doom-font-exists-p "Aporetic Sans Mono")
  (setq doom-font                (font-spec :name "Aporetic Sans Mono" :width 'regular :size 18 :slant 'normal)))
;; Emacs when launched in daemon doesn't set a font
(defun franta/load-fonts-in-client ()
  (setq doom-font                (font-spec :name "Aporetic Sans Mono" :width 'regular :size 18 :slant 'normal))
  (doom/reload-font))
(add-hook 'after-init-hook 'franta/load-fonts-in-client)

(when (doom-font-exists-p "ETBembo")
  (setq doom-variable-pitch-font (font-spec :name "ETBembo")))

(setq shell-file-name (executable-find "bash"))
;; (let* ((variable-tuple
;;          (cond ((doom-font-exists-p "ETBembo")         '(:font "ETBembo"))
;;                ((doom-font-exists-p "Source Sans Pro") '(:font "Source Sans Pro"))
;;                ((doom-font-exists-p "Lucida Grande")   '(:font "Lucida Grande"))
;;                ((doom-font-exists-p "Verdana")         '(:font "Verdana"))
;;                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
;;                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
;;         ;; (base-font-color     (face-foreground 'default nil 'default))
;;         )

;;    (custom-theme-set-faces
;;     'user
;;     `(org-meta-line ((t (,:slant italic))))
;;     `(org-level-8 ((t (,@variable-tuple))))
;;     `(org-level-7 ((t (,@variable-tuple))))
;;     `(org-level-6 ((t (,@variable-tuple))))
;;     `(org-level-5 ((t (,@variable-tuple))))
;;     `(org-level-4 ((t (,@variable-tuple :height 1.0))))
;;     `(org-level-3 ((t (,@variable-tuple :height 1.1))))
;;     `(org-level-2 ((t (,@variable-tuple :height 1.2))))
;;     `(org-level-1 ((t (,@variable-tuple :height 1.3 :weight semi-bold :slant normal :width regular))))
;;     `(org-document-title ((t (,@variable-tuple :height 1.5 :underline t :slant normal :weight semi-bold :width normal))))))



;; Hasklug doesn't work for Emacs for some reason, it makes the highlighted lines jump back on forth
;; (setq doom-font (font-spec :family "Hasklug Nerd Font" :size 16))
;; doom-variable-pitch-font (font-spec :family "Hasklug Nerd Font" :size 16))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'ef-melissa-dark)
;; (use-package! theme-changer
;;   :config
;;         (setq calendar-latitude 40)
;;         (setq calendar-longitude -83)
;;         (change-theme 'modus-operandi-tinted 'doom-pine)
;; )
;; (custom-theme-set-faces!
;; 'doom-feather-light
;; '(org-level-4 :inherit outline-4 :height 1.1)
;; '(org-level-3 :inherit outline-3 :height 1.2)
;; '(org-level-2 :inherit outline-2 :height 1.3)
;; '(org-level-1 :inherit outline-1 :height 1.4)
;; '(org-document-title :height 1.5 :underline nil))
;;(toggle-debug-on-error)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

(setq-default display-line-numbers-grow-only   t
              display-line-numbers-type        'relative
              display-line-numbers-width-start t)

(setq flycheck-disabled-checkers '(proselint))
(setq ispell-personal-dictionary "~/.config/doom/ispell.dictionary")

;; Set Emacs to open full screen

;; (setq initial-frame-alist '((top . 1) (left . 1) (width . 114) (height . 32)))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-agenda-hide-tags-regexp ".")

(setq org-directory "~/syncthing/org/")
;; (setq org-agenda-files (list "~/syncthing/org/inbox.org"
;;                              "~/syncthing/org/agenda.org"
;;                              "~/syncthing/org/projects.org"
;;                              "~/syncthing/org/work.org"
;;                              "~/git/organised_exchange/exchange.org"))
;; general org settings
(after! org
  ;; (custom-set-faces!
  ;;   '(org-level-2 :inherit outline-2 :height 1.3 :weight regular)
  ;;   '(org-level-1 :inherit outline-1 :height 1.4 :weight semi-bold)
  ;;   '(org-document-title :height 1.5 :underline t :slant normal :weight: semi-bold))
  (add-to-list 'org-tags-exclude-from-inheritance "project")
  (setq org-capture-templates
        `(
          ("i" "Inbox" entry  (file "~/syncthing/org/inbox.org")
           ,(concat "* TODO %?\n"
                    "/Entered on/ %U"))
          ("s" "Slipbox" entry  (file "~/syncthing/org/org-roam/inbox.org")
           ,(concat "* %?\n"
                    "/Entered on/ %U"))))
  (setq org-log-done 'time)
  (setq org-hide-emphasis-markers t)
  ;; (setq org-todo-keywords
  ;;       '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))

  ;; (defun log-todo-next-creation-date (&rest ignore)
  ;;   "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
  ;;   (when (and (string= (org-get-todo-state) "NEXT")
  ;;              (not (org-entry-get nil "ACTIVATED")))
  ;;     (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

  ;; (add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)
  (with-eval-after-load 'org (global-org-modern-mode))
  (custom-set-variables '(org-modern-table nil))
  )

                                        ; Automatic table of contents
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode)
      (add-hook 'markdown-mode-hook 'toc-org-mode))
  (warn "toc-org not found"))

(after! org-element
  (setq org-element-use-cache nil)
  )
;; org-roam settings
(setq org-roam-directory (file-truename "~/syncthing/org/org-roam"))
(after! org-roam
  (setq org-roam-db-location (file-truename "~/.org/org-roam.db"))
  (org-roam-db-autosync-mode) ;; Syncs the org-roam database on startup, will fail if emacs-sql doesn't exists yet. To fix, run the command manually

  (setq org-roam-capture-templates
        '(("d" "Docs Note" plain "%?"
           :if-new
           (file+head "docs/${slug}.org" "#+title: ${title}\n#+filetags: docs")
           :immediate-finish t
           :unnarrowed t)
          ("p" "Project Notes" plain "%?"
           :if-new
           (file+head "projects/${title}.org" "#+title: ${title}\n#+filetags: project")
           :immediate-finish t
           :unnarrowed t)
          ("w" "Work notes" plain "%?"
           :if-new
           (file+head "worknotes/${title}.org" "#+title: ${title}\n#+filetags: work")
           :immediate-finish t
           :unnarrowed t)
          ("n" "Personal Notes" plain "%?"
           :if-new
           (file+head "notes/${title}.org" "#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          )
        )
  (setq org-roam-dailies-directory "daily/")

  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
         (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))
  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} "
                (propertize "${tags:10}" 'face 'org-tag)
                )
        )
  )
(use-package! websocket
  :after org-roam)

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; consult-org-roam is a great utility that help search org-roam files
;; Settings are defaults with the exception of the keybinds
(use-package! consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key "M-.")
  (map! :leader
        :desc "Search in org-roam dir" :n "n r S" #'consult-org-roam-search
        :desc "Find a file in org-roam dir" :n "n r e" #'consult-org-roam-file-find
        :desc "Consult backlinks" :n "n r b" #'consult-org-roam-backlinks
        :desc "Consult backlinks (recursively)" :n "n r B" #'consult-org-roam-backlinks-recursive
        :desc "Consult forward links" :n "n r l" #'consult-org-roam-forward-links))

(defun no-line-numbers-hook ()
  (display-line-numbers-mode -1))
;; Something breaks in org-mode when hl-line-mode is turned on and can't figure out why
;; Disabling it for now using this method, not sure if it's the best but it works
(defun no-hl-line-hook ()
  (hl-line-mode -1))

;; (add-hook! 'org-mode-hook 'writeroom-mode 'no-line-numbers-hook 'no-hl-line-hook)
(add-hook! 'yaml-mode-hook 'flymake-yamllint-setup)

;; Auto revert (refresh actually, I don't understand the language here) files when they change
;; Enable autorevert globally so that buffers update when files change on disk.
;; Very useful when used with file syncing (i.e. syncthing)
(global-auto-revert-mode 1)
(setq auto-revert-use-notify t)
(setq auto-revert-verbose nil)

;; Using this library https://github.com/zzkt/metabrainz
(defun franta/org-insert-heading-from-musicbrainz-url (url)
  "Insert an Org heading with a link from a MusicBrainz URL at point."
  (interactive "sEnter MusicBrainz URL: ")
  (let* ((mbid (franta/extract-mbid-from-musicbrainz-url url))
         (result (when mbid
                   (musicbrainz-lookup "release-group" mbid "artists")))
         (names (franta/extract-artist-and-album-names result))
         (artist (car names))
         (album (cadr names))
         (heading-text (format "%s - %s" artist album))
         (org-heading (format "** [[%s][%s]]" url heading-text)))
    (insert org-heading)))

(defun franta/extract-mbid-from-musicbrainz-url (url)
  "Extract the MBID from a MusicBrainz URL."
  (if (string-match "/release-group/\\([a-f0-9-]+\\)" url)
      (match-string 1 url)
    (message "Invalid MusicBrainz URL")))

(defun franta/extract-artist-and-album-names-from-url (url)
  "Extract and print the artist and album names from a MusicBrainz URL."
  (interactive "sEnter MusicBrainz URL: ")
  (let* ((mbid (franta/extract-mbid-from-musicbrainz-url url))
         (result (when mbid
                   (musicbrainz-lookup "release-group" mbid "artists")))
         (names (franta/extract-artist-and-album-names result)))
    (when names
      (message "Artist: %s\nAlbum: %s" (car names) (cadr names)))))

(defun franta/extract-artist-and-album-names (result)
  "Extract the artist and album names from the musicbrainz-lookup result."
  (when result
    (let* ((artist-credit (cdr (assoc 'artist-credit result)))
           (artist-name (franta/extract-artist-name artist-credit))
           (album-name (cdr (assoc 'title result))))
      (list artist-name album-name))))
(defun franta/extract-artist-name (artist-credit)
  "Extract the artist name from the artist-credit part of the result."
  (when artist-credit
    (cl-some (lambda (credit)
               (when-let ((artist-info (cdr (assoc 'artist credit)))
                          (name (cdr (assoc 'name artist-info))))
                 name))
             artist-credit)))

;; Example usage:
;; (franta/extract-artist-and-album-names-from-url "https://musicbrainz.org/release-group/242741bf-182e-45d9-9276-5af8d1b31ad9")
(after! eglot
  (add-hook 'nix-mode-hook
            (lambda ()
              (setq eglot-workspace-configuration
                    '(:nil (:nix (:flake (:autoArchive t :autoEvalInputs t ))))))))

(use-package! exercism)
(use-package! magit-todos
  :after magit
  :config (magit-todos-mode 1))

(when (eq system-type 'darwin)
  (require 'acp)
  (require 'agent-shell)
  (setq agent-shell-anthropic-claude-environment
        (agent-shell-make-environment-variables
         "ANTHROPIC_API_KEY" ""
         "ANTHROPIC_MODEL" "qwen3-coder:30b"
         "ANTHROPIC_AUTH_TOKEN" "ollama"
         "ANTHROPIC_BASE_URL" "http://localhost:11434"))
  (setq agent-shell-session-strategy 'prompt)
  (setq agent-shell-preferred-agent-config (agent-shell-anthropic-make-claude-code-config))
  (use-package! agent-shell
    :config
    ;; Evil state-specific RET behavior: insert mode = newline, normal mode = send
    (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
    (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input)

    ;; Configure *agent-shell-diff* buffers to start in Emacs state
    (add-hook 'diff-mode-hook
	      (lambda ()
	        (when (string-match-p "\\*agent-shell-diff\\*" (buffer-name))
		  (evil-emacs-state))))))
;; (use-package! tramp-rpc
;;   :after tramp)
;; (defun chezmoi--evil-insert-state-enter ()
;;   "Run after evil-insert-state-entry."
;;   (chezmoi-template-buffer-display nil (point))
;;   (remove-hook 'after-change-functions #'chezmoi-template--after-change 1))

;; (defun chezmoi--evil-insert-state-exit ()
;;   "Run after evil-insert-state-exit."
;;   (chezmoi-template-buffer-display nil)
;;   (chezmoi-template-buffer-display t)
;;   (add-hook 'after-change-functions #'chezmoi-template--after-change nil 1))

;; (defun chezmoi-evil ()
;;   (if chezmoi-mode
;;       (progn
;;         (add-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter nil 1)
;;         (add-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit nil 1))
;;     (progn
;;       (remove-hook 'evil-insert-state-entry-hook #'chezmoi--evil-insert-state-enter 1)
;;       (remove-hook 'evil-insert-state-exit-hook #'chezmoi--evil-insert-state-exit 1))))
;; (add-hook 'chezmoi-mode-hook #'chezmoi-evil)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; (use-package uuid :commands uuid-string)
;; (defun uuid-string ()
;;   "Make a string form of a UUID directly."
;;   (uuid))
;; NOTE All meain functions are from here https://github.com/meain/dotfiles/blob/25863934a8bcab3e1075cf2f7564b1290b77d14b/emacs/.config/emacs/init.el#L2186
;; (customize-set-variable
;;  'tramp-password-prompt-regexp
;;  (concat
;;   "^.*"
;;   (regexp-opt
;;    '("passphrase"))))
;; (add-to-list 'tramp-connection-properties
;;              (list (regexp-quote "/ssh:fbartik@bastion2.osc.edu:")
;;                    "remote-shell" "/bin/bash"))
                                        ;r(use-package! plz)
;; (if (eq system-type 'darwin)
;;   (load "~/.hammerspoon/Spoons/editWithEmacs.spoon/hammerspoon.el")
;; )
;; (customize-set-variable 'tramp-encoding-shell "/bin/zsh")
;; (customize-set-variable
;;  'tramp-ssh-controlmaster-options
;;  (concat
;;  "-o ControlPath=/Users/fbartik/.ssh/cm-%%r@%%h:%%p "
;;  "-o ControlMaster=auto -o ControlPersist=yes"))
;; (customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
(setq tramp-verbose 6)
;; (setq tramp-terminal-type "tramp")
;; (setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>].* *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")
(add-to-list 'warning-suppress-log-types '(lsp-mode)) ;; Necessary because semgrep sends a message everytime it starts
(add-to-list 'warning-suppress-types '(lsp-mode))

(setq +evil-want-o/O-to-continue-comments nil)

;; mu4e
(add-to-list 'load-path "~/.nix-profile/share/emacs/site-lisp/mu4e")

(after! mu4e
  (setq mu4e-maildir "~/.mail")

  ;; Use msmtp for sending; --read-envelope-from lets msmtp select the right
  ;; account based on the From header automatically.
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)

  ;; Exclude [Gmail]/All Mail and Junk from unread/inbox views to avoid
  ;; duplicates (Gmail labels every Inbox message into All Mail too).
  (setq mu4e-bookmarks
        `((:name "Inbox"
           :query "maildir:/icloud/Inbox OR maildir:/gmail-fb/Inbox OR maildir:/gmail-oz/Inbox"
           :key ?i)
          (:name "Unread"
           :query "flag:unread AND NOT flag:trashed AND NOT maildir:\"/gmail-fb/Archive\" AND NOT maildir:\"/gmail-oz/Archive\" AND NOT maildir:\"/gmail-oz/Spam\" AND NOT maildir:\"/gmail-fb/Spam\""
           :key ?u)
          (:name "Today"
           :query "date:today..now"
           :key ?t)
          (:name "Last 7 days"
           :query "date:7d..now"
           :key ?w))))

;; Sign email
(setq mml-secure-openpgp-sign-with-sender t)

;; iCloud — primary/default account (t = default context)
(set-email-account! "icloud"
                    '((mu4e-sent-folder       . "/icloud/Sent")
                      (mu4e-drafts-folder     . "/icloud/Drafts")
                      (mu4e-trash-folder      . "/icloud/Deleted Messages")
                      (mu4e-refile-folder     . "/icloud/Archive")
                      (smtpmail-smtp-user     . "fb@franta.us")
                      (user-mail-address      . "fb@franta.us"))
                    t)

;; Gmail — frantabart
(set-email-account! "gmail-fb"
                    '((mu4e-sent-folder       . "/gmail-fb/Sent")
                      (mu4e-drafts-folder     . "/gmail-fb/Drafts")
                      (mu4e-trash-folder      . "/gmail-fb/Trash")
                      (mu4e-refile-folder     . "/gmail-fb/Archive")
                      (smtpmail-smtp-user     . "frantabart@gmail.com")
                      (user-mail-address      . "frantabart@gmail.com")))

;; Gmail — ozzfranta
(set-email-account! "gmail-oz"
                    '((mu4e-sent-folder       . "/gmail-oz/Sent")
                      (mu4e-drafts-folder     . "/gmail-oz/Drafts")
                      (mu4e-trash-folder      . "/gmail-oz/Trash")
                      (mu4e-refile-folder     . "/gmail-oz/Archive")
                      (smtpmail-smtp-user     . "ozzfranta@gmail.com")
                      (user-mail-address      . "ozzfranta@gmail.com")))

(load! "~/git/bird-mode/bird-mode.el")
(add-hook 'bird-mode-hook #'eglot-ensure)

(load! "~/git/emacs-eruby-mode/eruby-mode.el")

(use-package markdown-indent-mode :hook (markdown-mode . markdown-indent-mode))

(use-package! org-gtd
  :after org
  :init
  ;; Suppress upgrade warnings (must be set before package loads)
  (setq org-gtd-update-ack "4.0.0")
  ;; Set GTD directory before package loads
  (setq org-gtd-directory "~/syncthing/org/gtd/")

  :custom
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CNCL(c)")))
  (org-gtd-keyword-mapping '((todo . "TODO")
                             (next . "NEXT")
                             (wait . "WAIT")
                             (done . "DONE")
                             (canceled . "CNCL")))
  ;; Enable per-type refile prompting (recommended)
  ;; Without this, all items auto-refile to first target without prompting
  (org-gtd-refile-to-any-target nil)
  ;; GTD Horizon 2 areas of focus, prompted for during organize
  (org-gtd-areas-of-focus '("Work" "Learning" "Homelab" "DN42" "Emacs" "Nix"))
  ;; Widened to fit "Area ▸ Project" once both are combined below (default is 12)
  (org-gtd-prefix-width 24)
  ;; Predetermined effort estimates offered when prompted (still editable/free-form)
  (org-global-properties '(("Effort_ALL" . "0:15 0:30 1:00 2:00 4:00 8:00")))
  ;; Sort by effort (low first) within org-gtd's next-action/delegated blocks,
  ;; which are compiled as `tags-todo' blocks and read the `tags' strategy key.
  (org-agenda-sorting-strategy '((agenda habit-down time-up urgency-down category-keep)
                                 (todo   urgency-down category-keep)
                                 (tags   effort-up urgency-down category-keep)
                                 (search category-keep)))

  :config
  (org-edna-mode)
  ;; Prompt for tags, area of focus, and effort when organizing an item.
  ;; Effort is only prompted for actions/projects, not calendar/delegated/etc.
  (defun franta/org-gtd-set-effort ()
    (when (org-gtd-organize-type-member-p '(single-action project-heading))
      (org-set-effort)))
  (setq org-gtd-organize-hooks
        '(org-gtd-set-area-of-focus
          org-set-tags-command
          franta/org-gtd-set-effort))
  ;; Add org-gtd files to your agenda (in :config so org-gtd-directory is defined)
  (setq org-agenda-files (list org-gtd-directory))
  (setq org-gtd-save-after-organize t)

  ;; Show effort estimates in org-gtd agenda views (e.g. org-gtd-engage).
  ;; org-gtd's prefix DSL (project/area-of-focus fallback chain) has no
  ;; "effort" element, so append the standard org-agenda %e specifier to
  ;; whatever prefix string org-gtd builds for every view.
  (advice-add 'org-gtd-view-lang--expand-prefix :filter-return
              (lambda (format-string) (concat format-string "%-6e ")))

  ;; Show project name alongside (not instead of) area-of-focus. org-gtd's
  ;; prefix chain tries `project' before `area-of-focus' and stops at the
  ;; first non-nil result, so once a project resolves, area-of-focus is
  ;; never even checked. Combine both into one string at the source so the
  ;; chain still short-circuits correctly but returns "Area ▸ Project".
  (advice-add 'org-gtd-agenda--resolve-project :filter-return
              (lambda (project)
                (when project
                  (if-let ((area (org-gtd-agenda--resolve-area-of-focus)))
                      (format "%s ▸ %s" area project)
                    project))))

  ;; Fix org-gtd's area-of-focus lookup for project tasks: when a project
  ;; heading has no explicit CATEGORY set, plain `org-entry-get' silently
  ;; falls back to the file's base name (standard org behavior for the
  ;; special CATEGORY property), which org-gtd's project-lookup branch
  ;; doesn't guard against the way it guards the item's own category. That
  ;; makes a task look like it belongs to an area named after its file
  ;; (e.g. "org-gtd-tasks") instead of correctly resolving to nil.
  ;; (advice-add 'org-gtd-agenda--resolve-area-of-focus :override
  ;;             (lambda ()
  ;;               (cond
  ;;                ((org-gtd-agenda--has-explicit-category-p)
  ;;                 (let ((category (org-entry-get (point) "CATEGORY")))
  ;;                   (unless (string= category "???") category)))
  ;;                ((when-let* ((project-ids (org-entry-get-multivalued-property
  ;;                                            (point) org-gtd-prop-project-ids))
  ;;                             (first-id (car project-ids))
  ;;                             (project-marker (org-id-find first-id 'marker)))
  ;;                   (org-with-point-at project-marker
  ;;                     (when (org-gtd-agenda--has-explicit-category-p)
  ;;                       (org-entry-get (point) "CATEGORY")))))
  ;;                (t nil))))

  ;; Split the default engage view's "All actions ready to be executed"
  ;; block into effort-based sections (quick/medium/long/unestimated),
  ;; leaving the calendar/tickler/delegated blocks untouched.
  (advice-add 'org-gtd-engage-view-spec :filter-return
              (lambda (spec)
                (let ((new-blocks
                       (mapcan
                        (lambda (block)
                          (if (equal (alist-get 'name block)
                                     "All actions ready to be executed")
                              (list
                               '((name . "Quick wins (< 30 min)")
                                 (type . next-action)
                                 (effort . (< "0:30")))
                               '((name . "Medium (30 min - 2 hr)")
                                 (type . next-action)
                                 (effort . (between "0:30" "2:00")))
                               '((name . "Long (> 2 hr)")
                                 (type . next-action)
                                 (effort . (> "2:00")))
                               '((name . "No effort estimate")
                                 (type . next-action)
                                 (effort . nil)))
                            (list block)))
                        (alist-get 'blocks spec))))
                  (setf (alist-get 'blocks spec) new-blocks)
                  spec)))

  ;; Fix someday-review's window jumping between left/right on every "d"
  ;; (defer). --display-current-item calls plain `pop-to-buffer' with no
  ;; placement rule, and no popup rule matches its buffer name, so Emacs'
  ;; default window-selection heuristics pick inconsistently across the
  ;; kill-old/create-new buffer cycle on each item. Force it to always
  ;; reuse the current window instead.
  (advice-add 'org-gtd-someday-review--display-current-item :around
              (lambda (orig-fn &rest args)
                (cl-letf* ((real-pop-to-buffer (symbol-function 'pop-to-buffer))
                           ((symbol-function 'pop-to-buffer)
                            (lambda (buf &rest _)
                              (funcall real-pop-to-buffer
                                       buf '((display-buffer-reuse-window
                                              display-buffer-same-window))))))
                  (apply orig-fn args))))

  ;; Engage view excluding items tagged "work". org-gtd's tag filter DSL is
  ;; inclusion-only (OR match), so exclusion is done via org-agenda's own
  ;; org-agenda-tag-filter-preset, let-bound around the (block) agenda call.
  (defun franta/org-gtd-engage-no-work ()
    "Show the org-gtd engage view excluding items tagged \"work\"."
    (interactive)
    (let ((org-agenda-tag-filter-preset '("-work")))
      (org-gtd-engage)))

  ;; Work-only next actions, sorted by priority first (overrides the global
  ;; effort-based `tags' sort strategy just for this call).
  (defun franta/org-gtd-work-projects ()
    "Show all active Work next actions, sorted by priority."
    (interactive)
    (let ((org-agenda-sorting-strategy '((tags priority-down category-keep))))
      (org-gtd-view-show
       '((name . "My Work Items")
         (type . next-action)
         (area-of-focus . "Work")))))

  ;; Doom-style leader key bindings
  (map! :leader
        (:prefix ("1" . "org-gtd")
         :desc "Capture"                "c"  #'org-gtd-capture
         :desc "Engage"                 "e"  #'org-gtd-engage
         :desc "Engage (no work)"       "N"  #'franta/org-gtd-engage-no-work
         :desc "Engage (Work)"          "w"  #'franta/org-gtd-work-projects
         :desc "Command center"         "m"  #'org-gtd-command-center
         :desc "Process inbox"          "p"  #'org-gtd-process-inbox
         :desc "Show all next"          "n"  #'org-gtd-show-all-next
         :desc "Stuck projects"         "s"  #'org-gtd-reflect-stuck-projects))
  ;; Clarify map binding
  (map! :map org-gtd-clarify-mode-map
        :desc "Organize this item" "C-c c" #'org-gtd-organize)
  ;; Quick task actions in agenda view
  (map! :map org-agenda-mode-map
        :desc "GTD quick actions" "C-c ." #'org-gtd-agenda-transient))

(use-package! auth-source-1password
  :config
  (auth-source-1password-enable))

(setq circe-channel-users-count-threshold 0)
(setq circe-network-options
      '(("ZNC"
         :host "znc.franta.us"
         :port 6697
         :tls t
         :user "znc-admin@emacs/hackint"
         :pass (lambda (_)
                 (auth-source-pick-first-password
                  :host "ZNC"
                  :user "password")))))

;; Thought I needed this because of /WHO spam but it was just another client causing it
;; (after! circe
;;   (circe-set-display-handler "354" 'circe-display-ignore))

(add-to-list 'auto-mode-alist '("\\.just\\'" . just-mode))
(use-package! justl
  :config
  ;; justl doesn't support evil-mode yet: https://github.com/psibi/justl.el/issues/15
  (evil-define-key 'normal justl-mode-map
    (kbd "g") #'justl--refresh-buffer
    (kbd "e") #'justl-exec-recipe
    (kbd "E") #'justl-exec-shell
    (kbd "w") #'justl--exec-recipe-with-args
    (kbd "W") #'justl-no-exec-shell
    (kbd "m") #'justl--show-modules
    (kbd "?") #'justl-help-popup
    (kbd "h") #'justl-help-popup
    (kbd "RET") #'justl-go-to-recipe)
  (evil-define-key 'normal justl-module-mode-map
    (kbd "g") #'justl--module-refresh-buffer
    (kbd "e") #'justl-exec-module
    (kbd "o") #'justl--module-open-justl
    (kbd "?") #'justl-module-help-popup
    (kbd "h") #'justl-module-help-popup
    (kbd "RET") #'justl--go-to-module)
  (map! :leader (:prefix ("m" . "justl") :desc "exec-recipe" "e" #'justl-exec-recipe))
  (map! :map just-mode-map
        :leader
        "j" #'justl))
(use-package! ghostel
  :ensure t)
(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))
