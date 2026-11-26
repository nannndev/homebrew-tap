# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.11.0 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI core runtime for your subscriptions and API keys (eay-core)"
  homepage "https://github.com/Eay-Core/eay-core"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "76ffd22da848a90f79e3d93792841f97ad3578432025ef3e49ab1cd5491454b5"
    end
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "19bc226fe7693248786083175b6e2041fdbaeb2049b6161d5007cd133cc34105"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "cc6c0b8eaca189dc5dc3a8dbc105e06d280e1714051b5c8ada320a343d157097"
    end
  end

  def install
    bin.install Dir["eay-gateway-*"].first => "eay-gateway"
  end

  service do
    run [opt_bin/"eay-gateway"]
    keep_alive successful_exit: false
    log_path var/"log/eay-gateway.log"
    error_log_path var/"log/eay-gateway.log"
  end

  def caveats
    <<~EOS
      Start now and at login:
        brew services start eay-gateway
      or, without Homebrew managing it:
        eay-gateway service install

      Then point your tools at http://127.0.0.1:20129 (OpenAI base URL: /v1).
      Web console: https://github.com/nannndev/eay-console
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/eay-gateway --version")
  end
end
