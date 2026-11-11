class Skopos < Formula
  desc "Command line tool for OpenSkopos documents: check, fmt, convert, import, ids, export and diff"
  homepage "https://openskopos.org"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/openskopos/openskopos/releases/download/v0.1.0/skopos-aarch64-apple-darwin.tar.xz"
      sha256 "d166ab65601c47c5839d319c2160864ef8956d987056187dbd374d2bc31c50d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openskopos/openskopos/releases/download/v0.1.0/skopos-x86_64-apple-darwin.tar.xz"
      sha256 "e2a26c713231a52091743bbee5b5fafa542e0f7bc0d963c48956a14b8c965733"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/openskopos/openskopos/releases/download/v0.1.0/skopos-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7b9ec6c8f9ed2bbe1c780c4c1cb834a2ff9e6cb893e69113a325b0d2f9ac3627"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openskopos/openskopos/releases/download/v0.1.0/skopos-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "57037be1ebdb65f0018c084f5d433791f2b49660f01038178ff1087a600e64e0"
    end
  end
  license "Apache-2.0"

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
      bin.install "skopos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "skopos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "skopos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "skopos"
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
