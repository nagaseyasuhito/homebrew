require "formula"

class Libwpd < Formula
  desc "General purpose library for reading WordPerfect files"
  homepage "http://libwpd.sourceforge.net/"
  url "http://dev-www.libreoffice.org/src/libwpd-0.10.0.tar.bz2"
  sha1 "bbcc6e528a69492fb2b4bbb9a56d385a29efc4c4"

  bottle do
    cellar :any
    revision 1
    sha1 "5ee8b064986e9a93d7160000fed86631ec67ac5b" => :yosemite
    sha1 "76609ba2ba73cf1fbb60e6de22c3eb7b73f61483" => :mavericks
    sha1 "dfb25198b4294801aa9d5e8b5bca484291f7e19d" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "libgsf"
  depends_on "librevenge"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <libwpd/libwpd.h>
      int main() {
        return libwpd::WPD_OK;
      }
    EOS
    system ENV.cc, "test.cpp", "-o", "test",
                   "-lrevenge-0.0", "-I#{Formula["librevenge"].include}/librevenge-0.0",
                   "-lwpd-0.10", "-I#{include}/libwpd-0.10"
    system "./test"
  end
end
