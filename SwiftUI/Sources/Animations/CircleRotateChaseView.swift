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

// MARK: - CircleRotateChaseView
struct CircleRotateChaseView: View {

	// MARK: - Properties
	@State private var isAnimating = false

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let spacing: CGFloat = 3
			let dotSize = (size.width - 4 * spacing) / 4
			let pathRadius = dotSize * 2

			ZStack {
				ForEach(0..<5) { i in
					let rate = Double(i) / 5.0
					let fromScale = 1 - rate
					let toScale = 0.2 + rate

					let animation = Animation.timingCurve(0.5, 0.15 + rate, 0.25, 1, duration: 1.5)
						.repeatForever(autoreverses: false)

					Color.clear
						.frame(width: size.width, height: size.height)
						.overlay(
							Circle()
								.fill(ProgressHUD.shared.colorAnimation)
								.frame(width: dotSize, height: dotSize)
								.scaleEffect(isAnimating ? toScale : fromScale)
								.offset(y: -pathRadius)
						)
						.rotationEffect(.degrees(isAnimating ? 360 : 0))
						.animation(animation, value: isAnimating)
				}
			}
			.frame(width: size.width, height: size.height)
			.scaleEffect(1.15)
			.onAppear {
				isAnimating = true
			}
		}
	}
}

#Preview {
	CircleRotateChaseView()
		.frame(width: 100, height: 100)
}
