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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.4/impact-0.9.4-aarch64-apple-darwin.tar.gz"
      sha256 "d329d965d471e1e80b00e8766540855261a70f30ac9b201672fed0c3ae13a4d0"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.4/impact-0.9.4-x86_64-apple-darwin.tar.gz"
      sha256 "53737b938a2f8e0065a3caffc2ea17ff4efa4b09a0ab935436880ea4598fbc98"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.9.4/impact-0.9.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ad8a8880b56119cbdefdc446738a195f1f490ecd691d39e638b3588991d0729c"
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
