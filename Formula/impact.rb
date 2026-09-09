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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.8.0/impact-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "884fbf688f4f153f6bb48fe685c6e916f2179e78dea5fb23c5106759984281a4"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.8.0/impact-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "583890b629042ec8cc24d150a7c1121e6f13210c3254981a881e567591070da4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.8.0/impact-0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6deafb5e529290bab1ac3fb78fed7811d171e0c7bea6f3f17326515d6272d510"
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
