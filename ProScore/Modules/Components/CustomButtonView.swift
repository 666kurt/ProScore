import SwiftUI

struct CustomButtonView: View {
    
    let buttonLabel: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonLabel)
                .padding(.vertical, 7)
                .padding(.horizontal, 50)
                .foregroundColor(Color.theme.text.main)
                .background(Color.theme.other.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }

    }
}

#Preview {
    CustomButtonView(buttonLabel: "Add information") {
        //
    }
}
