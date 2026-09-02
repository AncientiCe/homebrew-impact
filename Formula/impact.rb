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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.3.0/impact-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "d929348c2e3814dd4793f2f04c02d1dfcbb6f7936b943f07c511b384a3c597a5"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.3.0/impact-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "708c62a3068affb69fea933d37a0ee9d0eb60487481b218a16b5ba06601d427a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.3.0/impact-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "078ea4cf16fe268e0f870f69137a7ee146c374eaa649f81d71d75f9469cb70ed"
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
