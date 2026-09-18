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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.0/impact-0.11.0-aarch64-apple-darwin.tar.gz"
      sha256 "9218811b03ce007b4963bdb66635f8f35a5b2ecd57e4bf1f909b113fad17504e"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.0/impact-0.11.0-x86_64-apple-darwin.tar.gz"
      sha256 "baf70da46bcc224a67dd34afbb1a6a551f01de7e350b53d33cb43f399070fd31"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.0/impact-0.11.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "22354c07f9eee5451ff8f23329c05a9a97bd64a9669fcb34fba7dfacc5ec587b"
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
