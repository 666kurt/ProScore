import SwiftUI

struct ParticipantCellView: View {
    
    let name: String
    let nickname: String
    let game: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .foregroundColor(Color.theme.text.main)
                    Text(nickname)
                        .foregroundColor((Color(hex: "#EBEBF5").opacity(0.6)))
                }
                Spacer()
                Text(game)
                    .foregroundColor((Color(hex: "#EBEBF5").opacity(0.6)))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            Divider()
                .frame(height: 3)
                .background(Color.theme.other.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ParticipantCellView(name: "Robert Robinson", nickname: "Shadowmoon", game: "Dota2")
        .padding()
}
