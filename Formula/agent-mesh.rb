class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "155c02e57a5b3f657a1c077f413ee18e1ddc16d324501acef2816887ebc081b9"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9fcb332e808897633caba4b1cddc2ef579a86a6e3cacb78a609547fe096543bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "179289d943d52b9849dd27f9ea73a0c41b47a9837c5e652233dd311145cfc6fa"
    sha256 cellar: :any,                 x86_64_linux:  "d583ad04048bb1531bf533333a44af34ce885a88e9f3c2856c32be1a1dc13c98"
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
