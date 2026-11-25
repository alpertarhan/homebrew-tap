class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "e2c47ef252f7efdab296d8197aa7c5dbac496c7ac25400eb2b5b84200312c20f"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "48a30af1479d386e3148284d4d63b6e912d99da9120fe306b67631a91a137baf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32ccdb57d422d4928ff95dc7395cfecf62d94186ef665b601e0e623198129881"
    sha256 cellar: :any,                 x86_64_linux:  "f2b98f3fc168c231980414b50b03ce4313e926074908dcfec1e690075873812b"
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
