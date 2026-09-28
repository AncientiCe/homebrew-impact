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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.8/impact-0.11.8-aarch64-apple-darwin.tar.gz"
      sha256 "c72cc947a65cdf0d41efb9f0ab5816343be48c023255990a4855339311ecd188"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.8/impact-0.11.8-x86_64-apple-darwin.tar.gz"
      sha256 "a34375aa89af1fbd196e79296a40675eebb9b27733d50dd8811d4aee4f29df19"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.8/impact-0.11.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cae614edaf5ca08aadcfaefe05e03b8bf70ae53ab7e756b2b45d65a622dc6957"
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
