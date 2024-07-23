import SwiftUI

struct TitleView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle).bold()
                .foregroundColor(Color.theme.text.main)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 30)
    }
}

#Preview {
    TitleView(title: "Team")
}
