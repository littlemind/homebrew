require 'formula'

# References:
# * http://smalltalk.gnu.org/wiki/building-gst-guides
#
# Note that we build 32-bit, which means that 64-bit
# optional dependencies will break the build. You may need
# to "brew unlink" these before installing GNU Smalltalk and
# "brew link" them afterwards:
# * gdbm

class GnuSmalltalk <Formula
  url 'ftp://ftp.gnu.org/gnu/smalltalk/smalltalk-3.2.tar.gz'
  homepage 'http://smalltalk.gnu.org/'
  sha1 'd951714c4fc7d91d06bdc33c20905885e5d2b25f'

  depends_on 'gawk' # Needed to build
  # depends_on 'gmp' => :optional # 32/64 built build problems

  def install
    # Codegen problems with LLVM
    ENV.gcc_4_2

    # 64-bit version doesn't build, so force 32 bits.
    ENV.m32

    ENV['FFI_CFLAGS'] = '-I/usr/include/ffi'
    system "./configure", "--prefix=#{prefix}", "--disable-debug", 
                          "--disable-dependency-tracking",
                          "--with-readline=/usr/lib"
    system "make"
    ENV.j1 # Parallel install doesn't work
    system "make install"
  end
end
