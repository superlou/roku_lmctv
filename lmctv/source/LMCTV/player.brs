Function playStream(streamData) As Integer
	port = CreateObject("roMessagePort")
	video = CreateObject("roVideoScreen")
	video.setMessagePort(port)

	clip = CreateObject("roAssociativeArray")
	clip.StreamBitrates = [0]
	clip.StreamUrls = [streamData.url]
	clip.StreamQualities = ["SD"]
	clip.StreamFormat = "hls"
	clip.Title = streamData.title
	video.SetContent(clip)

	video.Show()

	while true
		msg = wait(0, video.GetMessagePort())
		if type(msg) = "roVideoScreenEvent" then
			if msg.isScreenClosed() then
				return -1
			end if
		end if
	end while
End Function