class Edn2json < Formula
  desc "Convert EDN lines to JSON"
  homepage "https://github.com/oscaro/edn2json"
  url "https://github.com/oscaro/edn2json/archive/0.1.0.tar.gz"
  sha256 "34a13c900a080e8bdd9eef63c1f8d6c711cfa1c3eb304bc982696ba5ad80594c"

  depends_on "leiningen" => :build

  def install
    system "lein", "uberjar"
    jar = Dir["target/edn2json-*-standalone.jar"][0]

    libexec.install jar
    bin.write_jar_script libexec/File.basename(jar), "edn2json"
  end

  test do
    assert_equal '{"home":["brew"]}',
      pipe_output("#{bin}/edn2json", "{:home (brew)}", 0).chomp
  end
end
