;;package設定
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;日本語環境設定
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8) 

;;skip op message
(setq inhibit-startup-message t)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;;no backup and auto save
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; 対応する括弧をハイライトする
 (show-paren-mode 1)

;; タイトルバーにファイルのフルパス表示
;; (setq frame-title-format
;;             (format "%%f - Emacs@%s" (system-name)))

;; カーソル位置の行数をモードライン行に表示する
(line-number-mode 1)

;; bufferの先頭でカーソルを戻そうとしても音をならなくする
(defun previous-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move (- arg))
    (beginning-of-buffer)))

;; bufferの最後でカーソルを動かそうとしても音をならなくする
(defun next-line (arg)
  (interactive "p")
  (condition-case nil
      (line-move arg)
    (end-of-buffer)))

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;; ;;背景色とかの設定
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-enabled-themes (quote (manoj-dark))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; shell-mode

;; ツールバー非表示
(tool-bar-mode -1)

;; メニューバーを非表示
(menu-bar-mode -1)

;; スクロールバー非表示
(set-scroll-bar-mode nil)

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;;C-zでundo
(define-key global-map (kbd "C-z") 'undo)

;; ;; IME初期化
;; ;(w32-ime-initialize)

;; ;; デフォルトIME
;; ;(setq default-input-method "W32-IME")

;; ;; IME変更
;; (global-set-key (kbd "C-\\") 'toggle-input-method)

;; ;; 漢字/変換キー入力時のエラーメッセージ抑止
;; (global-set-key (kbd "<M-kanji>") 'ignore)
;; (global-set-key (kbd "<kanji>") 'ignore)

;; テキストファイル／新規バッファの文字コード
(prefer-coding-system 'utf-8-unix)

;; ファイル名の文字コード
(set-file-name-coding-system 'utf-8)

;; サブプロセスのデフォルト文字コード
(setq default-process-coding-system '(undecided-dos . utf-8))

;; 環境依存文字 文字化け対応
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;;clipboard share
;; (cond (window-system
;;       (setq x-select-enable-clipboard t)
;;       ))

;; ;;to use xclip
;; ;(require 'xclip)
;; ;(xclip-mode 1)

;;フォントサイズを変えたいね

;;C-c C-cでwinのクリップボードへコピー
(defun wsl-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe"))

(global-set-key
 (kbd "C-c C-c")
 'wsl-copy)

;;(multi-)termでzshをデフォにする
(setq shell-file-name (executable-find "zsh"))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;;; elispディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elisp")

;;multi-termを読み込み
(require 'multi-term)
(setq multi-term-program shell-file-name)

;;C-c tでmulti-term呼び出し
(global-set-key (kbd "C-c t") '(lambda ()
                                 (interactive)
                                 (multi-term)))

;;tabbarの設定
(require 'tabbar)
(tabbar-mode)

(tabbar-mwheel-mode nil)                  ;; マウスホイール無効
(setq tabbar-buffer-groups-function nil)  ;; グループ無効
(setq tabbar-use-images nil)              ;; 画像を使わない


;;----- キーに割り当てる
(global-set-key (kbd "<M-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<M-left>") 'tabbar-backward-tab)


;;----- 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))


;;----- タブのセパレーターの長さ
(setq tabbar-separator '(2.0))


;;----- タブの色（CUIの時。GUIの時は後でカラーテーマが適用）
(set-face-attribute
 'tabbar-default nil
 :background "brightblue"
 :foreground "white"
 )
(set-face-attribute
 'tabbar-selected nil
 :background "#ff5f00"
 :foreground "brightwhite"
 :box nil
 )
(set-face-attribute
 'tabbar-modified nil
 :background "brightred"
 :foreground "brightwhite"
 :box nil
 )


;;----- 表示するバッファ
(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
                     ((string-match "*terminal<\\(.*\\)>*" (buffer-name b)) b) ; *terminal<.*>*バッファは表示する
                     ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
;;tabbar設定終わり

;;yatex設定
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
;;(setq tex-command "platex -synctex=1")
(setq tex-command "pdflatex -synctex=1")
(setq dvi2-command "xdvi")
(when (equal system-type 'darwin)     ;; for Mac only
  (setq dvi2-command "/usr/bin/open -a Skim")
  (setq tex-pdfview-command "/usr/bin/open -a Skim"))
(setq bibtex-command "pbibtex")
(setq dviprint-command-format "dvipdfmx")


(add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode -1))) ;; 自動で改行しない

;;C-c C-t (C-)jでplatex 3回dvipdfmx 1回
(setq tex-command "/usr/bin/tex2pdf")
;;
;; texファイルを開くと自動でRefTexモード
;;
;;(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook 'turn-on-reftex)

;;数式のラベル作成時にも自分でラベルを入力できるようにする
;; (setq reftex-insert-label-flags '("s" "sfte"))

;;reftexでeqrefを使う
;; \eqrefを使う
(setq reftex-label-alist
      '(
        (nil ?e nil "\\eqref{%s}" nil nil)
        ;; ("theo"  ?h "theo:"  "\\ref{%s}" t ("定理"))
        ;; ("axiom"  ?a "axiom:"  "\\ref{%s}" t ("公理"))
        ;; ("prop"  ?p "prop:"  "\\ref{%s}" nil ("命題"))
        ;; ("lem"   ?l "lem:"   "\\ref{%s}" nil ("補題"))
        ;; ("defi"  ?d "defi:"   "\\ref{%s}" nil ("定義"))
        ;; ("coro"  ?c "coro:"   "\\ref{%s}" nil ("系"))
        )
      )
;;参考:https://ubutun.blogspot.jp/2011/06/yatexreftex.html?m=1

;;yatex設定終わり

;;ここまで

