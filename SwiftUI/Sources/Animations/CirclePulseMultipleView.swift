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

// MARK: - CirclePulseMultipleView
struct CirclePulseMultipleView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let pulseCount = 3
	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size

			ZStack {
				ForEach(0..<pulseCount, id: \.self) { i in
					PulseCircle(
						index: i,
						duration: duration,
						color: hud.colorAnimation
					)
					.frame(width: size.width, height: size.height)
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct PulseCircle: View {

	let index: Int
	let duration: Double
	let color: Color

	@State private var scale: CGFloat = 0
	@State private var opacity: Double = 0
	@State private var animationTask: Task<Void, Never>?

	private var delay: Double {
		Double(index) * 0.3
	}

	var body: some View {
		Circle()
			.fill(color)
			.scaleEffect(scale)
			.opacity(opacity)
			.onAppear {
				animationTask = Task { @MainActor in
					try? await Task.sleep(for: .seconds(delay))
					while !Task.isCancelled {
						scale = 0
						opacity = 0

						withAnimation(.linear(duration: duration)) {
							scale = 1
						}
						withAnimation(.linear(duration: duration * 0.05)) {
							opacity = 1
						}

						try? await Task.sleep(for: .seconds(duration * 0.05))
						if Task.isCancelled { break }

						withAnimation(.linear(duration: duration * 0.95)) {
							opacity = 0
						}

						try? await Task.sleep(for: .seconds(duration * 0.95))
					}
				}
			}
			.onDisappear {
				animationTask?.cancel()
			}
	}
}

#Preview {
	CirclePulseMultipleView()
		.frame(width: 70, height: 70)
}
