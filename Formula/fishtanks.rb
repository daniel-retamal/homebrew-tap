class Fishtanks < Formula
  desc "An aquarium for your terminal: ASCII fishes, fishing, a shop, mutations, heaven, hell and computers made of fish."
  homepage "https://retam.al/fishtanks"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.0/fishtanks-aarch64-apple-darwin.tar.xz"
      sha256 "276dc82b1c123d74a8113070f87faa96ddb12df641dc8484140511d1ee2f2b28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.0/fishtanks-x86_64-apple-darwin.tar.xz"
      sha256 "a5f9c47b5afe02241e4f811394773d612159a84b3dddf77214dbf584f513f7ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.0/fishtanks-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1d25d08602498cc23a397fb0f3122f801849a22d7361b670e1b78a53de396f22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.0/fishtanks-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9c84119e176cdab0e2a8d009a6aa871f9a172e815b7f8f2c7b13af12dd9c26e1"
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
