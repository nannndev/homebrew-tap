# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.11.1 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI core runtime for your subscriptions and API keys (eay-core)"
  homepage "https://github.com/Eay-Core/eay-core"
  version "0.11.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "cee5292271f75a7f4569ef0fcaee326e8146c1fb0ab86b6b272b8fac4a560d76"
    end
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "9cd8019076864218d982bad54d49bba22d4b856ebd039c74457c6de7830a6b38"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "dbecc1bb8c789c46e2aab286d5cf8ef8861c52d598087f991ba7fe1ed4b99e95"
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
