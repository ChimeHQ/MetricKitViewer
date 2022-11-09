import SwiftUI
import Meter

struct ContentView: View {
    @Binding var document: MetricKitViewerDocument

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TextView(text: document.text)) {
                    Text("Raw Data")
                }
                
                Section(header: Text("Crash Diagnostics")) {
                    ForEach((0..<document.crashDiagnostics.count), id: \.self) { index in
                        NavigationLink(destination: CrashDiagnosticView(diagnostic: document.crashDiagnostics[index])) {
                            Text("Crash \(index + 1)")
                        }
                    }
                }

                Section(header: Text("CPU Exception Diagnostics")) {
                    ForEach((0..<document.cpuExceptionDiagnostics.count), id: \.self) { index in
                        Text("CPU Exception \(index + 1)")
                    }
                }

				Section(header: Text("Hang Diagnostics")) {
					ForEach((0..<document.hangDiagnostics.count), id: \.self) { index in
						Text("Hang \(index + 1)")
					}
				}
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(MetricKitViewerDocument()))
    }
}
