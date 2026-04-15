class CjCorrector < Formula
  desc "Czech grammar correction macOS menu bar app"
  homepage "https://github.com/antoninsiska/cj-corrector"
  url "https://github.com/antoninsiska/cj-corrector/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "4a946d06d3751e8ac1475f67ac08ad4896b32586a83035d2057defc30c62654b"
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
