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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.3/impact-0.9.3-aarch64-apple-darwin.tar.gz"
      sha256 "77333918fe119b8c1e3e86df52968d99057cf13f279aea046cdf3be30895fc6e"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.3/impact-0.9.3-x86_64-apple-darwin.tar.gz"
      sha256 "a07ca482d4a1914786e40b63dfd4a459c5167aab904005c295c4a4e7a7f8e559"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.3/impact-0.9.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8124da72706c2a363e6f84f5c2002739c3c11515ce5bdd72bb7377ad0a9f089e"
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
