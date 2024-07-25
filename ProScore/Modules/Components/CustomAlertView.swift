import SwiftUI

struct CustomAlertView: View {
    
    @Binding var showAlert: Bool
    let title: String
    let description: String
    let buttonLabel: String
    let onReset: () -> Void
    
    var body: some View {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .padding(.top)
                    .padding(.bottom, 8)
                
                Text(description)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding([.bottom, .trailing, .leading])
                
                Divider()
                    .background(Color(hex: "#545458"))
                
                HStack {
                    
                    Button {
                        showAlert = false
                    } label: {
                        Text("Close")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                    
                    Divider()
                        .background(Color(hex: "#545458"))
                    
                    Button {
                        onReset()
                        showAlert = false
                    } label: {
                        Text(buttonLabel)
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color.theme.other.primary)
                        
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            }
            .foregroundColor(Color.theme.text.main)
            .zIndex(1)
            .frame(maxWidth: 270, alignment: .center)
            .background(
                Color.theme.background.second
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    CustomAlertView(showAlert: .constant(true),
                    title: "Reset data",
                    description: "Do you really want to reset the data? It'll cause you to lose progress.",
                    buttonLabel: "Reset") {
        //
    }
}
