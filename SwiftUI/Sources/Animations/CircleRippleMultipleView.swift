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

// MARK: - CircleRippleMultipleView
struct CircleRippleMultipleView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let rippleCount = 3
	private let duration: Double = 1.25

	// MARK: - Body
	var body: some View {
		ZStack {
			ForEach(0..<rippleCount, id: \.self) { i in
				RippleCircle(
					index: i,
					duration: duration,
					color: hud.colorAnimation
				)
			}
		}
	}
}

private struct RippleCircle: View {

	let index: Int
	let duration: Double
	let color: Color

	@State private var scale: CGFloat = 0
	@State private var opacity: Double = 1
	@State private var animationTask: Task<Void, Never>?

	private var delay: Double {
		Double(index) * 0.2
	}

	var body: some View {
		Circle()
			.stroke(color, lineWidth: 5)
			.scaleEffect(scale)
			.opacity(opacity)
			.onAppear {
				animationTask = Task { @MainActor in
					try? await Task.sleep(for: .seconds(delay))
					while !Task.isCancelled {
						scale = 0
						opacity = 1

						withAnimation(.easeOut(duration: duration)) {
							scale = 1
						}
						withAnimation(.easeIn(duration: duration)) {
							opacity = 0
						}

						try? await Task.sleep(for: .seconds(duration))
					}
				}
			}
			.onDisappear {
				animationTask?.cancel()
			}
	}
}

#Preview {
	CircleRippleMultipleView()
		.frame(width: 70, height: 70)
}
