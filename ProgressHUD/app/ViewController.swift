//
// Copyright (c) 2023 Related Code - https://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

// MARK: - AnimationType
extension AnimationType {
	var text: String {
		switch self {
		case .none:						return "No Animation"
		case .activityIndicator:		return "Activity Indicator"
		case .ballVerticalBounce:		return "Ball Vertical Bounce"
		case .barSweepToggle:			return "Bar Sweep Toggle"
		case .circleArcDotSpin:			return "Circle Arc Dot Spin"
		case .circleBarSpinFade:		return "Circle Bar Spin Fade"
		case .circleDotSpinFade:		return "Circle Dot Spin Fade"
		case .circlePulseMultiple:		return "Circle Pulse Multiple"
		case .circlePulseSingle:		return "Circle Pulse Single"
		case .circleRippleMultiple:		return "Circle Ripple Multiple"
		case .circleRippleSingle:		return "Circle Ripple Single"
		case .circleRotateChase:		return "Circle Rotate Chase"
		case .circleStrokeSpin:			return "Circle Stroke Spin"
		case .dualDotSidestep:			return "Dual Dot Sidestep"
		case .horizontalBarScaling:		return "Horizontal Bar Scaling"
		case .horizontalDotScaling:		return "Horizontal Dot Scaling"
		case .pacmanProgress:			return "Pacman Progress"
		case .quintupleDotDance:		return "Quintuple Dot Dance"
		case .semiRingRotation:			return "Semi-Ring Rotation"
		case .sfSymbolBounce:			return "SF Symbol Bounce"
		case .squareCircuitSnake:		return "Square Circuit Snake"
		case .triangleDotShift:			return "Triangle Dot Shift"
		}
	}
}

// MARK: - ViewController
class ViewController: UITableViewController {

	@IBOutlet var cellText: UITableViewCell!

	var animations = AnimationType.allCases
	var symbols: [String] = []

	var actions1: [String] = []
	var actions2: [String] = []
	var actions3: [String] = []
	var actions4: [String] = []
	var actions5: [String] = []

	var timer: Timer?
	var status: String?
	var counter = 0.0

	let textShort	= "Please wait..."
	let textLong	= "Please wait. We need some more time to work out this situation."

	let textSuccess	= "That was awesome!"
	let textError	= "Something went wrong."

	let textSucceed	= "That was awesome!"
	let textFailed	= "Something went wrong."
	let textAdded	= "Successfully added."

	var boolText = false

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "ProgressHUD"

		DispatchQueue.main.async {
			self.loadSymbols()
		}

		actions1.append("Animation - No text")
		actions1.append("Animation - Short text")
		actions1.append("Animation - Longer text")

		actions2.append("Progress - No text")
		actions2.append("Progress - Short text")
		actions2.append("Progress - Longer text")

		actions3.append("Progress - 10%")
		actions3.append("Progress - 40%")
		actions3.append("Progress - 60%")
		actions3.append("Progress - 90%")

		actions4.append("Symbol - No text")
		actions4.append("Symbol - Short text")
		actions4.append("Success - No text")
		actions4.append("Success - Short text")
		actions4.append("Error - No text")
		actions4.append("Error - Short text")

		actions5.append("Succeed - No text")
		actions5.append("Succeed - Short text")
		actions5.append("Failed - No text")
		actions5.append("Failed - Short text")
		actions5.append("Added - No text")
		actions5.append("Added - Short text")

		ProgressHUD.colorAnimation = .systemRed
		ProgressHUD.colorProgress = .systemRed
	}
}

// MARK: - Progress Methods
extension ViewController {

	func progressStart(_ status: String? = nil) {
		counter = 0
		ProgressHUD.progress(status, counter/100)

		timer = Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			self.progressStep(status)
		}
	}

	func progressStep(_ status: String?) {
		counter += 1
		ProgressHUD.progress(status, counter/100)

		if (counter >= 100) {
			progressStop(status)
		}
	}

	func progressStop(_ status: String?) {
		timer?.invalidate()
		timer = nil

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
			ProgressHUD.succeed(status, interaction: false, delay: 0.75)
		}
	}
}

