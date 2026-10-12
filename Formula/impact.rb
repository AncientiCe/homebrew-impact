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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.0/impact-0.12.0-aarch64-apple-darwin.tar.gz"
      sha256 "31ee3149557a582859fdb0afb831d8c654d9847f613ea6a74292c755020ef190"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.0/impact-0.12.0-x86_64-apple-darwin.tar.gz"
      sha256 "bbb1bf175836c44152e15fc4fe96bcc3909fa785838f12bcfc0343e0d162111e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.0/impact-0.12.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "acd005970bdb056e128572758d7c21c0cb788e1f0062b08b08a130fc7070e104"
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
