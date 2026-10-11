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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.13/impact-0.11.13-aarch64-apple-darwin.tar.gz"
      sha256 "2672907531c620f18d6d49d52b9a26c093dff77869b19d677887e52a311b43fb"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.13/impact-0.11.13-x86_64-apple-darwin.tar.gz"
      sha256 "cff546d63056d43a36051546eafde3932a2cad7159c9d95c47dea302a0299ff8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.13/impact-0.11.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bd70e8a16a91e6c672f3536469a9fc3444ccdc0e8cfc956ae71fcb9ef5f1e59f"
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
