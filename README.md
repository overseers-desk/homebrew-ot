# homebrew-od

A Homebrew tap for the Overseer's Desk command-line tools. Tap it once, then install any tool:

```sh
brew trust overseers-desk/od
brew tap overseers-desk/od
brew install crude courier questlog
```

`brew tap overseers-desk/od` resolves to this repository (`overseers-desk/homebrew-od`) by Homebrew's naming convention, so no URL is needed.

## Formulae

- **crude:** CRUD-style command-line clients for sites without a public API.
- **courier:** email toolkit for AI assistants and command-line scripting.
- **majordomo:** Google Chat task reporting.
- **questlog:** GUI for finding, reading, and reopening past Claude Code sessions.
- **scribe:** hotkey dictation and clipboard restyling.

Each formula pulls its release tarball from the tool's own repository (or PyPI), so this tap holds no source code and cuts no releases of its own. A tool release is a single-formula edit here: bump the `url` and `sha256` in `Formula/<tool>.rb` after the tool's release is published.

The Overseer's Desk Claude Code plugins (skillbooks, holotapes) live in a separate marketplace at `overseers-desk/overseers-desk`.
