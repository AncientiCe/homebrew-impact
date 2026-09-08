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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.7.0/impact-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "f6e12f136dcf838f54b11c7797163d57473de1cb4b4dd3c705de811d9c6547b4"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.7.0/impact-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "7ac698e8fdb5eee428138a036df2bf9c3995cd68ca129b80b07b1d2dea86d162"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.7.0/impact-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa0d941fadaf8962c43d24b566e53da546f78b53f014b69ae63f1690d7f585a3"
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
