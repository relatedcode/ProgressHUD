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

// MARK: - SemiRingRotationView
struct SemiRingRotationView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var rotation: Double = 0
	@State private var scale: CGFloat = 1.0
	@State private var animationTask: Task<Void, Never>?

	private let duration: TimeInterval = 1.6

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let lineWidth: CGFloat = 6

			ZStack {
				SemiRingHorizontal()
					.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
					.frame(width: size.width, height: size.height)
					.scaleEffect(scale)
					.rotationEffect(.degrees(rotation))

				SemiRingVertical()
					.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
					.frame(width: size.width / 2, height: size.height / 2)
					.scaleEffect(scale)
					.rotationEffect(.degrees(-rotation))
			}
			.frame(width: size.width, height: size.height)
			.onAppear {
				startAnimation()
			}
			.onDisappear {
				animationTask?.cancel()
			}
		}
	}

	// MARK: - Private Methods
	private func startAnimation() {
		animationTask = Task { @MainActor in
			while !Task.isCancelled {
				withAnimation(.easeInOut(duration: duration / 2)) {
					rotation = 180
					scale = 0.6
				}
				try? await Task.sleep(for: .seconds(duration / 2))
				if Task.isCancelled { break }

				withAnimation(.easeInOut(duration: duration / 2)) {
					rotation = 360
					scale = 1.0
				}
				try? await Task.sleep(for: .seconds(duration / 2))
				if Task.isCancelled { break }

				rotation = 0
			}
		}
	}
}

private struct SemiRingHorizontal: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2
		let pi4 = CGFloat.pi / 4

		path.addArc(center: center, radius: radius, startAngle: .radians(3 * pi4), endAngle: .radians(5 * pi4), clockwise: false)

		let startPoint = CGPoint(
			x: center.x + radius * cos(-pi4),
			y: center.y + radius * sin(-pi4)
		)
		path.move(to: startPoint)
		path.addArc(center: center, radius: radius, startAngle: .radians(-pi4), endAngle: .radians(pi4), clockwise: false)

		return path
	}
}

private struct SemiRingVertical: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let radius = min(rect.width, rect.height) / 2
		let pi4 = CGFloat.pi / 4

		path.addArc(center: center, radius: radius, startAngle: .radians(-3 * pi4), endAngle: .radians(-pi4), clockwise: false)

		let startPoint = CGPoint(
			x: center.x + radius * cos(pi4),
			y: center.y + radius * sin(pi4)
		)
		path.move(to: startPoint)
		path.addArc(center: center, radius: radius, startAngle: .radians(pi4), endAngle: .radians(3 * pi4), clockwise: false)

		return path
	}
}

#Preview {
	SemiRingRotationView()
		.frame(width: 70, height: 70)
}
