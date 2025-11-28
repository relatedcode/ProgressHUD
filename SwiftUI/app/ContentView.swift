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

// MARK: - AnimationType Extension
extension AnimationType {

	var text: String {
		switch self {
		case .none: "No Animation"
		case .activityIndicator: "Activity Indicator"
		case .ballVerticalBounce: "Ball Vertical Bounce"
		case .barSweepToggle: "Bar Sweep Toggle"
		case .circleArcDotSpin: "Circle Arc Dot Spin"
		case .circleBarSpinFade: "Circle Bar Spin Fade"
		case .circleDotSpinFade: "Circle Dot Spin Fade"
		case .circlePulseMultiple: "Circle Pulse Multiple"
		case .circlePulseSingle: "Circle Pulse Single"
		case .circleRippleMultiple: "Circle Ripple Multiple"
		case .circleRippleSingle: "Circle Ripple Single"
		case .circleRotateChase: "Circle Rotate Chase"
		case .circleStrokeSpin: "Circle Stroke Spin"
		case .dualDotSidestep: "Dual Dot Sidestep"
		case .horizontalBarScaling: "Horizontal Bar Scaling"
		case .horizontalDotScaling: "Horizontal Dot Scaling"
		case .pacmanProgress: "Pacman Progress"
		case .quintupleDotDance: "Quintuple Dot Dance"
		case .semiRingRotation: "Semi-Ring Rotation"
		case .sfSymbolBounce: "SF Symbol Bounce"
		case .squareCircuitSnake: "Square Circuit Snake"
		case .triangleDotShift: "Triangle Dot Shift"
		}
	}
}

// MARK: - ContentView
struct ContentView: View {

	// MARK: - Properties
	@State private var status: String?
	@State private var progressTimer: Timer?
	@State private var counter: Double = 0
	@State private var bannerToggle = false
	@State private var textFieldValue = ""

	private let animations = AnimationType.allCases
	private let textShort = "Please wait..."
	private let textLong = "Please wait. We need some more time to work out this situation."
	private let textSuccess = "That was awesome!"
	private let textError = "Something went wrong."
	private let textSucceed = "That was awesome!"
	private let textFailed = "Something went wrong."
	private let textAdded = "Successfully added."

	// MARK: - Body
	var body: some View {
		NavigationStack {
			List {
				// MARK: - Banner Actions
				Section("Banner Actions") {
					Button("Show Banner") {
						bannerToggle.toggle()
						ProgressHUD.banner("Banner title", bannerToggle ? textAdded : textLong)
					}
					Button("Hide Banner") {
						ProgressHUD.bannerHide()
					}
				}

				// MARK: - HUD Actions
				Section("HUD Actions") {
					TextField("Text", text: $textFieldValue)
					Button("Dismiss Keyboard") {
						UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
					}
					Button("Dismiss HUD") {
						ProgressHUD.dismiss()
					}
					Button("Remove HUD") {
						ProgressHUD.remove()
					}
				}

				// MARK: - Animation Types
				Section("Animation Types") {
					ForEach(animations, id: \.self) { animation in
						Button(animation.text) {
							if animation != .sfSymbolBounce {
								ProgressHUD.animate(status, animation)
							} else {
								ProgressHUD.animate(status, symbol: randomSymbol())
							}
						}
					}
				}

				// MARK: - Animation
				Section("Animation") {
					Button("Animation - No text") {
						ProgressHUD.animate()
						status = nil
					}
					Button("Animation - Short text") {
						ProgressHUD.animate(textShort)
						status = textShort
					}
					Button("Animation - Longer text") {
						ProgressHUD.animate(textLong)
						status = textLong
					}
				}

				// MARK: - Progress
				Section("Progress") {
					Button("Progress - No text") {
						startProgress(nil)
					}
					Button("Progress - Short text") {
						startProgress(textShort)
					}
					Button("Progress - Longer text") {
						startProgress(textLong)
					}
				}

				// MARK: - Progress
				Section("Progress") {
					Button("Progress - 10%") {
						ProgressHUD.progress(0.1, interaction: true)
					}
					Button("Progress - 40%") {
						ProgressHUD.progress(0.4, interaction: true)
					}
					Button("Progress - 60%") {
						ProgressHUD.progress(0.6, interaction: true)
					}
					Button("Progress - 90%") {
						ProgressHUD.progress(0.9, interaction: true)
					}
				}

				// MARK: - Static Image
				Section("Static Image") {
					Button("Symbol - No text") {
						ProgressHUD.symbol(name: randomSymbol())
					}
					Button("Symbol - Short text") {
						ProgressHUD.symbol(textAdded, name: randomSymbol())
					}
					Button("Success - No text") {
						ProgressHUD.success()
					}
					Button("Success - Short text") {
						ProgressHUD.success(textSuccess)
					}
					Button("Error - No text") {
						ProgressHUD.error()
					}
					Button("Error - Short text") {
						ProgressHUD.error(textError)
					}
				}

				// MARK: - Live Icon
				Section("Live Icon") {
					Button("Succeed - No text") {
						ProgressHUD.succeed()
					}
					Button("Succeed - Short text") {
						ProgressHUD.succeed(textSucceed)
					}
					Button("Failed - No text") {
						ProgressHUD.failed()
					}
					Button("Failed - Short text") {
						ProgressHUD.failed(textFailed)
					}
					Button("Added - No text") {
						ProgressHUD.added()
					}
					Button("Added - Short text") {
						ProgressHUD.added(textAdded)
					}
				}
			}
			.navigationTitle("ProgressHUD")
		}
	}

	// MARK: - Private Methods
	private func startProgress(_ text: String?) {
		counter = 0
		ProgressHUD.progress(text, 0)

		progressTimer?.invalidate()
		let timer = Timer(timeInterval: 0.025, repeats: true) { _ in
			Task { @MainActor in
				counter += 1
				ProgressHUD.progress(text, counter / 100)

				if counter >= 100 {
					progressTimer?.invalidate()
					progressTimer = nil
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
						ProgressHUD.succeed(text, delay: 0.75)
					}
				}
			}
		}
		RunLoop.main.add(timer, forMode: .common)
		progressTimer = timer
	}

	private func randomSymbol() -> String {
		let symbols = ["star.fill", "heart.fill", "bolt.fill", "flame.fill", "leaf.fill",
					   "moon.fill", "sun.max.fill", "cloud.fill", "snowflake", "sparkles"]
		return symbols.randomElement() ?? "star.fill"
	}
}

#Preview {
	ContentView()
		.progressHUD()
}
