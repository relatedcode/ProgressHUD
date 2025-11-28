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

// MARK: - CircleBarSpinFadeView
struct CircleBarSpinFadeView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	private let barCount = 8
	private let duration: Double = 1.2

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let spacing: CGFloat = 3
			let barWidth = (size.width - 4 * spacing) / 5
			let barHeight = (size.height - 2 * spacing) / 3
			let radius = size.width / 2 - max(barWidth, barHeight) / 2

			ZStack {
				ForEach(0..<barCount, id: \.self) { i in
					SpinningBar(
						index: i,
						barCount: barCount,
						duration: duration,
						color: hud.colorAnimation
					)
					.frame(width: barWidth, height: barHeight)
					.offset(y: -radius)
					.rotationEffect(.degrees(Double(i) * 45))
				}
			}
			.frame(width: size.width, height: size.height)
		}
	}
}

private struct SpinningBar: View {

	let index: Int
	let barCount: Int
	let duration: Double
	let color: Color

	@State private var opacity: Double = 1

	private var delay: Double {
		let delays: [Double] = [0.96, 0.84, 0.72, 0.6, 0.48, 0.36, 0.24, 0.12]
		return delays[index % delays.count]
	}

	var body: some View {
		Capsule()
			.fill(color)
			.opacity(opacity)
			.task {
				try? await Task.sleep(for: .seconds(delay))
				withAnimation(.easeInOut(duration: duration / 2).repeatForever(autoreverses: true)) {
					opacity = 0.3
				}
			}
	}
}

#Preview {
	CircleBarSpinFadeView()
		.frame(width: 70, height: 70)
}
