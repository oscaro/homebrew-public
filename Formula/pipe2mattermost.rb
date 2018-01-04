class Pipe2mattermost < Formula
  desc "Pipe text into Mattermost"
  homepage "https://github.com/oscaro/pipe2mattermost"
  url "https://github.com/oscaro/pipe2mattermost/archive/0.1.0.tar.gz"
  sha256 "f94c20cd0b57f02a00a127da617cafa2f99e1b7533ec1dd3121850d2ea1a20c0"

  depends_on "dep" => :build
  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/oscaro/pipe2mattermost").install buildpath.children

    cd "src/github.com/oscaro/pipe2mattermost" do
      system "dep", "ensure"
      system "go", "build", "-o", bin/"pipe2mattermost", "."
      prefix.install_metafiles
    end
  end

  test do
    assert_match "-update",
      shell_output("#{bin}/pipe2mattermost -h", 2)
  end
end
