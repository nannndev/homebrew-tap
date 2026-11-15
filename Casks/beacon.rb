cask "beacon" do
  version "0.11.0"
  sha256 "c88d9ce32619fe04a9206b21cd4bc5aab9cae02a425e3e72a2c4784c2ff5c887"

  url "https://github.com/nannndev/beacon/releases/download/v#{version}/Beacon_#{version}_aarch64.dmg"
  name "Beacon"
  desc "Native Rust API workbench, load tester, AI Gateway, and MCP copilot"
  homepage "https://github.com/nannndev/beacon"

  depends_on arch: :arm64

  app "Beacon.app"
  binary "#{appdir}/Beacon.app/Contents/MacOS/beacon_cli", target: "beacon"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Beacon.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.beacon.app",
    "~/Library/Caches/com.beacon.app",
    "~/Library/Preferences/com.beacon.app.plist",
    "~/Library/Saved Application State/com.beacon.app.savedState",
  ]
end

