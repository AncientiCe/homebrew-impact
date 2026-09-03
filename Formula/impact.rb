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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.0/impact-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "329c3c08bca825d1260523e79518eb18557d3f8ac83efeb71d687c6ddb67669a"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.0/impact-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "9d7ec33433f24ead981f55710153c72b46f7889e697addc6b19bed61bf67d374"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.5.0/impact-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "be1f2e78c4284a9bad5c117532d7e81b246f7f453656d7b01da89e81f641d2d1"
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
