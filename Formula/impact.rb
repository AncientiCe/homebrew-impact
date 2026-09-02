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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.4.0/impact-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "f6b18a1814c9161666ed3e48abcd7945adcdef4b3b221744a372e81c989e3230"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.4.0/impact-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "c02c95403c216c1e37fd305d06f11e9714b8fd67f808f3d96fcbefb8e69d8512"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.4.0/impact-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c0d593f2212a95e3b356551c8842d8073b6cc10813874acd0376b33847117900"
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
