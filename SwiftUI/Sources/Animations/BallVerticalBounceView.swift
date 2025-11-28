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

// MARK: - BallVerticalBounceView
struct BallVerticalBounceView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let width = size.width
			let height = size.height

			let ballRadius = width * 0.12
			let lineWidth = width * 0.96
			let lineY = height * 0.75
			let topY = height * 0.15

			let fallDistance = (lineY - ballRadius) - topY
			let maxBend = height * 0.2

			let animationDuration: TimeInterval = 0.9

			KeyframeAnimator(initialValue: AnimationPhase(t: 0), repeating: true) { phase in
				let t = phase.t
				let (yOffset, bend) = calculatePhysics(t: t, maxFall: fallDistance, maxBend: maxBend)

				let rubberHeight = maxBend * 1.5

				ZStack {
					RubberBand(bend: bend)
						.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: width * 0.08, lineCap: .round))
						.frame(width: lineWidth, height: rubberHeight)
						.position(x: width / 2, y: lineY + (rubberHeight / 2))

					Circle()
						.fill(hud.colorAnimation)
						.frame(width: ballRadius * 2, height: ballRadius * 2)
						.position(
							x: width / 2,
							y: topY + yOffset
						)
				}
			} keyframes: { _ in
				KeyframeTrack(\.t) {
					LinearKeyframe(1.0, duration: animationDuration)
				}
			}
		}
	}

	// MARK: - Private Methods
	private func calculatePhysics(t: Double, maxFall: CGFloat, maxBend: CGFloat) -> (CGFloat, CGFloat) {
		let fallEnd = 0.40
		let bendEnd = 0.60

		var yOffset: CGFloat = 0
		var currentBend: CGFloat = 0

		if t < fallEnd {
			let nt = t / fallEnd
			let progress = nt * nt
			yOffset = maxFall * CGFloat(progress)
			currentBend = 0

		} else if t < bendEnd {
			let nt = (t - fallEnd) / (bendEnd - fallEnd)

			let bendProgress = sin(nt * .pi)
			currentBend = maxBend * CGFloat(bendProgress)

			yOffset = maxFall + currentBend

		} else {
			let nt = (t - bendEnd) / (1.0 - bendEnd)

			let risingT = 1.0 - nt
			let progress = risingT * risingT

			yOffset = maxFall * CGFloat(progress)
			currentBend = 0
		}

		return (yOffset, currentBend)
	}
}

private struct AnimationPhase {
	var t: Double
}

private struct RubberBand: Shape {
	var bend: CGFloat

	var animatableData: CGFloat {
		get { bend }
		set { bend = newValue }
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()
		let start = CGPoint(x: 0, y: 0)
		let end = CGPoint(x: rect.width, y: 0)

		let control = CGPoint(x: rect.width / 2, y: bend * 2)

		path.move(to: start)
		path.addQuadCurve(to: end, control: control)

		return path
	}
}

#Preview {
	BallVerticalBounceView()
		.frame(width: 70, height: 70)
}
