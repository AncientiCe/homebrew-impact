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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.6/impact-0.11.6-aarch64-apple-darwin.tar.gz"
      sha256 "7f3a2633e4e425050c1ebcb3ef8f3a7243e825b44e0d397d76a5e54600a88999"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.6/impact-0.11.6-x86_64-apple-darwin.tar.gz"
      sha256 "4a8abf3c89a4f02259b1597864c25fde5c857eb881c14a4e60f7d68a8eef4fa4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.6/impact-0.11.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "76a5dbfdae4215a73b98dde9f9f8ff481aac3b333e4612016ead05f3df2f6cbc"
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
