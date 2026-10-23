class Fishtanks < Formula
  desc "An aquarium for your terminal: ASCII fishes, fishing, a shop, mutations, heaven, hell and computers made of fish."
  homepage "https://retam.al/fishtanks"
  version "1.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.6.2/fishtanks-aarch64-apple-darwin.tar.xz"
      sha256 "ca6ceebe3b4e7bd24e1a46452b869631db5a27039f610ce5008e3706975357e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.6.2/fishtanks-x86_64-apple-darwin.tar.xz"
      sha256 "f919c86374e75fee36942693770cb5bc1ec5253a4e5a94d624a2bd5a1be655c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.6.2/fishtanks-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c68fc744fcbe79759b182c0fb2bff1502e0a87f1dbb1d3bdf7409c8d8362c8e4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.6.2/fishtanks-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ca39a860d57fe82f1bed9ed45520debed62d7931ace2b5ed78506efa7d6cf918"
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
