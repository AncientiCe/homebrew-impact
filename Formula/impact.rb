class Impact < Formula
  desc "Deterministic blast-radius CLI for code changes"
  homepage "https://github.com/AncientiCe/impact-rs"
  license "MIT"

  # Placeholder until the first tagged release (v0.1.0) runs .github/workflows/release.yml
  # in impact-rs, which chains into update-homebrew.yml to open a PR here with the real
  # per-platform URLs and sha256 checksums. `brew install` will fail with a checksum
  # mismatch until that PR merges — expected for a pre-release tap.

  on_macos do
    on_arm do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.1/impact-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "623dfe1150d2737eecb66832d4e1c4cb643145561717595602312f60653c89dc"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.1/impact-0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "cedaedbb8af855f70da18c6b605c77465e88fb5d91abc4201d3deae7b909b309"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.1/impact-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "163c75dce9503a1b41fd229973712e626f10870be1573b4abe0ca21c0d576442"
    end
  end

  def install
    # Homebrew auto-extracts and may strip a single top-level directory.
    if File.exist?("impact")
      bin.install "impact"
    else
      cd Dir["impact-*"].first do
        bin.install "impact"
      end
    end
  end

  def caveats
    <<~EOS
      impact has been installed successfully.

      Index a project, then query the blast radius of a file:
        impact index <project>
        impact query <file>

      Register the MCP server for an agent:
        claude mcp add impact -- impact mcp

      For more information: https://github.com/AncientiCe/impact-rs
    EOS
  end

  test do
    assert_match "impact #{version}", shell_output("#{bin}/impact --version")
  end
end
