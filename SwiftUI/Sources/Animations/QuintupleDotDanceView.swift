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

// MARK: - QuintupleDotDanceView
struct QuintupleDotDanceView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var startDate = Date()

	private let dotCount = 5

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let radius = size.width / 20
			let stroke = size.width / 24
			let startX = radius + stroke
			let circleWidth = radius * 2 + stroke
			let spacing = (size.width - circleWidth * 6) / 5
			let verticalMove = size.height / 3
			let horizontalMove = startX + circleWidth * 5 + spacing * 2

			TimelineView(.animation) { context in
				let elapsed = context.date.timeIntervalSince(startDate)
				let horizontalProgress = 0.5 * (1 - cos(elapsed * .pi))
				let verticalProgress = 0.5 * (1 - cos(elapsed * 2 * .pi))

				let horizontalOffset = horizontalMove * horizontalProgress
				let verticalOffset = verticalMove * verticalProgress

				HStack(spacing: spacing + stroke) {
					ForEach(0..<dotCount, id: \.self) { i in
						Circle()
							.stroke(hud.colorAnimation, lineWidth: stroke)
							.frame(width: radius * 2, height: radius * 2)
							.offset(
								x: i == 0 ? horizontalOffset : 0,
								y: i == 0 ? 0 : (i % 2 == 1 ? -verticalOffset : verticalOffset)
							)
					}
				}
				.frame(width: size.width, height: size.height)
			}
		}
		.onAppear {
			startDate = Date()
		}
	}
}

#Preview {
	QuintupleDotDanceView()
		.frame(width: 70, height: 70)
}
