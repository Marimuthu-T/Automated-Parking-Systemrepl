class Welcome
{
	var entryExitCounter: EntryExitCounter!

	init()
	{
		entryExitCounter = EntryExitCounter()
	}
    func welcome()
    {
        print(WelcomeString().homeString) 
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                entryExitCounter.vehicleIn()
                case 2:
                entryExitCounter.vehicleOut()
                case 3:
                entryExitCounter.others()
                case 4:
                print("  ---------------------  Thank You -----------------------")
                return 
                default:
                return welcome()
            }
        }
        else{
            print("Enter Proper Input")
            welcome()
        }
    }

}