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

// MARK: - SquareCircuitSnakeView
struct SquareCircuitSnakeView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var animationTask: Task<Void, Never>?
	@State private var head: CGFloat = 0.87
	@State private var tail: CGFloat = 0.75

	private let animationDuration: Double = 1.0
	private let cycleDuration: Double = 1.2
	private let tailDelay: Double = 0.2

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let space = size.width / 6
			let innerSize = size.width - space
			let lineWidth = innerSize / 6

			ZStack {
				RoundedRectangle(cornerRadius: 3)
					.stroke(hud.colorAnimation.opacity(0.3), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
					.frame(width: innerSize, height: innerSize)

				SquareCircuitSnakeShape(head: head, tail: tail)
					.stroke(hud.colorAnimation, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
					.frame(width: innerSize, height: innerSize)
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
			try? await Task.sleep(for: .seconds(0.1))

			while !Task.isCancelled {
				withAnimation(.easeInOut(duration: animationDuration)) {
					head += 1.0 
				}

				Task { @MainActor in
					try? await Task.sleep(for: .seconds(tailDelay))
					if !Task.isCancelled {
						withAnimation(.easeInOut(duration: animationDuration)) {
							tail += 1.0
						}
					}
				}

				try? await Task.sleep(for: .seconds(cycleDuration))
			}
		}
	}
}

private struct SquareCircuitSnakeShape: Shape {
	var head: CGFloat
	var tail: CGFloat

	var animatableData: AnimatablePair<CGFloat, CGFloat> {
		get { AnimatablePair(head, tail) }
		set {
			head = newValue.first
			tail = newValue.second
		}
	}

	func path(in rect: CGRect) -> Path {
		let basePath = RoundedRectangle(cornerRadius: 3).path(in: rect)
		var path = Path()

		let h = head - floor(head)
		let t = tail - floor(tail)

		if h > t {
			path.addPath(basePath.trimmedPath(from: t, to: h))
		} else {
			path.addPath(basePath.trimmedPath(from: t, to: 1.0))
			path.addPath(basePath.trimmedPath(from: 0.0, to: h))
		}

		return path
	}
}

#Preview {
	SquareCircuitSnakeView()
		.frame(width: 70, height: 70)
}
