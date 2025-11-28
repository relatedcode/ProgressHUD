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

// MARK: - PacmanProgressView
struct PacmanProgressView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var mouthOpen: CGFloat = 0
	@State private var dotOffset: CGFloat = 0

	private let duration: Double = 0.7

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let pacmanSize = size.width / 1.5
			let dotSize = size.width / 6
			let initialDotOffset = (size.width - dotSize) / 2
			let moveDistance = -size.width + dotSize

			ZStack {
				PacmanShape(mouthOpen: mouthOpen)
					.stroke(hud.colorAnimation, lineWidth: pacmanSize / 2)
					.frame(width: pacmanSize, height: pacmanSize)
					.offset(x: -pacmanSize / 4)
					.animation(.easeInOut(duration: duration / 2).repeatForever(autoreverses: true), value: mouthOpen)

				Circle()
					.stroke(hud.colorAnimation, lineWidth: dotSize / 2)
					.frame(width: dotSize / 2, height: dotSize / 2)
					.offset(x: initialDotOffset + dotOffset)
					.animation(.easeIn(duration: duration).repeatForever(autoreverses: false), value: dotOffset)
			}
			.frame(width: size.width, height: size.height)
			.onAppear {
				mouthOpen = 1
				dotOffset = moveDistance
			}
		}
	}
}

private struct PacmanShape: Shape {

	var mouthOpen: CGFloat

	var animatableData: CGFloat {
		get { mouthOpen }
		set { mouthOpen = newValue }
	}

	func path(in rect: CGRect) -> Path {
		var path = Path()

		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 4

		let mouthAngle = mouthOpen * 0.125 * 2 * .pi

		path.addArc(
			center: center,
			radius: radius,
			startAngle: .radians(mouthAngle),
			endAngle: .radians(2 * .pi - mouthAngle),
			clockwise: false
		)

		return path
	}
}

#Preview {
	PacmanProgressView()
		.frame(width: 70, height: 70)
}
