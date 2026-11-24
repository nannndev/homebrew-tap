# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.9.0 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI gateway for your subscriptions and API keys"
  homepage "https://github.com/nannndev/eay-gateway"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "2fba02bed9a78a4fac1efe8ade74c8d9afc97a97f17eccfd69e94a0c83d2faae"
    end
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "65160b3ccdc109921cee1b78bb4dff23ef9721044d9f60c5c811095e9d9a3d53"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "8ff11f28710c3152ece77da059f432af7f871f4a2d5b8a69969779b73c14f1cc"
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
