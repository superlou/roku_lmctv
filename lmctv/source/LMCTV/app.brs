Sub Main()
	initTheme()

    screen = preShowPosterScreen("", "")
    if screen = invalid then
        print "unexpected error in preShowPosterScreen"
        return
    end if

    showPosterScreen(screen)
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

	screen.SetListStyle("flat-category")
	return screen
End Function

Function showPosterScreen(screen As Object) As Integer
	categoryList = getCategoryList()
	screen.SetListNames(categoryList)
	screen.SetContentList(getShowsForCategoryItem(categoryList[0]))
	screen.Show()

	while true
		msg = wait(0, screen.GetMessagePort())

		if type(msg) = "roPosterScreenEvent" then
			if msg.isScreenClosed() then
				return -1
			else if msg.isListItemSelected() then
				print "Selected live with index"; msg.GetIndex()
				liveVideoSpringboard(msg.GetIndex())
			end if
		end if
	end while
End Function

Function getCategoryList() As Object
	categoryList = CreateObject("roArray", 10, true)
	categoryList = ["Live"]
	return categoryList
End Function

Function getShowsForCategoryItem(cateogry As Object) As Object
	showList = [
		{
			ShortDescriptionLine1: "Local",
			ShortDescriptionLine2: "Original local content",
			SDPosterUrl: "pkg:/images/local.png",
			HDPosterUrl: "pkg:/images/local.png"
		}
		{
			ShortDescriptionLine1: "Municipal",
			ShortDescriptionLine2: "Meetings and event coverage",
			SDPosterUrl: "pkg:/images/municipal.png",
			HDPosterUrl: "pkg:/images/municipal.png"
		}
		{
			ShortDescriptionLine1: "Import",
			ShortDescriptionLine2: "Friends of the station and other communities",
			SDPosterUrl: "pkg:/images/import.png",
			HDPosterUrl: "pkg:/images/import.png"
		}
	]

	return showList
End Function
