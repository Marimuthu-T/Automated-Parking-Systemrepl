public class VehicleDetails
{
    var vehicleName: String = "Not SEt"
    var vehicleNumber: String = "Not Set"

	init()
	{
		
	}

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

