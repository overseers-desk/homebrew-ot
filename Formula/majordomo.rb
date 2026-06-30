# Homebrew formula for majordomo.
# Install:
#   brew tap overseers-desk/od
#   brew install majordomo

class Majordomo < Formula
  include Language::Python::Virtualenv

  desc "Read and report Google Chat task activity"
  homepage "https://github.com/overseers-desk/majordomo"
  url "https://files.pythonhosted.org/packages/c1/99/7f12704cea55985a0edd77eb00cf462ffe870fd29fa4ff89d56d019efe11/majordomo-0.1.4.tar.gz"
  sha256 "73b72255d0403947cd8afff2a209493f54db4e56b99173a35b1c60bce0ae1dd7"
  license "GPL-3.0-only"

  depends_on "python@3.13"

  # On recent macOS, Homebrew's bottled python@3.13 pyexpat fails to load the
  # system libexpat; pull in Homebrew's expat and point the runtime at it.
  on_macos do
    depends_on "expat"
  end

  resource "pymysql" do
    url "https://files.pythonhosted.org/packages/c9/bc/1c6a92f385940f727daeecf3bacaf186e03875dff57197801046c583bcf0/pymysql-1.2.0.tar.gz"
    sha256 "6c7b17ca686988104d7426c27895b455cdeea3e9d3ceb1270f0c3704fead8c33"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
  end

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c/annotated_doc-0.0.4.tar.gz"
    sha256 "fbcda96e87e9c92ad167c2e53839e57503ecfda18804ea28102353485033faa4"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/7c/f7/68adc395201b20b872d68e975386832e8005ffeacedd43a1d837a32815be/typer-0.26.8.tar.gz"
    sha256 "c244a6bd558886fe3f8780efb6bdd28bb9aff005a94eedebaa5cb32926fe2f7e"
  end

  def install
    if OS.mac?
      ENV.prepend "DYLD_LIBRARY_PATH", Formula["expat"].opt_lib, ":"
    end

    virtualenv_install_with_resources

    if OS.mac?
      # Wrap majordomo so the bottled python@3.13's pyexpat resolves against
      # Homebrew's expat instead of the macOS system one.
      target = libexec/"bin/majordomo"
      (bin/"majordomo").unlink if (bin/"majordomo").exist?
      (bin/"majordomo").write_env_script target,
        DYLD_LIBRARY_PATH: "#{Formula["expat"].opt_lib}:$DYLD_LIBRARY_PATH"
    end
  end

  test do
    assert_match "Google Chat", shell_output("#{bin}/majordomo --help")
  end
end
