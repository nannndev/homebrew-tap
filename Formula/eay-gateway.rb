# Template rendered by .github/workflows/release.yml into nannndev/homebrew-tap/Formula/eay-gateway.rb.
# 0.10.1 and @SHA_*@ are filled in from the release's SHA256SUMS.txt.
class EayGateway < Formula
  desc "Local OpenAI/Anthropic-compatible AI core runtime for your subscriptions and API keys (eay-core)"
  homepage "https://github.com/Eay-Core/eay-core"
  version "0.10.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-aarch64-apple-darwin"
      sha256 "32aeddd09637105f56ae09087d94c0eafa29da155ea3cc78928ab7cdcb4deff6"
    end
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-apple-darwin"
      sha256 "5ad30e7f6fc12400c6a16f1514533d7f3f1bdefc3f4668791fe62d35d76c0d9b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Eay-Core/eay-core/releases/download/v#{version}/eay-gateway-x86_64-unknown-linux-gnu"
      sha256 "cf1fa4e90a7daef9ec11823a43f30f097956a945b9b6528c735777d35281065e"
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
