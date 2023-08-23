//
//  MenuApp.swift
//  MacWorkspaces
//
//  Created by Leonardo Migliorelli on 23/08/23.
//

import SwiftUI
import AppKit

struct MenuApp: Scene {
	@State var workspaces = [Workspace]()
	
	var body: some Scene {
		MenuBarExtra(
			content: {
				Button("Add Workspace", action: addWorkspace)
					.disabled(workspaces.count > 9)
				
				Button("Delete Last Workspace", action: {workspaces.removeLast()})
					.disabled(workspaces.count <= 1)
				
				ForEach(workspaces, id: \.self) { workspace in
					Button(
						"Switch to \(workspace.title) \(workspace.id)",
						action: { setWorkspace(workspace) }
					)
				}
			}, label: {
				Text("Workspace")
			}
		)
	}
	
	func addWorkspace() {
		var workspace = Workspace(id: (workspaces.last?.id ?? -1) + 1)
		
		for s in NSScreen.screens {
			let window = NSWindow(
				contentRect: s.frame,
				styleMask: .titled, //.borderless,
				backing: .buffered,
				defer: false,
				screen: s
			)
			
			window.collectionBehavior = [.canJoinAllApplications] // .fullScreenNone, .managed,
			
			window.titlebarAppearsTransparent = true
			window.isOpaque = false
			window.backgroundColor = .clear
			window.hidesOnDeactivate = true
			window.canHide = true
			
			workspace.windows.append(window)
		}
		
		workspaces.append(workspace)
		
		
		for w in workspace.windows {
			toWindow(w, force: true)
		}
	}
	
	func setWorkspace(_ workspace: Workspace){
		var time: DispatchTime = .now()
		
		for w in workspace.windows {
			time = time + .milliseconds(260)
			DispatchQueue.main.asyncAfter(deadline: time){
				toWindow(w)
			}
		}
		
		NSApp.deactivate()
	}
	func toWindow(_ window: NSWindow, force: Bool = false){
		// check that the window is actually connected
		//		guard NSScreen.screens.contains(where: { window.screen == $0 }) else {
		//			print("Screen \(window.screen?.description) not available")
		//			return
		//		}
		
		if !force && window.isOnActiveSpace {
			return
		}
		
		NSApp.activate(ignoringOtherApps: true)
		
		window.makeKeyAndOrderFront(nil)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(10)) {
			NSApp.hide(window)
		}
		
	}
}
