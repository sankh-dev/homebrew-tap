class Sankh < Formula
  desc "Blow the conch. Run your APIs. A folder of curl files as an API collection."
  homepage "https://sankh.dev"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.6.1/sankh-aarch64-apple-darwin.tar.xz"
      sha256 "9221f7991df714ae2972b6206bd83b9b5c7c3968aa936eced87f3f9c8254c3a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.6.1/sankh-x86_64-apple-darwin.tar.xz"
      sha256 "ecf81ca348fe57f8f36073f9070ec7895367a39815d0715c1ac2ff9a71b24e79"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.6.1/sankh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0d99ef2cc644a8d9d364d937806d7896c07432f8dd48bd65a23b77a5e585ccda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.6.1/sankh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0980dcb65492f02a31c318fd221f3894c94d339b7a9f3e29c0f0ae15636c2b22"
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
