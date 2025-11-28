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

// MARK: - DualDotSidestepView
struct DualDotSidestepView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var hollowOffset: CGFloat = 0
	@State private var filledOffset: CGFloat = 0
	@State private var hollowOnTop = false
	@State private var animationTask: Task<Void, Never>?

	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let radius = size.width / 4
			let lineWidth: CGFloat = 3
			let moveDistance = size.width - radius * 2

			ZStack {
				Circle()
					.stroke(hud.colorAnimation, lineWidth: lineWidth)
					.frame(width: radius * 2 - lineWidth, height: radius * 2 - lineWidth)
					.offset(x: -moveDistance / 2 + hollowOffset)
					.zIndex(hollowOnTop ? 1 : 0)

				Circle()
					.fill(hud.colorAnimation)
					.frame(width: radius * 2, height: radius * 2)
					.offset(x: moveDistance / 2 + filledOffset)
					.zIndex(hollowOnTop ? 0 : 1)
			}
			.frame(width: size.width, height: size.height)
			.onAppear {
				startAnimation(moveDistance: moveDistance)
			}
			.onDisappear {
				animationTask?.cancel()
			}
		}
	}

	// MARK: - Private Methods
	private func startAnimation(moveDistance: CGFloat) {
		withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: true)) {
			hollowOffset = moveDistance
			filledOffset = -moveDistance
		}

		animationTask = Task { @MainActor in
			while !Task.isCancelled {
				try? await Task.sleep(for: .seconds(duration))
				if Task.isCancelled { break }
				hollowOnTop.toggle()
			}
		}
	}
}

#Preview {
	DualDotSidestepView()
		.frame(width: 70, height: 70)
}
