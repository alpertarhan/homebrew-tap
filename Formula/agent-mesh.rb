class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "b1496438ba80c4e197e84c7a15805444aee556df2145607c9ac3691e6cd823b1"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "04437dd0e06748c21472002740d932e82fd9ba08dffba811f17658b5dab39a02"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0be5b7975ac6a0eda45353ddcde2651816ff6107fe80d60a716554aa8a1d2b26"
    sha256 cellar: :any,                 x86_64_linux:  "96abb628f32e3f1b759bee404832e3a0da0fc089235d4855122b9b69a60c1de5"
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
