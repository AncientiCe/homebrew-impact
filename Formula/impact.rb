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
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.14/impact-0.11.14-aarch64-apple-darwin.tar.gz"
      sha256 "11889493e5375000b4b6a4814be371ebf85663e197567b266c5fc2999ed2bba8"
    end

    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.14/impact-0.11.14-x86_64-apple-darwin.tar.gz"
      sha256 "cc3bfdb5b51a93b12aee8779f43240d0b142975a64768bd7696ae3bb170a85ea"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/AncientiCe/impact-rs/releases/download/v0.11.14/impact-0.11.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eaa89c7f028c546725c0a4a411f4554f1ded671d50d4b6fa273c0cdc651457b6"
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
