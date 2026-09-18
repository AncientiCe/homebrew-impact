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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.10.0/impact-0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "5214056b9fa689e2077dafc1f4404aedf555eb919c933c41a29570e49bc1153b"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.10.0/impact-0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "92b37b71ceac2a71ee59aaf71012dcb942a6df0cb8c681dbd5a78f213057e2e9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.10.0/impact-0.10.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "405b807d2ae38145d5a721d1f3f8ab6293695e3b60fc79c66e5076265dd940a4"
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
