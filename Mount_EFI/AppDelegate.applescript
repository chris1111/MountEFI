--
--  AppDelegate.applescript
--  Mount-EFI
--
--  Created by chris on 2022-03-06.
--
--

script AppDelegate
	property spinner : missing value -- connected to the progress bar
	property animated : false -- keeps track of progress bar animation
	property pathToResources : "NSString"
	
	on Build:sender -- toggle animation
		if animated then
			spinner's stopAnimation:me -- one way
			set animated to false
		else
			tell spinner to startAnimation:me -- another way
			set animated to true
		end if
		display alert "Starting Mount-EFI" buttons ("OK") giving up after 2
		tell application "Mount-EFI"
			activate
		end tell
		delay 1
		set Mydisk to paragraphs of (do shell script "diskutil list")
set Chooser to (count of Mydisk)
try
	set Everydisk to items 2 thru Chooser of Mydisk
	activate
	set DiskList to (choose from list Mydisk with prompt "Choose the EFI partition to mount")
	repeat with Choose in DiskList
		set EFI to (do shell script "diskutil list | grep -m 1" & space & quoted form of Choose & space & "| grep -o 'disk[0-9][a-z][0-9]*'")
		set Verify to false
		set Disk to DiskList as text
		if Disk contains "1:" then
			set Verify to true
		end if
		if Verify is true then
			
			do shell script "diskutil mount /dev/" & EFI with administrator privileges
			delay 1
			display dialog "Mount EFI Partition \"" & EFI & "\"" buttons {"OK"} default button {"OK"} with icon note giving up after 4
		else
			display dialog "You did not select EFI partition" buttons {"Error"} default button {"Error"} with icon note
		end if
	end repeat
	
end try
						do shell script "sleep 2"
		spinner's stopAnimation:me
		delay 1
	end Build:
	on cancel:sender
		quit
	end cancel:
	
	
	on applicationShouldTerminate:sender
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	on applicationWillFinishLaunching:aNotification
		set pathToResources to (current application's class "NSBundle"'s mainBundle()'s resourcePath()) as string
	end applicationWillFinishLaunching:
	
	
	
end script
