import SwiftUI

struct StatisticsCellView: View {
    
    let title: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(value)")
                .font(.largeTitle).bold()
                .foregroundColor(Color.theme.other.primary)
            Text(title)
                .font(.footnote)
                .foregroundColor(Color.theme.text.main)
        }
        .padding(.vertical, 23)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    StatisticsCellView(title: "Quantity of wins", value: 123)
        .padding()
}
