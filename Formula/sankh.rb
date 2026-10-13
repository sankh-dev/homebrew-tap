class Sankh < Formula
  desc "Blow the conch. Run your APIs. A folder of curl files as an API collection."
  homepage "https://sankh.dev"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.8.0/sankh-aarch64-apple-darwin.tar.xz"
      sha256 "325294a5733aff28504709be503aa2201f192d85b608dfa13dec95c5ed5a56f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.8.0/sankh-x86_64-apple-darwin.tar.xz"
      sha256 "aa8d254b2142d4cb1708f27bdaa577008295dbcaba8261c8a4bc1f19025ef314"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.8.0/sankh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8ac999f506a6da095832ce31bfd3fcf19cf0788a629d2a9647038dbe74cb6020"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sankh-dev/sankh/releases/download/v0.8.0/sankh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d74304145af1fec73d27b797e6b420b8d736ead626de11e7b840c0b557d596e9"
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
