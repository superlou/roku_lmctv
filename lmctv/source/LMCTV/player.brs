Function playLiveByListIndex(index) As Integer
	port = CreateObject("roMessagePort")
	video = CreateObject("roVideoScreen")
	video.setMessagePort(port)

	bitrates = [0]
	urls = ["http://media.swagit.com/podcasts/2014/05/15/05152014-3340.h264.mp4"]
	qualities = ["SD"]
	format = "mp4"
	title = "Test Stream"

	clip = CreateObject("roAssociativeArray")
	clip.StreamBitrates = bitrates
	clip.StreamUrls = urls
	clip.StreamQualities = qualities
	clip.StreamFormat = format
	clip.Title = title

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