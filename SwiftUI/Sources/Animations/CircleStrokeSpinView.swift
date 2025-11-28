//
// Copyright (c) 2025 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI

// MARK: - CircleStrokeSpinView
struct CircleStrokeSpinView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var trimEnd: CGFloat = 0
	@State private var trimStart: CGFloat = 0
	@State private var rotation: Double = 0
	@State private var animationTask: Task<Void, Never>?

	private let duration: Double = 1.7

	// MARK: - Body
	var body: some View {
		Circle()
			.trim(from: trimStart, to: trimEnd)
			.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: 3, lineCap: .round))
			.rotationEffect(.degrees(rotation - 90))
			.onAppear {
				startAnimation()
			}
			.onDisappear {
				animationTask?.cancel()
			}
	}

	// MARK: - Private Methods
	private func startAnimation() {
		withAnimation(.linear(duration: duration).repeatForever(autoreverses: false)) {
			rotation = 360
		}

		animationTask = Task { @MainActor in
			while !Task.isCancelled {
				trimStart = 0
				trimEnd = 0

				withAnimation(.easeInOut(duration: duration * 0.4)) {
					trimEnd = 0.75
				}

				try? await Task.sleep(for: .seconds(duration * 0.5))
				if Task.isCancelled { break }

				withAnimation(.easeInOut(duration: duration * 0.4)) {
					trimStart = 0.75
				}

				try? await Task.sleep(for: .seconds(duration * 0.5))
			}
		}
	}
}

#Preview {
	CircleStrokeSpinView()
		.frame(width: 70, height: 70)
}
