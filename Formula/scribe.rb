# Homebrew formula for scribe.
# Install:
#   brew tap overseers-desk/od
#   brew install scribe
#
# NOTE: scribe runs without configuration as a dictation tool, but its Linux
# runtime is still incomplete on macOS: it shells out to dotool (uinput
# keystrokes), parecord (PulseAudio), and wl-copy (Wayland clipboard), and the
# optional style pass needs the json/yaml (tcllib) and tls Tcl packages. This
# formula installs cleanly so the tap is usable; the macOS port — native paste
# via Cmd+V, pbcopy, a mic backend — is tracked separately.

class Scribe < Formula
  desc "Take dictation or clipboard text, restyle it, and type/paste it back"
  homepage "https://github.com/overseers-desk/scribe"
  url "https://github.com/overseers-desk/scribe/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "8bd7396b3acf7a569a70ae5ae3ee7e82ebcf7dab9ad3ac19332ad229fc6b467b"
  license "GPL-3.0-only"

  depends_on "tcl-tk"

  def install
    # scribe.tcl finds its sibling config/data via APP_DIR = dirname of the
    # normalised [info script]. Install the script alongside its data in pkgshare
    # and symlink it onto PATH; file normalize resolves the symlink, so APP_DIR
    # lands in pkgshare where the data lives. deepseek.json is user-supplied (not
    # shipped) and current-mode.conf is runtime state, so neither is installed.
    pkgshare.install "scribe.tcl", "styles", "system-prompts.yaml",
                     "dialect-us-to-british.tsv", "config.example.toml"

    # Pin the shebang to Homebrew's keg-only wish9.0 (tcl-tk is not on PATH, so
    # #!/usr/bin/env wish9.0 would not resolve).
    wish = Formula["tcl-tk"].opt_bin/"wish9.0"
    inreplace pkgshare/"scribe.tcl" do |s|
      s.sub!(/\A#![^\n]*/, "#!#{wish}")
    end
    chmod 0755, pkgshare/"scribe.tcl"
    bin.install_symlink pkgshare/"scribe.tcl" => "scribe"
  end

  test do
    assert_path_exists pkgshare/"scribe.tcl"
    assert_match "wish9.0", File.read(pkgshare/"scribe.tcl").lines.first
  end
end
