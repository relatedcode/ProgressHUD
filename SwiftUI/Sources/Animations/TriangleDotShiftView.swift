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

// MARK: - TriangleDotShiftView
struct TriangleDotShiftView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var offset0: CGSize = .zero
	@State private var offset1: CGSize = .zero
	@State private var offset2: CGSize = .zero

	private let duration: Double = 0.6

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let size = geometry.size
			let radius = size.width / 5
			let moveDistance = size.width - radius * 2

			ZStack {
				Circle()
					.fill(hud.colorAnimation)
					.frame(width: radius * 2, height: radius * 2)
					.offset(offset0)
					.position(x: radius, y: radius)

				Circle()
					.fill(hud.colorAnimation)
					.frame(width: radius * 2, height: radius * 2)
					.offset(offset1)
					.position(x: size.width - radius, y: radius)

				Circle()
					.fill(hud.colorAnimation)
					.frame(width: radius * 2, height: radius * 2)
					.offset(offset2)
					.position(x: size.width / 2, y: size.height - radius)
			}
			.frame(width: size.width, height: size.height)
			.onAppear {
				startAnimation(moveDistance: moveDistance)
			}
		}
	}

	// MARK: - Private Methods
	private func startAnimation(moveDistance: CGFloat) {
		withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
			offset0 = CGSize(width: moveDistance, height: 0)
		}

		withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
			offset1 = CGSize(width: -moveDistance / 2, height: moveDistance)
		}

		withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
			offset2 = CGSize(width: -moveDistance / 2, height: -moveDistance)
		}
	}
}

#Preview {
	TriangleDotShiftView()
		.frame(width: 70, height: 70)
}
