## My Photography Workflow 
### Built on windows using powershell, exiftool, XnConvert, FreeFileSync, Faststone Image Viewer, DigiKam, Lightroom, Nikon transfer, Microsoft import photos and videos from mobile

Because organyzing photos and videos from diffrent sources (multiple cameras and mobile phones) for those who like taking many photos is complicated, I have prepared this workflow to take advantage of diffrent softwares and end up with an clen library.

First consider the below folder structur for storing the files 

```
C: (script and exeutables)
├───PortableApps
│   └───PhotoWorkflow
│       ├───Arrange_pix.ps1
│       └───Elia_copyrights.txt
└───Program Files
    ├───. . .
    
D: (local machine storage)    
└───Photos
    ├───Import
    │   ├───Nikon Transfer
    │   ├───Mobile Photos
    │   └───Mobile Videos
    ├───Originals
    │   ├───Photos Sorted
    │   │   ├───JPG
    │   │   │   └───YYYY
    │   │   │       └───YYYY-MM
    │   │   └───RAW
    │   │       └───YYYY
    │   │           └───YYYY-MM
    │   └───Videos Sorted
    │       └───YYYY
    │           └───YYYY-MM
    ├───Exports
    │   ├───Lightroom Exports
    │   │   └───(Project Name)
    │   └───Videos Created
    │       └───(Project Name)
    ├───Small Size
    │   ├───Videos transcoded
    │   │   └───YYYY
    │   ├───Photos downsized
    │   │   └───YYYY
    │   │       └───YYYY-MM
    │   └───Sotial media pix
    │       └───YYYY
    │           └───YYYY-MM    
    └───Trash
        ├───Small Pix
        └───Other Files
 
M: (external HDD storage)    
└───Photos
    ├───Hight Resolution
    │   ├───Photos Sorted
    │   │   ├───JPG
    │   │   │   └───YYYY
    │   │   │       └───YYYY-MM
    │   │   └───RAW
    │   │       └───YYYY
    │   │           └───YYYY-MM
    │   ├───Lightroom Exports
    │   │   └───(Project Name)
    │   └───Videos Created
    │       └───(Project Name)
    ├───Low Resolution
    │   ├───Old Library
    │   │       └───(By Albumm Name)
    │   ├───New Library (JPG only includes Lightroom and social)
    │   │   └───YYYY
    │   │       └───YYYY-MM
    │   └───Videos (if TRANSCODED else SORTED)
    │       └───YYYY
    
    
```

Windows powershell script Arrange_pix.ps1
```powershell
#################################################################################
#                                                                               #
# Author    : Elia Harmouche 2017                                               #
# Purpose   : Windows PowerShell script to automate my photography workflow     #
# Software  : ExifTool by Phil Harvey to Read, Write and Edit Meta Information  #
#                                                                               #
#################################################################################

# clear powershell command screen
cls; 
# Set Alias for application and filders and files path
new-alias et "C:\PortableApps\exiftool.exe"
$argfile="C:\PortableApps\Elia_copyrights.txt"
# All photes imported from cameras, phones and SD cards are stored here
$srcfolder="D:\Photos\Photos Nikon Transfer\131\test"
# Final destination for Original photos
$destfolder="D:\Photos\Photos Nikon Transfer\131\test"
$destfolderjpg="D:\Photos\Photos Nikon Transfer\131\test"
$destfolderraw="D:\Photos\Photos Nikon Transfer\131\test"
# Files conditionally moved here to be deleted
$trashfolder="D:\Photos\Photos Nikon Transfer\131\trash"


## Step 2 move whatsapp sent images to destination


## Step 3 move whatsapp received images to destination


## Step 4 move videos


##  delete tumbnails and small junky images
# et -P -m -q -q "-Directory<$trashfolder" -if "$ImageHeight<1000"  $srcfolder
# et -P -m -q -q "-Directory<$trashfolder" -if "$ImageWidth<1000"  $srcfolder
# exiftool -filename -filemodifydate -createdate -r -if '(not $datetimeoriginal) and $filetype eq "JPEG"' 

## Update all copyright information from arguments file and 
## automatically fix any errors in exif data without showing errors
et  -P -F -m -q -q -@ $argfile -sep "; " -struct -overwrite_original -r $srcfolder

## Fill description with Aperture, Shutter speed, ISO, Focal Length, Focus Mode, Flash Mode, White Balance... info
## + Photographer, camera make and model...
# todo

## Use Exiftool to change the system file modification date to match the image createdate:
# exiftool '-filemodifydate<createdate' 
## Fill createdate with filemodifydate if datetimeoriginal empty
# exiftool -createdate<filemodifydate -r -if '(not $datetimeoriginal or ($datetimeoriginal eq "0000:00:00 00:00:00")) and ($filetype eq "JPEG")' .

## Move raw and jpg to apropriate folders and sort and rename by date
et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S" -ext jpg -ext jpeg -ext gif -ext png -ext mpo $srcfolder
et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S" -ext nef -ext cr2 -ext dng -ext rw2 -ext tif $srcfolder

#et  -P '-TagsList+<${FileName}' $srcfolder


et  -P '-TagsList+<FileName' '-TagsList+<Directory' -overwrite_original -r $srcfolder

##Clear a tag
#et  -P '-TagsList=' $srcfolder


##view tag labels for a group
#et -args -IPTC:* $srcfolder

#et -P '-filename<$CreateDate' -d "D:\Photos\Photos Nikon Transfer\131\test%y%m%d_%H%M%S%%-c.%%le"  $srcfolder

# WORKINGGG!!!!
#et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "D:\Photos\Photos Nikon Transfer\131\test\%Y\%Y%m\%Y%m%d-%H%M%S"   $srcfolder

#C:\PortableApps\exiftool.exe -P '-filename<${CreateDate}-${make}-${filename}%-c.%le' -d "%Y%m%d-%H%M%S"   $srcfolder

# WORKINGGG!!!! FINAL :)
#et -P '-filename<${CreateDate}-${make}-${filenumber}%-c.%le' -d "${destfolder}\%Y\%Y%m\%Y%m%d_%H%M%S"   $srcfolder


et -P -TagsList  $srcfolder


```

arguments file Elia_copyrights.txt
```powershell
-d
%Y
#Camera owner:
-OwnerName=Elia Harmouche

#Photographer's name: 
-IFD0:Artist=Elia Harmouche
-IPTC:By-line=Elia Harmouche
-XMP-dc:Creator=Elia Harmouche 


#Photographer's title:
-IPTC:By-lineTitle=Engineer
-XMP-photoshop:AuthorsPosition=Engineer

#Desired credit line:
-XMP-photoshop:Credit=Elia Harmouche

#Contact information — essential to avoid creating orphaned works:
-IPTC:Contact=email: eliaharm@gmail.com; website: http://eliaharm.com
-XMP-iptcCore:CreatorWorkEmail=eliaharm@gmail.com
-XMP-iptcCore:CreatorWorkURL=http://eliaharm.com

#Copyright information:
-IFD0:Copyright<Copyright © $createdate Elia Harmouche, all rights reserved.
-IPTC:CopyrightNotice<Copyright © $createdate Elia Harmouche, all rights reserved.
-XMP-dc:Rights<Copyright © $createdate Elia Harmouche, all rights reserved.
-XMP-xmpRights:UsageTerms=For consideration only, no reproduction without prior permission
 
```
