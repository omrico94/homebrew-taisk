cask "taisk" do
  version "0.1.9"
  sha256 "1cf70f85c588b8e415511a9e7d9e37ef2961fe40d1933c1d65dcbca754131385"

  url "https://github.com/omrico94/taisk/releases/download/v#{version}/taisk_#{version}_universal.dmg"
  name "taisk"
  desc "Live Kanban board for every Claude Code session"
  homepage "https://github.com/omrico94/taisk"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "taisk.app"

  # Not notarized yet: clear the quarantine flag so Gatekeeper doesn't block launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/taisk.app"]
  end

  zap trash: "~/Library/Application Support/taisk"

  caveats <<~EOS
    taisk needs Ollama and Claude Code. If you don't have Ollama:
      brew install --cask ollama-app

    Then pull the two small models taisk uses:
      ollama pull nomic-embed-text && ollama pull qwen2.5:1.5b

    taisk registers hooks in ~/.claude/settings.json. Quit taisk and remove the
    entries containing "taisk/bin/hook-bridge" if you uninstall.
  EOS
end
