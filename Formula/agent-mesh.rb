class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "1a06cf6e80691be95693cfed942dc23fb65b248b8ffd6a12469eeb66efa1a9b9"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4167ac2a0a8592b40ce8724b08d1c69f34fccbd0d004dbd6b9690b279658e435"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70f5e85422c174e2708ad98553708f33e8a4f105b4ac6f931f786bda071a70bd"
    sha256 cellar: :any,                 x86_64_linux:  "d0d10fdded8f80edc50ffe0b3922dd75a369ca5141f82d5f382bf42f067aca2a"
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
