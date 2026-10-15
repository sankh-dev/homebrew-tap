# Rendered by .github/workflows/desktop-release.yml and pushed to
# sankh-dev/homebrew-tap as Casks/sankh-desktop.rb. Edit the template, not the tap.
cask "sankh-desktop" do
  arch arm: "aarch64", intel: "x64"

  version "0.9.1"
  sha256 arm:   "46602cf2752e2667cf3a25b60a055a8fcc436c558eade77ea5112106cf8aaf36",
         intel: "d7ead1c9018919ee7ac2fea3018a6600e3049fc05ca7ac6aaa8a8b1d856cd979"

  url "https://github.com/sankh-dev/sankh/releases/download/v#{version}/Sankh_#{version}_#{arch}.dmg"
  name "Sankh"
  desc "Lightweight request manager where each request is a curl script"
  homepage "https://sankh.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Sankh.app"

  # The app is not code signed or notarized yet; without this Gatekeeper
  # refuses to open it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Sankh.app"]
  end

  # The workspace, trust store and Scratch live in ~/Library/Application Support/sankh
  # and are shared with the `sankh` CLI, so they are deliberately not removed.
  zap trash: [
    "~/Library/Application Support/dev.sankh.app",
    "~/Library/Caches/dev.sankh.app",
    "~/Library/Saved Application State/dev.sankh.app.savedState",
    "~/Library/WebKit/dev.sankh.app",
  ]

  caveats <<~EOS
    Sankh is not code signed yet. The quarantine flag is removed on install so
    macOS opens it without a Gatekeeper prompt.

    The app does not include the `sankh` command. For the CLI, run:
      brew install sankh-dev/tap/sankh
  EOS
end
