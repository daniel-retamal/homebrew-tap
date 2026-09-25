class Fishtanks < Formula
  desc "An aquarium for your terminal: ASCII fishes, fishing, a shop, mutations, heaven, hell and computers made of fish."
  homepage "https://retam.al/fishtanks"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.0.4/fishtanks-aarch64-apple-darwin.tar.xz"
      sha256 "b0b3e8def9a8a9ac234f0eecfa60bcfd7f6352208c2f638129352c4f665f2946"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.0.4/fishtanks-x86_64-apple-darwin.tar.xz"
      sha256 "4789f2948245fcebab8dce27ebafe6321bd8eaac17693f8f41af3b6758d8027b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.0.4/fishtanks-aarch64-unknown-linux-musl.tar.xz"
      sha256 "ec0ce3b546655c52dff9b3e5558055e52fda7082e00a3083d3831e3dae14f7d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.0.4/fishtanks-x86_64-unknown-linux-musl.tar.xz"
      sha256 "e48116137113d271b3cbf66dffc256fd41bba2b6063cd5cabeb4a971335531c1"
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
