cask "macapad" do
  version "0.3.3"
  sha256 "544025315d2d9365dbacca26a4f5c0c040ac021239b90678a48bf613e6eec780"

  url "https://github.com/AD-Archer/Macapad/releases/download/v#{version}/Macapad.zip"
  name "Macapad"
  desc "Menu bar app that lets web frontends control your computer"
  homepage "https://github.com/AD-Archer/Macapad"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Macapad.app"

  uninstall quit: "app.macapad"

  zap trash: "~/.macapad"

  caveats do
    <<~EOS
      Macapad is unsigned, so macOS will block it on first launch. To allow it, run:
        xattr -dr com.apple.quarantine /Applications/Macapad.app

      Macapad needs Accessibility access to press keys for you:
        System Settings > Privacy & Security > Accessibility

      Because it's unsigned, macOS treats every update as a new app. After upgrading,
      remove Macapad from the Accessibility list and add it again.
    EOS
  end
end
