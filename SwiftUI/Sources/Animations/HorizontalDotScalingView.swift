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

// MARK: - HorizontalDotScalingView
struct HorizontalDotScalingView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let dotCount = 3
	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let spacing: CGFloat = 3
			let dotSize = (size.width - spacing * 2) / 3

			HStack(spacing: spacing) {
				ForEach(0..<dotCount, id: \.self) { i in
					ScalingDot(
						index: i,
						duration: duration,
						color: hud.colorAnimation
					)
					.frame(width: dotSize, height: dotSize)
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct ScalingDot: View {

	let index: Int
	let duration: Double
	let color: Color

	@State private var scale: CGFloat = 1

	private var delay: Double {
		let delays: [Double] = [0.36, 0.24, 0.12]
		return delays[index % delays.count]
	}

	var body: some View {
		Circle()
			.fill(color)
			.scaleEffect(scale)
			.task {
				try? await Task.sleep(for: .seconds(delay))
				withAnimation(.easeInOut(duration: duration / 2).repeatForever(autoreverses: true)) {
					scale = 0.3
				}
			}
	}
}

#Preview {
	HorizontalDotScalingView()
		.frame(width: 70, height: 70)
}
