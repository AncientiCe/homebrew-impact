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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.2.0/impact-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "159763b7b17d021ee3917b19ca5fe74b5dd0c56c9c955ea026f3fb6a332b83eb"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.2.0/impact-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "83166ef5d5943b56cb86989e7b00b762401d3cbe5ff0d37d8218fcc6a29ea8b6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.2.0/impact-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "93560aa2ae5b4db695ac05d941530ee6d642071b2b03976f6afa18f21c486476"
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
