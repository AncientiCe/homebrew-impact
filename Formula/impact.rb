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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.1/impact-0.11.1-aarch64-apple-darwin.tar.gz"
      sha256 "eb77ffa3602c80ad1938d09e97518038bd620fb1ef5b4212cb0d25673f8d60d5"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.1/impact-0.11.1-x86_64-apple-darwin.tar.gz"
      sha256 "9482b6c26aae916e7e5d476479d52031065bdf8cc5baa19267906ea63ad57aeb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.1/impact-0.11.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "293a1e620d8d72adabc0127649f80a3b5785f54267906f4d4ba45bf7d9de7cdb"
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
