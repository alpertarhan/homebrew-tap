class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "683d063d6491613b93fe293a9f5b0c3c7f575aeab27c22ad50475f8fbc9b74b1"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a018c0179226b38393988fb92f577f19f6966fc4e30efd1c49d2dee674e496ff"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "859003909c28ce07a2beea684f81f7874cabb4b40112f2b29dcda87209d2bbec"
    sha256 cellar: :any,                 x86_64_linux:  "4520bce3a1900460f294c0ef29dcbdf1afdfb21270907ec8a4c7714c7f513972"
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
