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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.7/impact-0.12.7-aarch64-apple-darwin.tar.gz"
      sha256 "9e100f15d5d85cdcd5df3650f43c95e09d83e3161769c820deaabe632b5cdda0"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.7/impact-0.12.7-x86_64-apple-darwin.tar.gz"
      sha256 "d21712590583d05166a690f0de2d2f0ac5bf6dbba0f538b6b94e12904da0468f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.7/impact-0.12.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98110b71537b5b407e3443d07fb8f53bcf02f8b240166659cac79ae559c3c602"
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
