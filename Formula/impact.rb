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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.3/impact-0.12.3-aarch64-apple-darwin.tar.gz"
      sha256 "d55c3bc7c7561bcc9c95966b09eb40a7a3190a5c0336046990544828be855580"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.3/impact-0.12.3-x86_64-apple-darwin.tar.gz"
      sha256 "96020e0b7db3ec3bdfa24ccd27701a71ee696ff12efe32c9d2a8742366761dcb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.3/impact-0.12.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "688d691f9917f0cf9221dab0e10bf9b199cc2f483c0604c62ec5824d1e758290"
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
