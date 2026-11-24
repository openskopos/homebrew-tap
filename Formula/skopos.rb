class Skopos < Formula
  desc "Command line tool for OpenSkopos documents: check, fmt, convert, import, ids, export, diff, history, trace, merge and render"
  homepage "https://openskopos.org"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/openskopos/openskopos/releases/download/v0.2.0/skopos-aarch64-apple-darwin.tar.xz"
      sha256 "615a12d4f51a83f681dfcb1b6b098d956072684079e355fb391fcecf5bf7192b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openskopos/openskopos/releases/download/v0.2.0/skopos-x86_64-apple-darwin.tar.xz"
      sha256 "5f3343fa55f085aa3364a44a1a6bc1bd24b0ad9fa52ad54ec65f09281b5f6ea3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/openskopos/openskopos/releases/download/v0.2.0/skopos-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2bf911da9e09319128bc3cfac9c2836dbafe028299f32fa81cd5efddbf005456"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openskopos/openskopos/releases/download/v0.2.0/skopos-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b0b0d053afc50653f6becda0b5096df2bef6bcfc9a9a9e6b5fe7a2e5252b0a6b"
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
