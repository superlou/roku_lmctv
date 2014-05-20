Function liveVideoSpringboard(index) As Integer
	swagitStreams = CreateObject("roArray", 10, true)
	swagitStreams = [
		{
			url: "http://oflash.dfw.swagit.com/live/lmctvny/live-b-2/playlist.m3u8",
			title: "Local Channel",
			description: "Original content created by inspiring community producers and dedicated volunteers.",
			channels: ["Cablevision 75", "Verizon 36"]
		}
		{
			url: "http://oflash.dfw.swagit.com/live/lmctvny/live-a-2/playlist.m3u8",
			title: "Municipal Channel",
			description: "Meetings and event coverage of the Larchmont and Mamaroneck local government.",
			channels: ["Cablevision 76", "Verizon 35"]
		}
		{
			url: "http://oflash.dfw.swagit.com/live/lmctvny/live-c-2/playlist.m3u8",
			title: "Import Channel",
			description: "Curated programming from friends of the station and other public access communities.",
			channels: ["Cablevision 77", "Verizon 34"]
		}
	]

	stream = swagitStreams[index]

	port = CreateObject("roMessagePort")
	screen = CreateObject("roSpringboardScreen")
	screen.SetMessagePort(port)

	o = CreateObject("roAssociativeArray")
	o.Title = stream.title
	o.Description = stream.description

	o.Actors = CreateObject("roArray", 10, true)
	for each channel in stream.channels
		o.Actors.Push(channel)
	end for

	screen.SetContent(o)
	screen.SetStaticRatingEnabled(false)

	screen.AddButton(0, "Watch Live Stream")

	screen.Show()

	while true
		msg = wait(0, screen.GetMessagePort())

		if type(msg) = "roSpringboardScreenEvent" then
			if msg.isScreenClosed() then
				return -1
			else if msg.isButtonPressed() then
				if msg.GetIndex() = 0 then
					playStream(stream)
				end if
			end if
		end if
	end while
End Function