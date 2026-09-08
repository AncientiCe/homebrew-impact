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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.6.0/impact-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "45def3b93bfe88603a791dc61d15b35059e3076f83f72241ff00eb6171deedfd"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.6.0/impact-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "d93d2d71d21d969c2ae48cb4389af8fb88ef394843ab181ed02ddb6bf32af341"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.6.0/impact-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f701420d5bda64ab5718888a3b9ac68b2cc70e537371b871bf01fbc1b71e5f32"
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
