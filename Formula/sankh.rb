class Sankh < Formula
  desc "Blow the conch. Run your APIs. A folder of curl files as an API collection."
  homepage "https://sankh.dev"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.4.0/sankh-aarch64-apple-darwin.tar.xz"
      sha256 "41bb56cd65f7f2a848f845273aafb006da2f0a0a4c88e9154091a4b59f233166"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.4.0/sankh-x86_64-apple-darwin.tar.xz"
      sha256 "379d182e335ac67cc79c7eaee99f2a02a2cfc690b0dc26997b832d4ba97f2245"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.4.0/sankh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "521d2226aaadc966b1b90d1a8f50e978dfa7d5cf24c488cf6d888e5c58e2679b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.4.0/sankh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6b30b81310f83751303126549beea6694eefe95e809612a54c4b7f3a9540f09c"
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
