public class VehicleDetails
{
    let vehicleName: String!
    let vehicleNumber: String!

    public init(vehicleNumber: String , vehicleName: String )
    {
        self.vehicleName = vehicleName
        self.vehicleNumber = vehicleNumber
    }
}



enum VehicleType: Int {

    case bycycle = 1  
    case bike
    case car
    case van
    case bus
}

