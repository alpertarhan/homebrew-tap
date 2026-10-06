class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "c2fdb36e0fae79252fd7a532c9ad4bb17ef7179b0aaec0238d23a070ff07ad04"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "501e27fc03261d7b422af93153ac388af5c30bd978906ac0a22a721081653841"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9c741afe4b604e91b93e5e1b5eba8666c267018634c5e290600fbd11b64f875d"
    sha256 cellar: :any,                 x86_64_linux:  "94290e3372be6998d6991d3524612d09846a7203a32f9766b1c5237857195e87"
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
