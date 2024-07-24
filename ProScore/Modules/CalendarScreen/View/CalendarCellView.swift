import SwiftUI

struct CalendarCellView: View {
    
    let title: String
    let time: Date
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline).fontWeight(.semibold)
                .foregroundColor(Color.theme.text.main)
                .padding(.bottom, 10)
            Group {
                Text("\(date, formatter: dateFormatter)")
                Text("Beginning \(time, formatter: timeFormatter)")
            }
            .foregroundColor(Color.theme.background.light)
            .font(.caption)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.background.second)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    CalendarCellView(title: "The matchup against Pink Panthers", time: Date(), date: Date())
        .padding()
}
