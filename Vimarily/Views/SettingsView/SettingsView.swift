import Foundation
import SwiftUI
import Combine

let numberFormatter: NumberFormatter = {
    var nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.allowsFloats = false
    nf.minimum = 0
    return nf
}()

struct SettingsView: View {
	@ObservedObject private var viewModel: SettingsViewModel

	init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		Form {
			ScrollView {
				VStack(alignment: .leading, spacing: 16) {
					Section(header: Text("Scroll").font(.title)) {
                        TextField("Scroll Size", value: $viewModel.scrollSize, formatter: numberFormatter)
					
                        TextField("Scroll Duration", value: $viewModel.scrollDuration, formatter: numberFormatter)


						Toggle(isOn: $viewModel.smoothScroll, label: { Text("Smooth Scroll") })
					}

					Divider()

					Section(header: Text("Keys").font(.title)) {
						// TODO key entry
						TextField("Modifier", text: $viewModel.modifier, prompt: Text("No Modifier Key Set"))
						TextField("Link Hint Characters", text: $viewModel.linkHintCharacters)
						Toggle("Transparent Bindings", isOn: $viewModel.transparentBindings)
					}

					Divider()

					Section(header: Text("Miscellaneous").font(.title)) {
						// TODO multi-entry
						TextField("Excluded URLs (Comma Separated)", text: $viewModel.excludedUrls[0], prompt: Text("No Excluded URLs"))
						TextField("Open Tab URL", text: $viewModel.openTabUrl)
						Toggle("Detect by Cursor Style", isOn: $viewModel.detectByCursorStyle)
					}
				}
			}
			HStack {
				Button(
					role: .destructive,
					action: viewModel.reset,
					label: { Text("Reset to Default") }
				)
				Button(
					action: viewModel.save,
					label: { Text("Save") }
				).buttonStyle(.borderedProminent)
			}
				.frame(maxWidth: .infinity)
			ReloadReminder()
		}
			.padding(EdgeInsets(top: 0, leading: 8, bottom: 6, trailing: 8))
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var previews: some View {
		SettingsView(viewModel: SettingsViewModel())
	}
}
