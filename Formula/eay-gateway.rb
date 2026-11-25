# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.10.0 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI gateway for your subscriptions and API keys"
  homepage "https://github.com/nannndev/eay-gateway"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "c1cf7cc0993a5354438e7afacb4add9588f5fb5a76cd011c9e2ab5983d2cae8a"
    end
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "a792de71fea9ece732e0d73f26144a57ef4f41ddcb5df557f089389d8bd16767"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "fcfeb4c5ea1b900d13b0667ab2caa6f61ce47a6dbc15595f9c3c48db763651b8"
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
