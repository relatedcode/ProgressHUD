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

// MARK: - BarSweepToggleView
struct BarSweepToggleView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	struct AnimationValues {
		var trimStart: CGFloat = 0.0
		var trimEnd: CGFloat = 0.0
		var translationProgress: CGFloat = 0.0
	}

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let height = size.height
			let width = size.width

			let heightBar = height / 6
			let widthBar = width - heightBar / 2
			let border: CGFloat = 5
			let maxTranslation = widthBar / 2

			ZStack {
				RoundedRectangle(cornerRadius: height)
					.stroke(hud.colorAnimation, lineWidth: border)
					.frame(width: width + border, height: heightBar + 2 * border)

				KeyframeAnimator(
					initialValue: AnimationValues(),
					repeating: true
				) { values in
					SweepBarShape(
						trimStart: values.trimStart,
						trimEnd: values.trimEnd,
						translation: values.translationProgress * maxTranslation,
						heightBar: heightBar,
						widthBar: widthBar
					)
					.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: heightBar, lineCap: .round))
					.frame(width: width, height: height)
				} keyframes: { _ in
					let duration = 0.9

					KeyframeTrack(\.trimEnd) {
						CubicKeyframe(1.0, duration: duration * 0.5)
						LinearKeyframe(1.0, duration: duration * 0.5)

						LinearKeyframe(1.0, duration: duration * 0.5)
						CubicKeyframe(0.0, duration: duration * 0.5)
					}

					KeyframeTrack(\.trimStart) {
						LinearKeyframe(0.0, duration: duration * 0.5)
						CubicKeyframe(1.0, duration: duration * 0.5)

						CubicKeyframe(0.0, duration: duration * 0.5)
						LinearKeyframe(0.0, duration: duration * 0.5)
					}

					KeyframeTrack(\.translationProgress) {
						CubicKeyframe(1.0, duration: duration)
						CubicKeyframe(0.0, duration: duration)
					}
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct SweepBarShape: Shape {
	var trimStart: CGFloat
	var trimEnd: CGFloat
	var translation: CGFloat
	let heightBar: CGFloat
	let widthBar: CGFloat

	var animatableData: AnimatablePair<AnimatablePair<CGFloat, CGFloat>, CGFloat> {
		get { AnimatablePair(AnimatablePair(trimStart, trimEnd), translation) }
		set {
			trimStart = newValue.first.first
			trimEnd = newValue.first.second
			translation = newValue.second
		}
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()

		let pathStart = heightBar / 2
		let pathEnd = widthBar / 2
		let pathLength = pathEnd - pathStart

		let currentPathStart = pathStart + (trimStart * pathLength)
		let currentPathEnd = pathStart + (trimEnd * pathLength)

		let finalStart = currentPathStart + translation
		let finalEnd = currentPathEnd + translation

		let y = rect.height / 2

		path.move(to: CGPoint(x: finalStart, y: y))
		path.addLine(to: CGPoint(x: finalEnd, y: y))

		return path
	}
}

#Preview {
	BarSweepToggleView()
		.frame(width: 70, height: 70)
}
