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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.1/impact-0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "b09ca9bd50d163dbe8ad18d92ae61edc546c07bfa7b6b638c5c1286777f35ea4"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.1/impact-0.12.1-x86_64-apple-darwin.tar.gz"
      sha256 "f517852b9af826327be0df9d68f054f067fa4c32e7c3d24e57ac61aefba6c215"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.1/impact-0.12.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6e3a79f9931f05996a0c162bfa7f91841e6f0b92b71f99cd916e4240ba198a5"
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
