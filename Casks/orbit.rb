cask "orbit" do
  version "0.1.1"
  sha256 "f5c8b9d93a18af223b5d99c5022599ab805b97baaf73d86746646a713b8fabc8"

  url "https://github.com/inkstatim/orbit-releases/releases/download/v#{version}/Orbit-#{version}.dmg"
  name "Orbit"
  desc "Disk space analyzer with rings, tiles and hidden space breakdown"
  homepage "https://inkstatim.dev/orbit/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Orbit.app"

  # Orbit не заверен Apple: снимаем карантин, чтобы macOS не спрашивала про неизвестного разработчика.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Orbit.app"],
        must_succeed:   false,
        writable_paths: ["Orbit.app"],
        writable_base:  :appdir
  end

  uninstall quit: "dev.inkstatim.orbit"

  zap trash: [
    "~/Library/Preferences/dev.inkstatim.orbit.plist",
    "~/Library/Saved Application State/dev.inkstatim.orbit.savedState",
  ]
end
