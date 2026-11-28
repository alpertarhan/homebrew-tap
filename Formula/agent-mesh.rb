class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "c8d315380418188e2d0619ffb6a5e6de8b8edc78907bba2a1b65770964a3c05c"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e069f7624e8d854d18da13311b16dad3f814f96f3348f0ffe96d71fefc624f26"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b3f40ffa2c7870d529e4953cbbb723950baa9ab28b03c99a5b220618f26d108"
    sha256 cellar: :any,                 x86_64_linux:  "365902a04842cff6c7092432d8b4f8336c40592c3d620a85c53d2cdca31905b4"
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
