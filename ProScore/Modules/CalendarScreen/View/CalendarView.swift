import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date

    var body: some View {
        DatePicker("",
                   selection: $selectedDate,
                   displayedComponents: [.date])
            .datePickerStyle(.graphical)
            .id(selectedDate)
            .colorScheme(.dark)
            .background(Color.theme.other.calendar)
            .frame(width: 360, height: 320)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CalendarView(selectedDate: .constant(Date()))
}
