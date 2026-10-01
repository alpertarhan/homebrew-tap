class AgentMesh < Formula
  desc "Local messaging between coding agents across harnesses"
  homepage "https://github.com/alpertarhan/agent-mesh"
  url "https://github.com/alpertarhan/agent-mesh/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "8da316b17c5cda08179d0e70a87e904dca4d0b20bb904593b9ec4033b21abe63"
  license "MIT"
  head "https://github.com/alpertarhan/agent-mesh.git", branch: "main"

  bottle do
    root_url "https://github.com/alpertarhan/homebrew-tap/releases/download/agent-mesh-0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0e93c6a749a04ed1d00f09f3484ea01bfd2da89a8365f9c6b04b3a6261cc631b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e3801a3d4d2f1ae38f1c8cd9f7f12777bdc4de0baf66fef88ec7b36b587f8ef"
    sha256 cellar: :any,                 x86_64_linux:  "7c18c03b4a19746de5f38fc6cf97fb4b81ea0f90964f77539e53ffbd8aca6815"
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
