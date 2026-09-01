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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.1.0/impact-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "1922552a8fac7c1deae6c180c87d5cb85e2f9e3a3e68378d6616f803038b51d6"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.1.0/impact-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "92ad04538d0330b94de146a5a19e9f5f7d7688c4a714835406927423b8134fc7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.1.0/impact-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a613ad90730c7334bc4a34dd2c253c867a835a085800bbbd996b73794c49f81a"
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
