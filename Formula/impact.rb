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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.1/impact-0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "bea059efd7b07b8d573c22e05f0e778527ab6a4add23234c298392df920d188a"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.1/impact-0.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "e5be20af155fb9cf38d981ee74aa8aeb488957f188e1e181a184e9895af0c605"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.1/impact-0.9.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3964230826a554a2a2e317ef08a063dca5f2d48cc52abb6ada0d93ec42a1220b"
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
