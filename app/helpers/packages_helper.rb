module PackagesHelper
  def convert_tilde(version)
    version.gsub(/~(\s?\d)/, "~>#{0}")
  end
end
