class Sankh < Formula
  desc "Blow the conch. Run your APIs. A folder of curl files as an API collection."
  homepage "https://sankh.dev"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.1.1/sankh-aarch64-apple-darwin.tar.xz"
      sha256 "257f56544973fa940307c490923bffdcd3bbc2c3d114c3005d0ab254f5c3b1ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.1.1/sankh-x86_64-apple-darwin.tar.xz"
      sha256 "8407aaaed6c0ec6c714a67ef8fc67018447e7897873efaa69cafdcac4c508743"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.1.1/sankh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0bd2e7d8a00f9daacfac62f87b847111282ed6d4ce2714f06c237731ca391353"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.1.1/sankh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a96adbd12b1395417b6b42a9b5c360b7f55c46997efa91f5ee76fdc8f58db27e"
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
