# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.3.1 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI gateway for your subscriptions and API keys"
  homepage "https://github.com/nannndev/eay-gateway"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "bf78fa0e7977f22d77fa5f4bae2129434efd2f3638d37a478c225c30f44478b6"
    end
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "56d8e45e43e7e243f1a1867387618c8c6170023d92f360dbcbe947e107825413"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/nannndev/eay-gateway/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "6270d89bc15cc0bfa7172f21b64a307ad92fd8eb919cf36256ec3265061ba393"
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
