;;; obfuscate-mode.el --- Dynamically obfuscate text -*- lexical-binding: t -*-

;;; Commentary:
;; This minor mode obfuscates text in the buffer by dynamically replacing
;; characters using `font-lock` for improved performance and compatibility.

;;; Code:

(defgroup obfuscate-mode nil
  "Obfuscate text in the current buffer."
  :group 'editing
  :prefix "obfuscate-mode-")

(defcustom obfuscate-mode-obfuscation-character "\u25A1"
  "The character used to replace obfuscated text. Default is a hollow square (\u25A1)."
  :type 'string
  :group 'obfuscate-mode)

(defun obfuscate-mode--obfuscate-region (start end)
  "Apply obfuscation to text in the region from START to END."
  (save-excursion
    (goto-char start)
    (while (re-search-forward "[[:graph:]]" end t)
      (add-text-properties (match-beginning 0) (match-end 0)
                           `(display ,obfuscate-mode-obfuscation-character)))))

(defun obfuscate-mode--clear-region (start end)
  "Clear obfuscation in the region from START to END."
  (remove-text-properties start end '(display nil)))

(defun obfuscate-mode--apply-obfuscation (start end _length)
  "Hook function to obfuscate text dynamically.
START and END are the bounds of the change, and _LENGTH is unused."
  (when obfuscate-mode
    (obfuscate-mode--obfuscate-region start end)))

(defun obfuscate-mode--refresh-buffer ()
  "Refresh obfuscation for the entire buffer."
  (obfuscate-mode--clear-region (point-min) (point-max))
  (obfuscate-mode--obfuscate-region (point-min) (point-max)))

;;;###autoload
(define-minor-mode obfuscate-mode
  "Minor mode to obfuscate text in the current buffer."
  :lighter " Obfuscate"
  :group 'obfuscate-mode
  (if obfuscate-mode
      (progn
        (jit-lock-register #'obfuscate-mode--apply-obfuscation)
        (obfuscate-mode--refresh-buffer)
        (add-hook 'after-change-functions #'obfuscate-mode--apply-obfuscation nil t))
    (jit-lock-unregister #'obfuscate-mode--apply-obfuscation)
    (remove-hook 'after-change-functions #'obfuscate-mode--apply-obfuscation t)
    (obfuscate-mode--clear-region (point-min) (point-max))))

(provide 'obfuscate-mode)
;;; obfuscate-mode.el ends here
