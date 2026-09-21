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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.2/impact-0.11.2-aarch64-apple-darwin.tar.gz"
      sha256 "03f344f89b8af7f0768fba3cae3cc9b7439008ae9321c9409e152ad2a5908047"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.2/impact-0.11.2-x86_64-apple-darwin.tar.gz"
      sha256 "889d6cc3d7d3b7d28248992d0e2d8cf2c94921f515a751a4a3fdd92a4faca2ed"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.2/impact-0.11.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ecde177e01fd902066e08fcb1a4eaeaf54b4de1412621f4643022abf355cb5fb"
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
