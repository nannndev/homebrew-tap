# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.6.0 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI gateway for your subscriptions and API keys"
  homepage "https://github.com/nannndev/eay-gateway"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "31d4bedcb14d2c20e9fd096688bbd70f6ba48915a80a5bb1b84586301c6dddb3"
    end
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "0cd6e777545c3454b024504425d3b8a3f3d5b00706f48f38584c6c51c1f4e5f3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "78d82b3bd8144f676398fa5e37439d159d28ca10ca7cbbad47adc7669fb27d14"
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
