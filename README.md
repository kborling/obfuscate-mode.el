# Obfuscate Mode

`obfuscate-mode` is a lightweight Emacs minor mode that dynamically obfuscates text in a buffer. It is useful for hiding sensitive information or obfuscating text during presentations or while working in shared environments.

## Screenshot
![obfuscate mode](https://github.com/kborling/obfuscate-mode.el/blob/main/assets/obfuscate-mode.png)

## Features

- **Dynamic Obfuscation**: Only obfuscates visible portions of the buffer for optimal performance.
- **Customizable Obfuscation Character**: Choose the character used to obfuscate text.
- **Lightweight and Compatible**: Uses modern Emacs features like `jit-lock` and text properties to integrate smoothly with other functionality.

## Installation

1. Save `obfuscate-mode.el` to a directory in your Emacs `load-path`.
2. Add the following to your Emacs configuration:
   ```elisp
   (require 'obfuscate-mode)
   ```

## Usage

To enable `obfuscate-mode`, run:

```elisp
M-x obfuscate-mode
```

This will obfuscate all visible text in the current buffer. The obfuscation is dynamic, meaning it will automatically apply to newly visible regions as you scroll.

### Customization

You can customize the obfuscation character by setting `obfuscate-mode-obfuscation-character`:

```elisp
(setq obfuscate-mode-obfuscation-character "\u25A0") ; Solid square
```

The default obfuscation character is a hollow square (`▢`, Unicode `\u25A1`).

## Contributing

Pull requests are welcome :)

## License

`obfuscate-mode` is licensed under the MIT License. See the `LICENSE` file for details.

