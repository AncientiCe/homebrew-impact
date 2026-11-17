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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.6/impact-0.12.6-aarch64-apple-darwin.tar.gz"
      sha256 "d0ff541dc18e05695275fd9efde6cdd173b1442201481d0a37d5c5734b92dbff"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.6/impact-0.12.6-x86_64-apple-darwin.tar.gz"
      sha256 "8af732ba40bd3ece4b2d3671672af9e011c62a096fb866ad43c95a043edf3d2f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.6/impact-0.12.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "75f662e1c762e1653613acb178017ec628c7a8b5866ea2b894dcb47168c8929a"
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
