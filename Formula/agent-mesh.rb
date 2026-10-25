class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "732947efacea144df5a199f491a736d2601ea80592eed6922ef61813bacee702"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "307f86a308ecc518d76446023a5653243b5af275f68ed88f94486ef6af846e5e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ecc24567ced7b76601cd7d5d2c6804c067e5070af2b287c93c76d7f8e11146a4"
    sha256 cellar: :any,                 x86_64_linux:  "c42b6e697b4a152da68fd30e689a0e0c09d478531f56df62cf6296598fe4cf36"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags:, output: bin/"agm"), "./cmd/agm"
  end

  def caveats
    "Run `agm install` to set up (or update) the harness integrations."
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agm version").strip
    assert_match "not installed", shell_output("#{bin}/agm status")
  end
end
