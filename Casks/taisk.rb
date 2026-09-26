cask "taisk" do
  version "0.1.2"
  sha256 "156090857fe7af69086ae1e3f1addf8864f01527e24e96070575fe4d0df590f4"

  url "https://github.com/omrico94/taisk/releases/download/v#{version}/taisk_#{version}_universal.dmg"
  name "taisk"
  desc "Live Kanban board for every Claude Code session"
  homepage "https://github.com/omrico94/taisk"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on cask: "ollama-app"
  depends_on macos: :monterey

  app "taisk.app"

  # Not notarized yet: clear the quarantine flag so Gatekeeper doesn't block launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/taisk.app"]
  end

  zap trash: "~/Library/Application Support/taisk"

  caveats <<~EOS
    On first launch, taisk shows a banner to pull two small Ollama models
    (nomic-embed-text, qwen2.5:1.5b). Or run:
      ollama pull nomic-embed-text && ollama pull qwen2.5:1.5b

    taisk registers hooks in ~/.claude/settings.json. Quit taisk and remove the
    entries containing "taisk/bin/hook-bridge" if you uninstall.
  EOS
end
