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

// MARK: - ProgressCircleView
struct ProgressCircleView: View {

	// MARK: - Properties
	let progress: CGFloat
	let color: Color

	// MARK: - Body
	var body: some View {
		ZStack {
			Circle()
				.stroke(color.opacity(0.3), lineWidth: 2)

			Circle()
				.trim(from: 0, to: progress)
				.stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
				.rotationEffect(.degrees(-90))

			Text("\(Int(progress * 100))%")
				.font(.system(size: 12, weight: .semibold))
				.foregroundStyle(color)
		}
		.animation(.easeInOut(duration: 0.2), value: progress)
	}
}

#Preview {
	ProgressCircleView(progress: 0.65, color: .gray)
		.frame(width: 70, height: 70)
}
