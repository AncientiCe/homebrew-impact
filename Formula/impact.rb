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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.11/impact-0.11.11-aarch64-apple-darwin.tar.gz"
      sha256 "10b34efc67531bf7336cf346dbdf9c595c4ef472ea714533f1a7f0234f441d12"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.11/impact-0.11.11-x86_64-apple-darwin.tar.gz"
      sha256 "2343795fb9afa23a245f99a13829ea8ca5989fcefd258738ac8e9037a4a66969"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.11/impact-0.11.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cdc647f010360986821dff4ea2c6304e50edb4a5913b8555919c310945f6ee11"
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
