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

// MARK: - CirclePulseSingleView
struct CirclePulseSingleView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared
	@State private var scale: CGFloat = 0
	@State private var opacity: Double = 1

	private let duration: Double = 1.0

	// MARK: - Body
	var body: some View {
		Circle()
			.fill(hud.colorAnimation)
			.scaleEffect(scale)
			.opacity(opacity)
			.onAppear {
				startPulse()
			}
	}

	// MARK: - Private Methods
	private func startPulse() {
		scale = 0
		opacity = 1

		withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
			scale = 1
			opacity = 0
		}
	}
}

#Preview {
	CirclePulseSingleView()
		.frame(width: 70, height: 70)
}
