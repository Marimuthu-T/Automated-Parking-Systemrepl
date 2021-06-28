class EntryExitCounter
{
    var entryExitCounter: EntryExitController! 
    init(){
        print(WelcomeString().welcome)
        do
		{
			self.entryExitCounter = EntryExitController()
		}
    }  

    func vehicleIn()
    {
        var vehicleType: VehicleType!
        var vehicleNumber: String!
        var driverName: String!

        print(WelcomeString().vehicleTypeString)
        if let givenVehicletype = Int(readLine() ?? "k")
        {
            switch givenVehicletype
            {
                case VehicleType.bycycle.rawValue:
                vehicleType = .bycycle
                case VehicleType.bike.rawValue:
                vehicleType = .bike
                case VehicleType.car.rawValue:
                vehicleType = .car
                case VehicleType.van.rawValue:
                vehicleType = .van
                case VehicleType.bus.rawValue:
                vehicleType = .bus
                default:
                return
            }
        }
        else
        {
            print("Enter proper Vehicle Type ")
            return 
        }


        print("       Enter Your Vehicle Number      ")
        if let givenVehicleNumber = readLine()
        {
            vehicleNumber = givenVehicleNumber
        }
        else{
            print("Enter Proper Name")
        }
        print("Enter Driver Name")
        if let givenDriverName = readLine()
        {
            driverName = givenDriverName
        }
        else{
            print("Enter Proper Name")
        }


        self.entryExitCounter.entry(vehicleType: vehicleType, vehicleNumber: vehicleNumber , vehicleName: "car" ,driver: driverName )            
    }

    func vehicleOut()
    {
        print("Enter Your RegisterID")
        if let RegisterID = Int(readLine() ?? "Not")
        {
        self.entryExitCounter.out(registerId: RegisterID)
        }
        else
        {
            print("Enter proper RegisterID")
        }
    }

    func others()
    {
        print("""
                         1 -> PrintSlot
                         2 -> InList
                         3 -> OutList
                         4 -> Exit
        """)
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                return printslot(all: true)
                case 2:
                return SearchWithID()
                case 4:
                return
                default:
                return
            }
        }
        return 
    }
}
 