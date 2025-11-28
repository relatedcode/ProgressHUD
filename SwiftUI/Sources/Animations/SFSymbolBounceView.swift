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

// MARK: - SFSymbolBounceView
struct SFSymbolBounceView: View {

	// MARK: - Properties
	@State private var hud = ProgressHUD.shared

	// MARK: - Body
	@ViewBuilder
	var body: some View {
		if #available(iOS 18.0, *) {
			Image(systemName: hud.animationSymbol)
				.font(.system(size: 40, weight: .bold))
				.foregroundStyle(hud.colorAnimation)
				.symbolEffect(.bounce, options: .repeating)
		} else {
			Image(systemName: hud.animationSymbol)
				.font(.system(size: 40, weight: .bold))
				.foregroundStyle(hud.colorAnimation)
				.symbolEffect(.pulse, options: .repeating)
		}
	}
}

#Preview {
	SFSymbolBounceView()
		.frame(width: 70, height: 70)
}
