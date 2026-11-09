cask "orbit" do
  version "0.1.0"
  sha256 "354fdf77ec4dc104763d30809c185ae988663b9355cf36b0882882610854a858"

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
