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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.8/impact-0.12.8-aarch64-apple-darwin.tar.gz"
      sha256 "d562b15786f0a06443e9865ec43ea31de3d5c3f89db176c8cde68ed6f57c4dd5"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.8/impact-0.12.8-x86_64-apple-darwin.tar.gz"
      sha256 "0a6ceee6f07deb387aa8371a3480a5bfd28c24fdd22d14acb9a658b5ea8bba7f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.8/impact-0.12.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0fab1109a7435fa208cba6c8e2ee4166e3b44eca829efddcd31f5d5428244de0"
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
