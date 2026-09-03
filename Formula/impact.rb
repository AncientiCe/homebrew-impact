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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.2/impact-0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "bb7580280608181e5a26b4b4e6a9354ebf9799ad8d880a05b126728af36408b8"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.2/impact-0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "bc18374357f631a963767db821d7390e7a459e718a5a87bf54934d2e5cbda40f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.2/impact-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e36d89ff260fbe1fb0be6ae235268f91b75b5b6ecc4f69b1a51bb9afc8dc3837"
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
