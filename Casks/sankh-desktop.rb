# Rendered by .github/workflows/desktop-release.yml and pushed to
# sankh-dev/homebrew-tap as Casks/sankh-desktop.rb. Edit the template, not the tap.
cask "sankh-desktop" do
  arch arm: "aarch64", intel: "x64"

  version "0.8.0"
  sha256 arm:   "fa5cea3acdd9ecf87804d52633a1b92f3d79c1cbb125f6ae9aefd0694824e232",
         intel: "9857757f1d8aa17f11201665e262bbdedaa835e4c3d28500db78a972b5a5406a"

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
