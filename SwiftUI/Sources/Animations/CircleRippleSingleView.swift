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

// MARK: - CircleRippleSingleView
struct CircleRippleSingleView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var scale: CGFloat = 0.1
	@State private var opacity: Double = 1

	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		Circle()
			.stroke(hud.colorAnimation, lineWidth: 5)
			.scaleEffect(scale)
			.opacity(opacity)
			.onAppear {
				startRipple()
			}
	}

	// MARK: - Private Methods
	private func startRipple() {
		withAnimation(.easeOut(duration: duration * 0.7).repeatForever(autoreverses: false)) {
			scale = 1
		}

		withAnimation(.easeIn(duration: duration).repeatForever(autoreverses: false)) {
			opacity = 0
		}
	}
}

#Preview {
	CircleRippleSingleView()
		.frame(width: 70, height: 70)
}
