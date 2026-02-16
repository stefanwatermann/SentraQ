#tag BuildAutomation
			Begin BuildStepList Linux
				Begin BuildProjectStep Build
				End
				Begin CopyFilesBuildStep CopyReleaseFiles
					AppliesTo = 2
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vRGF0YS8=
					FolderItem = Li4vSHRtbC8=
					FolderItem = Li4vU2VudHJhcUZyb250ZW5kLmNvbmZpZw==
				End
			End
			Begin BuildStepList Mac OS X
				Begin BuildProjectStep Build
				End
				Begin SignProjectStep Sign
				  DeveloperID=
				End
				Begin CopyFilesBuildStep CopyDataFolder
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vRGF0YS8=
				End
				Begin CopyFilesBuildStep CopyHtmlFolder
					AppliesTo = 0
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vSHRtbC8=
				End
				Begin CopyFilesBuildStep CopyDebugConfigFile
					AppliesTo = 1
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vU2VudHJhcUZyb250ZW5kLkRlYnVnLmNvbmZpZw==
				End
				Begin CopyFilesBuildStep CopyReleaseConfigFile
					AppliesTo = 2
					Architecture = 0
					Target = 0
					Destination = 0
					Subdirectory = 
					FolderItem = Li4vU2VudHJhcUZyb250ZW5kLmNvbmZpZw==
				End
			End
			Begin BuildStepList Windows
				Begin BuildProjectStep Build
				End
			End
			Begin BuildStepList Xojo Cloud
				Begin BuildProjectStep Build
				End
			End
#tag EndBuildAutomation
