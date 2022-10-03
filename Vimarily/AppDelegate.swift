import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_: Notification) {
		// Insert code here to initialize your application
	}

	func applicationWillTerminate(_: Notification) {
		// Insert code here to tear down your application
	}

	func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
		return true
	}

	@IBAction func openHelpUrl(_ sender: Any) {
		NSWorkspace.shared.open(URL(string: "https://github.com/marcdonald/vimarily#usage")!)
	}
}
