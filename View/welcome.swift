class Welcome
{
	var entryExitCounter: EntryExitCounter?
	init()
	{		
        print(Messages().welcome)
		entryExitCounter = EntryExitCounter()
	}
    func welcome()
    {
		guard entryExitCounter != nil 
		else{
			print("The Parking lot is closed")
			return 
		}
        print(Messages().homeString) 
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                entryExitCounter!.vehicleIn()
                case 2:
                entryExitCounter!.vehicleOut()
                case 3:
                entryExitCounter!.others()
                case 4:
                print(Messages().thankyou)
                return 
                default:
                return welcome()
            }
        }
        else{
            print("Enter Proper Input")
            welcome()
        }
		welcome()
    }

}