//
//  MetricKitViewerApp.swift
//  Shared
//
//  Created by Matthew Massicotte on 2022-03-27.
//

import SwiftUI

@main
struct MetricKitViewerApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MetricKitViewerDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
