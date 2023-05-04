import SwiftUI
import Cocoa
import OSLog

struct GeneralView: View {
	@ObservedObject var viewModel: GeneralViewModel

	init(viewModel: GeneralViewModel) {
		self.viewModel = viewModel
		viewModel.fetchExtensionStatus()
	}

	var body: some View {
		TabView {
			SafariConfigView(viewModel: viewModel)
				.tabItem {
					Label("General", systemImage: "safari")
				}

			SettingsView(viewModel: SettingsViewModel())
				.tabItem {
					Label("Settings", systemImage: "puzzlepiece.extension")
				}

			KeyBindingsView(viewModel: KeyBindingsViewModel())
				.tabItem {
					Label("Key Bindings", systemImage: "keyboard")
				}
		}
	}

	private struct SafariConfigView: View {
		@ObservedObject private var viewModel: GeneralViewModel
		let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

		init(viewModel: GeneralViewModel) {
			self.viewModel = viewModel
		}

		var body: some View {
			VStack(alignment: .center) {
				Image("Logo").resizable().scaledToFit().frame(maxHeight: 256).aspectRatio(contentMode: .fit).padding()
				VStack(alignment: .center, spacing: 16) {
					Text("Vimarily").font(.title)
					Text("Status: \(viewModel.extensionStatus)").font(.title2)
					Button(action: viewModel.fetchExtensionStatus) {
						Text("Refresh Extension Status")
					}
					Button(action: viewModel.openSafariExtensionPreferencesClick) {
						Text("Open Safari Extension Preferences")
					}
					Text("Version: \(appVersion ?? "Unknown")").font(.footnote)
				}
					.padding()
			}
				.padding()
		}
	}
}

struct GeneralView_Previews: PreviewProvider {
	static var previews: some View {
		GeneralView(viewModel: GeneralViewModel())
	}
}
