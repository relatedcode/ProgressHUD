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

// MARK: - CircleDotSpinFadeView
struct CircleDotSpinFadeView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let dotCount = 8
	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let spacing: CGFloat = 3
			let dotRadius = (size.width - 4 * spacing) / 3.5
			let circleRadius = (size.width - dotRadius) / 2

			ZStack {
				ForEach(0..<dotCount, id: \.self) { i in
					SpinningDot(
						index: i,
						dotCount: dotCount,
						duration: duration,
						color: hud.colorAnimation
					)
					.frame(width: dotRadius, height: dotRadius)
					.offset(y: -circleRadius)
					.rotationEffect(.degrees(Double(i) * 45))
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct SpinningDot: View {

	let index: Int
	let dotCount: Int
	let duration: Double
	let color: Color

	@State private var scale: CGFloat = 1
	@State private var opacity: Double = 1

	private var delay: Double {
		let delays: [Double] = [0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12, 0]
		return delays[index % delays.count]
	}

	var body: some View {
		Circle()
			.fill(color)
			.scaleEffect(scale)
			.opacity(opacity)
			.task {
				try? await Task.sleep(for: .seconds(delay))
				withAnimation(.linear(duration: duration / 2).repeatForever(autoreverses: true)) {
					scale = 0.4
					opacity = 0.3
				}
			}
	}
}

#Preview {
	CircleDotSpinFadeView()
		.frame(width: 70, height: 70)
}
