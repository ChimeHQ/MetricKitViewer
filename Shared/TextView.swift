import SwiftUI

struct TextView: View {
    let text: String

    var body: some View {
        ScrollView {
            Text(text)
                .frame(minWidth: 100.0, idealWidth: 400.0, maxWidth: 900.0)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: "hello")
    }
}
