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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.5/impact-0.11.5-aarch64-apple-darwin.tar.gz"
      sha256 "f1ab397cb155cb817bab88873dbb3f71b367be96db5bc81b3eb3e41cf966e133"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.5/impact-0.11.5-x86_64-apple-darwin.tar.gz"
      sha256 "b27b272ad2cdfa61ae9015792f1a54b6cfbb9ef2adc06b39f232b9ac0b5ac3b1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.5/impact-0.11.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c10565caf009b997001fff06edc53300f82e1dc2092e41789864fc28a7d2aa1"
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
