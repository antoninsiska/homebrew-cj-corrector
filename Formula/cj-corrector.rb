class CjCorrector < Formula
  desc "Czech grammar correction macOS menu bar app"
  homepage "https://github.com/antoninsiska/cj-corrector"
  url "https://github.com/antoninsiska/cj-corrector/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "23731a8174d81d44a50e5673e23d7790931a146f191db4f7dbf62416211706be"
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
