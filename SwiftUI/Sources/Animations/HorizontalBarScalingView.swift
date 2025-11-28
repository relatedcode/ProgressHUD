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

// MARK: - HorizontalBarScalingView
struct HorizontalBarScalingView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let barCount = 5
	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let barWidth = size.width / 9

			HStack(spacing: barWidth) {
				ForEach(0..<barCount, id: \.self) { i in
					ScalingBar(
						index: i,
						duration: duration,
						color: hud.colorAnimation
					)
					.frame(width: barWidth, height: size.height)
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct ScalingBar: View {

	let index: Int
	let duration: Double
	let color: Color

	@State private var scaleY: CGFloat = 0.9

	private var delay: Double {
		let delays: [Double] = [0.5, 0.4, 0.3, 0.2, 0.1]
		return delays[index % delays.count]
	}

	var body: some View {
		Capsule()
			.fill(color)
			.scaleEffect(y: scaleY)
			.task {
				try? await Task.sleep(for: .seconds(delay))
				withAnimation(.easeInOut(duration: duration / 2).repeatForever(autoreverses: true)) {
					scaleY = 0.4
				}
			}
	}
}

#Preview {
	HorizontalBarScalingView()
		.frame(width: 70, height: 70)
}
