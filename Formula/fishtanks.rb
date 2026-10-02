class Fishtanks < Formula
  desc "An aquarium for your terminal: ASCII fishes, fishing, a shop, mutations, heaven, hell and computers made of fish."
  homepage "https://retam.al/fishtanks"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.1.0/fishtanks-aarch64-apple-darwin.tar.xz"
      sha256 "382d44644e6b1915e52d80f83a12adf33d301e4c54412dd517d6130367ac4421"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.1.0/fishtanks-x86_64-apple-darwin.tar.xz"
      sha256 "57f7d5aa28e5c40384b2a912fe9862516bfa894cf1200f8bfbf4c43b6fb1574c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.1.0/fishtanks-aarch64-unknown-linux-musl.tar.xz"
      sha256 "9c0764d00a28cb0363c9d6c58e401d2e303aafad629c4e8b6103337a45f55c75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.1.0/fishtanks-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7cb55b34acad6898521faa10438b4864e38ba772447b0f1ede7c63690f66130c"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "fishtanks"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fishtanks"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fishtanks"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fishtanks"
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
