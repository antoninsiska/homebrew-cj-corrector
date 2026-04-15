class CjCorrector < Formula
  desc "Czech grammar correction macOS menu bar app"
  homepage "https://github.com/antoninsiska/cj-corrector"
  url "https://github.com/antoninsiska/cj-corrector/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "MIT"

  depends_on :macos
  depends_on "python@3.12"
  depends_on "python-tk@3.12"

  def install
    system "python3.12", "-m", "venv", libexec
    system libexec/"bin/pip", "install",
           "pyobjc-framework-Cocoa",
           "pyobjc-framework-ApplicationServices"

    libexec.install Dir["*.py"]

    (bin/"cj-corrector").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/bin/python3" "#{libexec}/app.py" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Spuštění:
        cj-corrector &

      Přidání do Login Items (automatický start):
        System Settings → General → Login Items → klikni + → vyber cj-corrector
    EOS
  end

  test do
    assert_predicate libexec/"app.py", :exist?
  end
end
