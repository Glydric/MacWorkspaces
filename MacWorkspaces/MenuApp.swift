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
				Button(action: addWorkspace) {
					Image(systemName: "plus.rectangle.fill.on.rectangle.fill")
					Text("Add Workspace")
				}
				.help("Add current virtual Desktops as a single workspace")
				.hidden(workspaces.count > 9)
				
				
				Button(action: {deleteWorkspace()}) {
					Image(systemName: "minus.rectangle.fill")
					Text("Delete Last Workspace")
				}
				.help("Add current virtual Desktops as a single workspace")
				.hidden(workspaces.count < 1)
				
				MenuButton("Set workspace") {
					ForEach(workspaces, id: \.self) { workspace in
						Button(action: { setWorkspace(workspace) }) {
							Text(workspace.description)
						}
						
					}
				}
				.hidden(workspaces.isEmpty)
			}, label: {
				Text("Workspace")
			}
		)
	}
	func deleteWorkspace() {
		workspaces
			.removeLast()
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
			
			window.makeKey()
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
			// if the execution is successfull increment the timer
			if toWindow(w, wait: time){
				time = time + .milliseconds(300)
			}
			
			w.orderBack(nil)
		}
		
		NSApp.deactivate()
	}
	
	func toWindow(
		_ window: NSWindow,
		force: Bool = false,
		wait time: DispatchTime = .now()
	) -> Bool {
		guard force || !window.isOnActiveSpace else {
			return false
		}
		
		DispatchQueue.main.asyncAfter(deadline: time){
			NSApp.activate(ignoringOtherApps: true)
			
			window.orderFront(nil)
		}
		
		return true
	}
}
