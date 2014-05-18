Sub Main()
	port = CreateObject("roMessagePort")
	screen = CreateObject("roParagraphScreen")
	screen.SetMessagePort(port)
	screen.SetTitle("example")
	screen.AddParagraph("hello world!")
	screen.Show()
	wait(0, screen.GetMessagePort())
End Sub