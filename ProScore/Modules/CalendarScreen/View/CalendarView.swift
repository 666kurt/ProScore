import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date

    var body: some View {
        DatePicker("",
                   selection: $selectedDate,
                   displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .colorScheme(.dark)
            .background(Color.theme.other.calendar)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
