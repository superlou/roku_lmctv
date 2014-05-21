Sub Main()
	initTheme()

	config = ParseJson(ReadAsciiFile("pkg:/config.json"))

    screen = preShowPosterScreen("", "")
    if screen = invalid then
        print "unexpected error in preShowPosterScreen"
        return
    end if

    showPosterScreen(screen, config)
End Sub

Sub initTheme()
	app = CreateObject("roAppManager")
	theme = CreateObject("roAssociativeArray")

	theme.OverhangOffsetSD_X = "72"
    theme.OverhangOffsetSD_Y = "25"
    theme.OverhangSliceSD = "pkg:/images/overhang_background_slice.png"
    theme.OverhangLogoSD  = "pkg:/images/logo_sd43.png"

    theme.OverhangOffsetHD_X = "123"
    theme.OverhangOffsetHD_Y = "48"
    theme.OverhangSliceHD = "pkg:/images/overhang_background_slice.png"
    theme.OverhangLogoHD  = "pkg:/images/logo_hd.png"

    app.SetTheme(theme)
End Sub

Function preShowPosterScreen(breadA=invalid, breadB=invalid) As Object
	port = CreateObject("roMessagePort")
	screen = CreateObject("roPosterScreen")
	screen.SetMessagePort(port)

	if breadA <> invalid and breadB <> invalid then
		screen.SetBreadcrumbText(breadA, breadB)
	end if

	screen.SetListStyle("arced-portrait")
	return screen
End Function

Function showPosterScreen(screen As Object, config As Object) As Integer
	categoryList = getCategoryList()
	screen.SetListNames(categoryList)
	screen.SetContentList(getShowsForCategoryItem(categoryList[0], config))
	screen.Show()

	while true
		msg = wait(0, screen.GetMessagePort())

		if type(msg) = "roPosterScreenEvent" then
			if msg.isScreenClosed() then
				return -1
			else if msg.isListItemSelected() then
				print "Selected live with index"; msg.GetIndex()
				liveVideoSpringboard(config.live_streams[msg.GetIndex()])
			end if
		end if
	end while
End Function

Function getCategoryList() As Object
	categoryList = CreateObject("roArray", 10, true)
	categoryList = ["Live"]
	return categoryList
End Function

Function getShowsForCategoryItem(cateogry As Object, config as Object) As Object
	return config.live_streams
End Function
