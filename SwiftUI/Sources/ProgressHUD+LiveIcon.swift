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

// MARK: - LiveIconSucceedView
struct LiveIconSucceedView: View {

	// MARK: - Properties
	@State private var progress: CGFloat = 0

	let color: Color
	let animationID: UUID

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let length = geometry.size.width
			Path { path in
				path.move(to: CGPoint(x: length * 0.15, y: length * 0.50))
				path.addLine(to: CGPoint(x: length * 0.5, y: length * 0.80))
				path.addLine(to: CGPoint(x: length * 1.0, y: length * 0.25))
			}
			.trim(from: 0, to: progress)
			.stroke(color, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
		}
		.task(id: animationID) {
			progress = 0
			try? await Task.sleep(for: .milliseconds(150))
			withAnimation(.easeOut(duration: 0.25)) {
				progress = 1
			}
		}
	}
}

// MARK: - LiveIconFailedView
struct LiveIconFailedView: View {

	// MARK: - Properties
	@State private var progress1: CGFloat = 0
	@State private var progress2: CGFloat = 0

	let color: Color
	let animationID: UUID

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let length = geometry.size.width
			ZStack {
				Path { path in
					path.move(to: CGPoint(x: length * 0.15, y: length * 0.15))
					path.addLine(to: CGPoint(x: length * 0.85, y: length * 0.85))
				}
				.trim(from: 0, to: progress1)
				.stroke(color, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))

				Path { path in
					path.move(to: CGPoint(x: length * 0.15, y: length * 0.85))
					path.addLine(to: CGPoint(x: length * 0.85, y: length * 0.15))
				}
				.trim(from: 0, to: progress2)
				.stroke(color, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
			}
		}
		.task(id: animationID) {
			progress1 = 0
			progress2 = 0
			try? await Task.sleep(for: .milliseconds(150))
			withAnimation(.easeOut(duration: 0.15)) {
				progress1 = 1
			}
			try? await Task.sleep(for: .milliseconds(150))
			withAnimation(.easeOut(duration: 0.15)) {
				progress2 = 1
			}
		}
	}
}

// MARK: - LiveIconAddedView
struct LiveIconAddedView: View {

	// MARK: - Properties
	@State private var progress1: CGFloat = 0
	@State private var progress2: CGFloat = 0

	let color: Color
	let animationID: UUID

	// MARK: - Body
	var body: some View {
		GeometryReader { geometry in
			let length = geometry.size.width
			ZStack {
				Path { path in
					path.move(to: CGPoint(x: length * 0.1, y: length * 0.5))
					path.addLine(to: CGPoint(x: length * 0.9, y: length * 0.5))
				}
				.trim(from: 0, to: progress1)
				.stroke(color, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))

				Path { path in
					path.move(to: CGPoint(x: length * 0.5, y: length * 0.1))
					path.addLine(to: CGPoint(x: length * 0.5, y: length * 0.9))
				}
				.trim(from: 0, to: progress2)
				.stroke(color, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
			}
		}
		.task(id: animationID) {
			progress1 = 0
			progress2 = 0
			try? await Task.sleep(for: .milliseconds(150))
			withAnimation(.easeOut(duration: 0.15)) {
				progress1 = 1
			}
			try? await Task.sleep(for: .milliseconds(150))
			withAnimation(.easeOut(duration: 0.15)) {
				progress2 = 1
			}
		}
	}
}

#Preview("Succeed") {
	LiveIconSucceedView(color: .green, animationID: UUID())
		.frame(width: 70, height: 70)
}

#Preview("Failed") {
	LiveIconFailedView(color: .red, animationID: UUID())
		.frame(width: 70, height: 70)
}

#Preview("Added") {
	LiveIconAddedView(color: .blue, animationID: UUID())
		.frame(width: 70, height: 70)
}
