import Foundation
import SwiftUI

struct KeyBindingsView: View {
	@ObservedObject var viewModel: KeyBindingsViewModel

	init(viewModel: KeyBindingsViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		Form {
			ScrollView {
				VStack(alignment: .center) {
					ForEach(UserDefaults.BindingKeys.allCases, id: \.self) { key in
						TextField(text: Binding(
							get: { viewModel.actionBindings[key] ?? "" },
							set: {
								viewModel.actionBindings[key] = $0
							}
						), label: { Text(key.rawValue) })
					}
						.listRowInsets(EdgeInsets())
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

struct KeyBindingsView_Previews: PreviewProvider {
	static var previews: some View {
		KeyBindingsView(viewModel: KeyBindingsViewModel())
	}
}
