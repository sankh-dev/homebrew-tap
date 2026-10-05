class Sankh < Formula
  desc "Blow the conch. Run your APIs. A folder of curl files as an API collection."
  homepage "https://sankh.dev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.3.0/sankh-aarch64-apple-darwin.tar.xz"
      sha256 "170f7491252c5c1ca2de23929f970b0af1c957c80e1f4bb54d0e5147a8e05c67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.3.0/sankh-x86_64-apple-darwin.tar.xz"
      sha256 "2442227e13d03ebc5bcd001bbaacf2e9f6e343ff2988cf3bdcf798a6142582af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.3.0/sankh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b22474b9742d98daa338bd8e710f2a84d0e1b5a780cfa3a1e6ec7e3963755c89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.3.0/sankh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05b87efadcc2994f2c3239263d3eb8480c3636e4b1e5554e1554cb63d1860b12"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "sankh"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "sankh"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "sankh"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "sankh"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
