cask "macapad" do
  version "0.3.8"
  sha256 "77b767bc7528acdd346e949a9c1b0fd7dabb2962d830fa3a5fe5e8309f99c7ea"

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
