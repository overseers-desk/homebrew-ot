# homebrew-ot

A Homebrew tap for the overseer-toolbox standalone CLI tools. Tap it once, then install any tool:

```sh
brew tap overseers-desk/ot
brew install crude mailroom questlog
```

`brew tap overseers-desk/ot` resolves to this repository (`overseers-desk/homebrew-ot`) by Homebrew's naming convention, so no URL is needed.

## Formulae

- **crude:** CRUD-style command-line clients for sites without a public API.
- **mailroom:** email toolkit for AI assistants and command-line scripting.
- **questlog:** GUI for finding, reading, and reopening past Claude Code sessions.

Each formula pulls its release tarball from the tool's own repository, so this tap holds no source code and cuts no releases of its own. A tool release is a single-formula edit here: bump the `url` and `sha256` in `Formula/<tool>.rb` after the tool's GitHub release is published.

The Claude Code skills that some of these tools back live in a separate repository, the overseer-toolbox plugin at `overseers-desk/ot`.
