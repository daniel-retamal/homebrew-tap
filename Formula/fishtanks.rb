class Fishtanks < Formula
  desc "An aquarium for your terminal: ASCII fishes, fishing, a shop, mutations, heaven, hell and computers made of fish."
  homepage "https://retam.al/fishtanks"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.1/fishtanks-aarch64-apple-darwin.tar.xz"
      sha256 "a69d7492a898a5d99e12cca85675124bfb60b82a19bd97d5e2eb4daf13e9622a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.1/fishtanks-x86_64-apple-darwin.tar.xz"
      sha256 "0fd79901740a55c4ff65d03684b713ec288b51420c58ef19dd0dc9bb7676dd94"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.1/fishtanks-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b83cd39188be22a4d4c0d20d80866338c2c7e2f5d55717bed8ba03b9fb2a4e9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/daniel-retamal/fishtanks/releases/download/v1.2.1/fishtanks-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d2a6e64f1b7ddf9521e319d39a93df74d686336f27519870e16a7afd54a96c3e"
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
