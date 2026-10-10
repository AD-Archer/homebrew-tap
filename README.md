# ad-archer/tap

Homebrew tap for casks published by AD-Archer.

| Cask | What it is |
|---|---|
| [`rustysound`](https://github.com/AD-Archer/RustySound) | Music streaming client for Navidrome and Subsonic servers |
| [`macapad`](https://github.com/AD-Archer/Macapad) | Menu bar app that lets web frontends control your Mac (Apple Silicon, macOS 14+) |

## 1. Add the tap

```bash
brew tap ad-archer/tap
```

## 2. Trust the tap

Homebrew 6 and later won't load casks from third-party taps until you trust them.
Without this step, `brew install` stops with an "untrusted" error.

Trust everything in this tap:

```bash
brew trust ad-archer/tap
```

Or trust only the casks you want:

```bash
brew trust --cask ad-archer/tap/rustysound
brew trust --cask ad-archer/tap/macapad
```

Installing by full name (`brew install --cask ad-archer/tap/macapad`) also trusts just that cask.
To undo trust later, run `brew untrust ad-archer/tap`.

## 3. Install

```bash
brew install --cask rustysound
brew install --cask macapad
```

## 4. Allow the app to open

These apps aren't signed with an Apple Developer ID, so macOS Gatekeeper blocks them the first time,
usually with a message that the app "is damaged" or "can't be checked for malicious software".
That message comes from the quarantine flag macOS puts on everything downloaded from the internet.

Remove the flag once after installing (and again after each upgrade):

```bash
xattr -dr com.apple.quarantine /Applications/Rustysound.app
xattr -dr com.apple.quarantine /Applications/Macapad.app
```

- `xattr` edits a file's extended attributes.
- `-d com.apple.quarantine` deletes the quarantine flag.
- `-r` does it for every file inside the `.app` bundle.

Only do this for apps you trust: it skips the check macOS would otherwise run.
If you prefer not to use the terminal, right-click the app in Finder, choose **Open**, then click
**Open Anyway** in System Settings > Privacy & Security.

**Macapad** also needs Accessibility access (System Settings > Privacy & Security > Accessibility).
Because it's unsigned, macOS treats every upgrade as a new app, so after upgrading remove Macapad
from that list and add it again.

## Upgrade

```bash
brew update
brew upgrade --cask rustysound macapad
```

Then run the `xattr` command above for the apps you upgraded.

## Automation

Each cask is updated by its own GitHub Actions workflow. Both share
`.github/scripts/update-rustysound-cask.sh`, which reads `SOURCE_REPO`, `CASK_FILE` and `ASSET_NAME`
to pick the app.

| Cask | Workflow | `repository_dispatch` event | Release asset |
|---|---|---|---|
| `rustysound` | `update-rustysound-cask.yml` | `rustysound-release` | `Rustysound.dmg` |
| `macapad` | `update-macapad-cask.yml` | `macapad-release` | `Macapad.zip` |

- No cron schedule: each app's release workflow sends the dispatch event, or run one by hand with `workflow_dispatch`
- Updates the cask's `version` and `sha256`, and pushes a commit only when they changed
