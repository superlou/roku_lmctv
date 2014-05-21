Function liveVideoSpringboard(stream) As Integer
	port = CreateObject("roMessagePort")
	screen = CreateObject("roSpringboardScreen")
	screen.SetMessagePort(port)

	o = CreateObject("roAssociativeArray")
	o.Title = stream.title
	o.Description = stream.description
	o.HDPosterUrl = stream.HDPosterUrl
	o.SDPosterUrl = stream.SDPosterUrl

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