struct Messages
{

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

	var otherOptions = """
                         1 -> PrintSlot
                         2 -> InList
                         3 -> OutList
                         4 -> Exit
        """
	var welcome = " -----------------------WELCOME TO AUTO PARKER-----------------------------"

	var thankyou = "  ---------------------  Thank You -----------------------"

	enum input: String{
		case vehicleNumber = "Enter Your Vehicle Number"
		case vehicleName = "Enter Driver Name"
		case registerID = "Enter Your RegisterID"

		static func wrongInput(_ element: String) -> String
		{
			return "Enter proper "+element
		}

	}
}