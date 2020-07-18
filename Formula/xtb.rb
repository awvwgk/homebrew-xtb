class Xtb < Formula
  desc "Semiempirical Extended Tight-Binding Program Package"
  homepage "https://www.chemie.uni-bonn.de/pctc/mulliken-center/grimme/software/xtb"
  url "https://github.com/grimme-lab/xtb/archive/v6.3.2.tar.gz"
  sha256 "578a560bf012ffb85bc76ba1b3867294033b3bc211f0eaf94741bfccf62a6778"
  license "LGPL-3.0"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "gcc" # for gfortran
  fails_with :gcc => "4"
  fails_with :gcc => "5"
  fails_with :gcc => "6"
  fails_with :clang

  def install
    mkdir "build" do
      # ENV.fc is not defined and setting it up with ENV.fortran will yield default gfortran
      ENV["CC"] = ENV.cc
      ENV["FC"] = ENV.cc.gsub /gcc/, "gfortran"
      system "meson", *std_meson_args, "-Dla_backend=netlib", ".."
      system "ninja", "-v"
      system "ninja", "test", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "#{bin}/xtb", "--version"
  end
end
