import SwiftUI

struct OutsideLocPanel: View {
    var isLocationActive: Bool
    var body: some View {
        if(isLocationActive){
            HStack {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(4)
                    .foregroundColor(Color("Black"))
                    .symbolEffect(.bounce)
                
                Text("Saat ini kamu sedang berada di halte 🎉")
                    .font(.footnote)
                    .foregroundColor(Color("Black"))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color("White"))
            .cornerRadius(16)
        }
        else {
            HStack {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(4)
                    .foregroundColor(Color("Black"))
                    .symbolEffect(.bounce)

                Text("Saat ini kamu sedang tidak berada di halte 😔")
                    .font(.footnote)
                    .foregroundColor(Color("Black"))
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(Color("White"))
            .cornerRadius(16)
        }
        
    }
        
}

#Preview {
    OutsideLocPanel(isLocationActive: true)
    OutsideLocPanel(isLocationActive: false)
}