// MARK: - UITableViewDataSource
extension ViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 8
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if (section == 0) { return 2 }
		if (section == 1) { return 4 }

		if (section == 2) { return animations.count	}
		if (section == 3) { return actions1.count	}
		if (section == 4) { return actions2.count	}
		if (section == 5) { return actions3.count	}
		if (section == 6) { return actions4.count	}
		if (section == 7) { return actions5.count	}

		return 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if (indexPath.section == 0) && (indexPath.row == 0) { return cellWithText(tableView, "Show Banner") }
		if (indexPath.section == 0) && (indexPath.row == 1) { return cellWithText(tableView, "Hide Banner") }

		if (indexPath.section == 1) && (indexPath.row == 0) { return cellText }
		if (indexPath.section == 1) && (indexPath.row == 1) { return cellWithText(tableView, "Dismiss Keyboard") }
		if (indexPath.section == 1) && (indexPath.row == 2) { return cellWithText(tableView, "Dismiss HUD") }
		if (indexPath.section == 1) && (indexPath.row == 3) { return cellWithText(tableView, "Remove HUD") }

		if (indexPath.section == 2) { return cellWithText(tableView, animations[indexPath.row].text) }
		if (indexPath.section == 3) { return cellWithText(tableView, actions1[indexPath.row]) }
		if (indexPath.section == 4) { return cellWithText(tableView, actions2[indexPath.row]) }
		if (indexPath.section == 5) { return cellWithText(tableView, actions3[indexPath.row]) }
		if (indexPath.section == 6) { return cellWithText(tableView, actions4[indexPath.row]) }
		if (indexPath.section == 7) { return cellWithText(tableView, actions5[indexPath.row]) }

		return UITableViewCell()
	}

	func cellWithText(_ tableView: UITableView, _ text: String) -> UITableViewCell {
		var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
		if (cell == nil) { cell = UITableViewCell(style: .default, reuseIdentifier: "cell") }
		cell.textLabel?.text = text
		return cell
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if (section == 0) { return "Banner Actions"		}
		if (section == 1) { return "HUD Actions"		}
		if (section == 2) { return "Animation Types"	}
		if (section == 3) { return "Animation"			}
		if (section == 4) { return "Progress"			}
		if (section == 5) { return "Progress"			}
		if (section == 6) { return "Static Image"		}
		if (section == 7) { return "Live Icon"			}
		return nil
	}
}

// MARK: - UITableViewDelegate
extension ViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		if (indexPath.section == 0) {
			if (indexPath.row == 0) { ProgressHUD.banner("Banner title", toggleText()) }
			if (indexPath.row == 1) { ProgressHUD.bannerHide() }
		}

		if (indexPath.section == 1) {
			if (indexPath.row == 1) { view.endEditing(true) }
			if (indexPath.row == 2) { ProgressHUD.dismiss()	}
			if (indexPath.row == 3) { ProgressHUD.remove()	}
		}

		if (indexPath.section == 2)	{
			let animation = animations[indexPath.row]
			if (animation != .sfSymbolBounce) {
				ProgressHUD.animate(status, animation)
			} else {
				ProgressHUD.animate(status, symbol: symbol())
			}
		}

		if (indexPath.section == 3) {
			if (indexPath.row == 0) { ProgressHUD.animate();			status = nil		}
			if (indexPath.row == 1) { ProgressHUD.animate(textShort);	status = textShort	}
			if (indexPath.row == 2) { ProgressHUD.animate(textLong);	status = textLong	}
		}

		if (indexPath.section == 4) {
			if (indexPath.row == 0) { progressStart()			}
			if (indexPath.row == 1) { progressStart(textShort)	}
			if (indexPath.row == 2) { progressStart(textLong)	}
		}

		if (indexPath.section == 5) {
			if (indexPath.row == 0) { ProgressHUD.progress(0.1, interaction: true)	}
			if (indexPath.row == 1) { ProgressHUD.progress(0.4, interaction: true)	}
			if (indexPath.row == 2) { ProgressHUD.progress(0.6, interaction: true)	}
			if (indexPath.row == 3) { ProgressHUD.progress(0.9, interaction: true)	}
		}

		if (indexPath.section == 6) {
			if (indexPath.row == 0) { ProgressHUD.symbol(name: symbol())			}
			if (indexPath.row == 1) { ProgressHUD.symbol(textAdded, name: symbol())	}
			if (indexPath.row == 2) { ProgressHUD.success()							}
			if (indexPath.row == 3) { ProgressHUD.success(textSuccess)				}
			if (indexPath.row == 4) { ProgressHUD.error()							}
			if (indexPath.row == 5) { ProgressHUD.error(textError)					}
		}

		if (indexPath.section == 7) {
			if (indexPath.row == 0) { ProgressHUD.succeed()				}
			if (indexPath.row == 1) { ProgressHUD.succeed(textSucceed)	}
			if (indexPath.row == 2) { ProgressHUD.failed()				}
			if (indexPath.row == 3) { ProgressHUD.failed(textFailed)	}
			if (indexPath.row == 4) { ProgressHUD.added()				}
			if (indexPath.row == 5) { ProgressHUD.added(textAdded)		}
		}
	}
}

// MARK: - Helper Methods
extension ViewController {

	func loadSymbols() {
		if let bundle = Bundle(identifier: "com.apple.CoreGlyphs") {
			if let path = bundle.path(forResource: "symbol_search", ofType: "plist") {
				if let values = NSDictionary(contentsOfFile: path) as? [String: [String]] {
					symbols = Array(values.keys)
				}
			}
		}
	}

	func symbol() -> String {
		symbols.randomElement() ?? "questionmark"
	}

	func toggleText() -> String {
		boolText = !boolText
		return boolText ? textAdded : textLong
	}
}
