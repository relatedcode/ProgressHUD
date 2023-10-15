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

import Foundation

// MARK: - AnimationType
public enum AnimationType: CaseIterable {
	case none
	case activityIndicator
	case ballVerticalBounce
	case barSweepToggle
	case circleArcDotSpin
	case circleBarSpinFade
	case circleDotSpinFade
	case circlePulseMultiple
	case circlePulseSingle
	case circleRippleMultiple
	case circleRippleSingle
	case circleRotateChase
	case circleStrokeSpin
	case dualDotSidestep
	case horizontalBarScaling
	case horizontalDotScaling
	case pacmanProgress
	case quintupleDotDance
	case semiRingRotation
	case sfSymbolBounce
	case squareCircuitSnake
	case triangleDotShift
}

// MARK: - LiveIcon
public enum LiveIcon {
	case succeed
	case failed
	case added
}
