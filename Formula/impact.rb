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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.4/impact-0.11.4-aarch64-apple-darwin.tar.gz"
      sha256 "281b9a125d2281af4752acb676a8311578ac8f24cdbdb3c68aacb951fa033414"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.4/impact-0.11.4-x86_64-apple-darwin.tar.gz"
      sha256 "095d32423904f2e39f39241f7538734ff4fe098ccde953ed0d5fac797a56252a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.4/impact-0.11.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ff58aca3d8bea45c61e405218f551975a00a6bed86a55fa9d22e02501adfb860"
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
