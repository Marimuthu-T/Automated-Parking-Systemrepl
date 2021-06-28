class EntryCounter
{
    var counter: EntryExit! 
	var homeString = """

                                       -Home-   
                         1 -> Vehicle IN
                         2 -> Vehicle Out
                         3 -> Other Options
                         4 -> Exit
        """

    var vehicleTypeString = """

                                       -Enter Your Vehicle Type-   
                        1 -> bycycle  
                        2 -> bike
                        3 -> car
                        4 -> van
                        5 -> bus
        """


    init(){
        print(" -----------------------WELCOME TO AUTO PARKER-----------------------------")
        do
		{
			self.counter = EntryExit()
		}
    }


    func welcome()
    {
        print(homeString) 
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                vehicleIn()
                case 2:
                vehicleOut()
                case 3:
                others()
                case 4:
                print("  ---------------------  Thank You -----------------------")
                return 
                default:
                return welcome()
            }
            welcome()
        }
        else{
            print("Enter Proper Input")
            welcome()
        }
    }

    func vehicleIn()
    {
        var vehicleType: VehicleType!
        var vehicleNumber: String!
        var driverName: String!

        print(vehicleTypeString)
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


        self.counter.entry(vehicleType: vehicleType, vehicleNumber: vehicleNumber , vehicleName: "car" ,driver: driverName )            
    }

    func vehicleOut()
    {
        print("Enter Your RegisterID")
        if let RegisterID = Int(readLine() ?? "Not")
        {
        self.counter.out(registerId: RegisterID)
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
 