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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.0/impact-0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "28bcf6f770c6a263b06f007ca241aa10edbc5e0c386483d938edecd03d11bc8b"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.0/impact-0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "f08646cefd1272b9a2b6fb919d3785dd7a278f2b987e96ce0c4adb479e2b7168"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.0/impact-0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24a3ad00a07212863f4b7ce4b10bbb821ce2a7a8728174709294cc8ce1c7b28a"
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
