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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.9/impact-0.11.9-aarch64-apple-darwin.tar.gz"
      sha256 "a504f5ab0b272a93667442aab20c2e153cb3797e87c9d9c29e57060a33ef73f5"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.9/impact-0.11.9-x86_64-apple-darwin.tar.gz"
      sha256 "0801224c41a692d3f4bba8dbaed253f253dd7ff42b5d4cf0b627c8f8eb586709"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.9/impact-0.11.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "949f9bb369111e306a1b7b36fad9ec8cd6428ee7ccbdea104d36399e25211115"
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
