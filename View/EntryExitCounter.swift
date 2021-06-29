class EntryExitCounter
{
    var entryExitCounter: EntryExitController! 
    init(){
        self.entryExitCounter = EntryExitController()
    }  

    func vehicleIn()
    {
        var vehicleType: VehicleType = .car
        var vehicleNumber: String = "Not Set"
        var driverName: String = "Not Set"

        print(Messages().vehicleTypeString)
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
            print(Messages.input.wrongInput("VehicleType"))
            return 
        }


        print(Messages.input.vehicleNumber.rawValue)
        if let givenVehicleNumber = readLine()
        {
            vehicleNumber = givenVehicleNumber
        }
        else{
            print(Messages.input.wrongInput("vehicleNumber"))
        }
        print(Messages.input.vehicleName.rawValue)


        if let givenDriverName = readLine()
        {
            driverName = givenDriverName
        }
        else
		{
            print(Messages.input.wrongInput("DriverName"))
        }


        self.entryExitCounter.entry(vehicleType: vehicleType, vehicleNumber: vehicleNumber , vehicleName: "car" ,driver: driverName )            
    }

    func vehicleOut()
    {
        print(Messages.input.registerID.rawValue)
        if let RegisterID = Int(readLine() ?? "Not")
        {
        self.entryExitCounter.out(registerId: RegisterID)
        }
        else
        {
            print(Messages.input.wrongInput("RegisterID"))
        }
    }

    func others()
    {
        print(Messages().otherOptions)
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
 