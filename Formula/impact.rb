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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.4/impact-0.12.4-aarch64-apple-darwin.tar.gz"
      sha256 "57331abb9d2acbcfd3627ef6279106f06f41648c3c5ab8604425d83237f6030a"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.4/impact-0.12.4-x86_64-apple-darwin.tar.gz"
      sha256 "6db1ae14bb852c749b9b0c4aadbce4c30d84d6129b5ce4f10d01ab02665f923e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.4/impact-0.12.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7db28bae9d66431584b3e4a8b759ac20abe17fe03c5a5d6d856c4dccbdc7104c"
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
