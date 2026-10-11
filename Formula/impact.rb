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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.12/impact-0.11.12-aarch64-apple-darwin.tar.gz"
      sha256 "94e9ba6c4d59dc0d84a62e3eb6cc3ed8f79d96d5d4699aadb15eebcd652077b6"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.12/impact-0.11.12-x86_64-apple-darwin.tar.gz"
      sha256 "d3376c395c76571d3c0069107017908670d4c7a11e36719875da820414e424c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.12/impact-0.11.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "612ebc89fb76abf034f8f1777a8b92ff3ace5637273c5f78b8a3ec43d5773ffb"
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
