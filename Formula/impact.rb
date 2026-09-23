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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.3/impact-0.11.3-aarch64-apple-darwin.tar.gz"
      sha256 "cf46584a79d3d89732f3a27a0b924544e09bd9440bf6050b0ded6aaa3b664b91"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.3/impact-0.11.3-x86_64-apple-darwin.tar.gz"
      sha256 "1765ce3c9e3fe2dafeb75220a565c62208040ea7d9705729ba5cb945ab711840"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.3/impact-0.11.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3bb8355312d09a3eaea6fcfb75b7f73cf44217d70da93112c448393d5cc10781"
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
