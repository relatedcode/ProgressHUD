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

// MARK: - CircleArcDotSpinView
struct CircleArcDotSpinView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var dotRotation: Double = 0

	private struct AnimationValues {
		var rotation: Double = 0
		var trimEnd: CGFloat = 0.125
	}

	private let dotCount = 8
	private let dotDuration: Double = 4.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let space = size.width / 8
			let innerSize = size.width - space
			let radius = innerSize / 2
			let dotSize = radius / 3

			ZStack {
				ForEach(0..<dotCount, id: \.self) { i in
					let angle = (Double(i) / Double(dotCount)) * 360

					Circle()
						.fill(hud.colorAnimation)
						.frame(width: dotSize, height: dotSize)
						.offset(x: radius)
						.rotationEffect(.degrees(angle))
				}
				.rotationEffect(.degrees(dotRotation))

				KeyframeAnimator(initialValue: AnimationValues(), repeating: true) { values in
					Circle()
						.trim(from: 0, to: values.trimEnd)
						.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: innerSize / 6, lineCap: .round))
						.frame(width: innerSize, height: innerSize)
						.rotationEffect(.degrees(-90 + values.rotation))
				} keyframes: { _ in
					KeyframeTrack(\.rotation) {
						LinearKeyframe(720, duration: 1.6, timingCurve: .easeInOut)
					}
					KeyframeTrack(\.trimEnd) {
						LinearKeyframe(0.25, duration: 0.8, timingCurve: .easeInOut)
						LinearKeyframe(0.125, duration: 0.8, timingCurve: .easeInOut)
					}
				}
			}
			.frame(width: size.width, height: size.height)
			.onAppear {
				withAnimation(.linear(duration: dotDuration).repeatForever(autoreverses: false)) {
					dotRotation = 360
				}
			}
		}
	}
}

#Preview {
	CircleArcDotSpinView()
		.frame(width: 70, height: 70)
}
