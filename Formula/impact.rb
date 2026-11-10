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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.5/impact-0.12.5-aarch64-apple-darwin.tar.gz"
      sha256 "1d488b681f24e59321655e785723c1d74d9a04aae84d88a7f3c1ac719d3433b4"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.5/impact-0.12.5-x86_64-apple-darwin.tar.gz"
      sha256 "d5a9d84e3b8371ea6af915325eeb0c091d455144d9d4e53f9335c63ca0a8f52d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.12.5/impact-0.12.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2637915108a51e01884276758127a3188e0cc33af2932a88aeb070789649fd20"
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
